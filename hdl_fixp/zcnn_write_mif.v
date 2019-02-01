//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_write_mif
(/*AUTOARG*/
// Outputs
write_end_tgl, mem_write, mem_address, mem_writedata, mem_burstcount,
// Inputs
resb, clk, write_start, write_address, write_xsize, write_ysize,
en_in, d_in, mem_clk, mem_waitrequest
);

input wire          resb;
input wire          clk;
input wire          write_start;
input wire [31:0]   write_address;
input wire [15:0]   write_xsize;
input wire [15:0]   write_ysize;
output wire         write_end_tgl;
input wire          en_in;
input wire [31:0]   d_in; //fp32bit
input wire          mem_clk;
output wire         mem_write;
output wire [25:0]  mem_address;
output wire [127:0] mem_writedata;
input wire          mem_waitrequest;
output wire [7:0]   mem_burstcount;

assign  mem_burstcount = 16;

reg [2:0]           write_start_d;
reg                 wstart_tgl;
reg [1:0]           wstat;
reg [31:0]          wcnt;
reg [1:0]           wpack;
reg                 wpack_en;
reg [127:0]         wpack_data;
reg                 wend_tgl;
reg                 wbusy;

localparam IDLE     = 0;
localparam WRITE    = 1;
localparam PRE_WEND = 2;
localparam WEND     = 3;

wire [31:0] wcnt_max;
wire [31:0] wcnt_max_rem;
assign wcnt_max = write_xsize * write_ysize - 1;
assign wcnt_max_rem = (wcnt_max[1:0]==0) ? 3 :
                      (wcnt_max[1:0]==1) ? 2 :
                      (wcnt_max[1:0]==2) ? 1 :
                      (wcnt_max[1:0]==3) ? 0 : 0;

always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        write_start_d <= 0;
        wstart_tgl    <= 0;
        wstat         <= IDLE;
        wpack         <= 0;
        wpack_en      <= 0;
        wpack_data    <= 0;
        wend_tgl      <= 0;
        wbusy         <= 0;
    end
    else begin
        write_start_d <= {write_start_d[1:0] , write_start};
        wbusy         <= (wstat!=IDLE);

        case (wstat)
            IDLE : begin
                if (write_start_d[2:1]==1) begin
                    wstat <= WRITE;
                    wstart_tgl <= ~wstart_tgl ;
                    wcnt  <= 0;
                end
                wpack      <= 0;
                wpack_en   <= 0;
                wpack_data <= 0;
            end
            WRITE : begin
                if (en_in) begin
                    if (wcnt>=wcnt_max) begin
                        if (wcnt_max_rem!=0) begin
                            wstat <= WEND;
                        end
                        else begin
                            wstat <= PRE_WEND;
                        end
                        wcnt <= 0;
                    end
                    else begin
                        wcnt <= wcnt + 1;
                    end
                    wpack      <= wpack + 1;
                    wpack_en   <= &wpack;
                    wpack_data <= {d_in,wpack_data[127:32]};
                end // if (en_in)
                else begin
                    wpack_en   <= 0;
                end // else: !if(en_in)
            end // case: WRITE
            PRE_WEND : begin
                if (1) begin
                    if (wcnt>=wcnt_max_rem) begin
                        wstat <= WEND;
                        wcnt  <= 0;
                    end
                    else begin
                        wcnt <= wcnt + 1;
                    end
                    wpack      <= wpack + 1;
                    wpack_en   <= &wpack;
                    wpack_data <= {32'd0,wpack_data[127:32]};
                end // if (en_in)
                else begin
                    wpack_en   <= 0;
                end // else: !if(en_in)
            end // case: WRITE
            WEND : begin
                wstat    <= IDLE;
                wcnt     <= 0;
                wpack_en <= 0;
                wend_tgl <= ~wend_tgl ;
            end
            default : begin
                wstat      <= IDLE;
                wpack      <= 0;
                wpack_en   <= 0;
                wpack_data <= 0;
            end
        endcase // case (wstat)
    end // else: !if(!resb)
end // always @ (posedge clk or negedge resb)

wire         fifo_empty;
wire         fifo_ren;
wire [127:0] fifo_rdat;

//async fifo
async_fifo_128x32 c_fifo
(
 .aclr    (1'b0),
 .data    (wpack_data),
 .rdclk   (mem_clk),
 .rdreq   (fifo_ren),
 .wrclk   (clk),
 .wrreq   (wpack_en ),
 .q       (fifo_rdat),
 .rdempty (fifo_empty),
 .wrfull  ()
 );
assign fifo_ren = ~fifo_empty;
//

reg [2:0]    wstart_tgl_d;
wire         wstart_reset;
wire [127:0] rdat;
reg [8:0]    wptr;
reg [8:0]    rptr;
wire         pre_ren;
reg [2:0]    wend_tgl_d;
reg          wend_mem;
wire [8:0]   usedw;

assign wstart_reset = ^wstart_tgl_d[2:1];
always @ (posedge mem_clk or negedge resb) begin
    if (!resb) begin
        wstart_tgl_d <= 0;
        wptr         <= 0;
        rptr         <= 0;
        wend_mem     <= 0;
    end
    else begin
        wstart_tgl_d <= {wstart_tgl_d[1:0], wstart_tgl} ;
        wend_tgl_d   <= {wend_tgl_d[1:0],wend_tgl};

        if (wstart_reset) begin
            wptr     <= 0;
            rptr     <= 0;
            wend_mem <= 0;
        end
        else begin
            if (^wend_tgl_d[2:1]) begin
                wend_mem <= 1;
            end
            if (fifo_ren) begin
                wptr <= wptr + 1;
            end

            if (pre_ren && (usedw!=0)) begin
                rptr <= rptr + 1;
            end
        end // else: !if(wstart_reset)
    end // else: !if(!resb)
end // always @ (posedge mem_clk or negedge resb)
assign usedw = wptr - rptr;

wire write_req;
assign write_req = (usedw>=16) | (usedw!=0 & wend_mem);

reg         mem_wen;
reg [25:0]  mem_addr;
reg [127:0] mem_wdat;

reg [1:0] mstat;
reg [3:0] mcnt;
localparam P_IDLE = 0;
localparam P_WRIT = 1;
always @ (posedge mem_clk or negedge resb) begin
    if (!resb) begin
        mem_wen  <= 0;
        mem_wdat <= 0;
        mem_addr <= 0;
        mstat    <= P_IDLE;
        mcnt     <= 0;
    end
    else begin

        //frame buffer control
        if (wstart_reset) begin
            mem_addr <= write_address;
        end
        else begin
            if (mem_wen && !mem_waitrequest) begin
                mem_addr <= mem_addr + 1;
            end
        end

        //mem fix 16burst
        case(mstat)
            P_IDLE : begin
                if (write_req) begin
                    mstat <= P_WRIT;
                end
                else begin
                    mstat <= P_IDLE;
                end
                mem_wen <= 0;
                mcnt    <= 0;
            end
            P_WRIT : begin
                if (mem_wen & mem_waitrequest) begin
                    mem_wen <= mem_wen;
                end
                else begin
                    if (mcnt==15) begin
                        if (write_req) begin
                            mstat <= P_WRIT;
                        end
                        else begin
                            mstat <= P_IDLE;
                        end
                        mcnt <= 0;
                    end
                    else begin
                        mcnt <= mcnt + 1;
                    end // else: !if(mcnt==15)
                    mem_wen  <= 1;
                    mem_wdat <= rdat;
                end // else: !if(mem_wen & mem_waitrequest)
            end // case: P_WRIT
        endcase // case (mstat)
    end // else: !if(!resb)
end // always @ (posedge clk or negedge resb)
assign pre_ren = (mstat==P_IDLE && write_req) |
                 (mstat==P_WRIT && (mcnt<15 | write_req) && (!(mem_wen && mem_waitrequest)));

assign mem_write     = mem_wen;
assign mem_address   = mem_addr;
assign mem_writedata = mem_wdat;

assign write_end_tgl = wend_tgl;

/*zcnn_write_mif_buffer AUTO_TEMPLATE(
 .rdat      (rdat),
 .wclk      (mem_clk),
 .wen       (fifo_ren),
 .wadr      (wptr[7:0]),
 .wdat      (fifo_rdat),
 .rclk      (mem_clk),
 .ren       (pre_ren),
 .radr      (rptr[7:0]),
 );
 */
zcnn_write_mif_buffer c_ram
(/*AUTOINST*/
 // Outputs
 .rdat                                  (rdat),                  // Templated
 // Inputs
 .wclk                                  (mem_clk),               // Templated
 .wen                                   (fifo_ren),              // Templated
 .wadr                                  (wptr[7:0]),             // Templated
 .wdat                                  (fifo_rdat),             // Templated
 .rclk                                  (mem_clk),               // Templated
 .ren                                   (pre_ren),               // Templated
 .radr                                  (rptr[7:0]));             // Templated

endmodule // zx_write_mif

module zcnn_write_mif_buffer (
/*AUTOARG*/
// Outputs
rdat,
// Inputs
wclk, wen, wadr, wdat, rclk, ren, radr
);

parameter FIFO_DEPTH_BIT = 8;
parameter DATA_BIT_WIDTH = 128;

input wire                       wclk;
input wire                       wen;
input wire [FIFO_DEPTH_BIT-1:0]  wadr;
input wire [DATA_BIT_WIDTH-1:0]  wdat;
input wire                       rclk;
input wire                       ren;
input wire [FIFO_DEPTH_BIT-1:0]  radr;
output wire [DATA_BIT_WIDTH-1:0] rdat;

dp_128x256 mem(
.data      (wdat),
.wrclock   (wclk),
.rdclock   (rclk),
.rdaddress (radr),
.rden      (ren),
.wraddress (wadr),
.wren      (wen),
.q         (rdat)
);

endmodule // zcnn_write_mif_buffer
//synopsys translate_off
`default_nettype wire
//synopsys translate_on
