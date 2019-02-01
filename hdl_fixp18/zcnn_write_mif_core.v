//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_write_mif_core
(/*AUTOARG*/
// Outputs
fifo_wfull, mem_write, mem_address, mem_writedata, mem_burstcount,
buffer_empty,
// Inputs
resb, clk, write_start, write_address, wen, wdat, mem_clk,
mem_waitrequest
);

input wire          resb;
input wire          clk;
input wire          write_start;
input wire [31:0]   write_address;
input wire          wen;
input wire [127:0]  wdat;
output wire         fifo_wfull;

input wire          mem_clk;
output wire         mem_write;
output wire [25:0]  mem_address;
output wire [127:0] mem_writedata;
input wire          mem_waitrequest;
output wire [7:0]   mem_burstcount;

output wire         buffer_empty;

localparam buffer_full = 192;
localparam burst_length = 16;

assign  mem_burstcount = burst_length;

wire         fifo_ren;
wire [127:0] fifo_rdat;
wire [7:0]   wrusedw;
wire [7:0]   rdusedw;

//async fifo
async_fifo_128x256 c_fifo
(
 .aclr    (~resb),
 .data    (wdat),
 .rdclk   (mem_clk),
 .rdreq   (fifo_ren),
 .wrclk   (clk),
 .wrreq   (wen),
 .q       (fifo_rdat),
 .rdempty (buffer_empty),
 .wrusedw (wrusedw),
 .rdusedw (rdusedw),
 .wrfull  ()
 );
//
assign fifo_wfull = (wrusedw>=buffer_full); //half full

reg [2:0]   write_start_d;
reg         write_reset;
reg         mem_wen;
reg [25:0]  mem_addr;
reg [127:0] mem_wdat;
reg [1:0]   mstat;
reg [3:0]   mcnt;
wire        write_req;
localparam P_IDLE = 0;
localparam P_WRIT = 1;

assign write_req = (rdusedw>=burst_length);
assign fifo_ren = (mem_wen && mem_waitrequest) ? 0 :
                  (mstat==P_WRIT) ? 1 : 0;

always @ (posedge mem_clk or negedge resb) begin
    if (!resb) begin
        write_start_d <= 0;
        write_reset   <= 0;
        mem_wen       <= 0;
        mem_wdat      <= 0;
        mem_addr      <= 0;
        mstat         <= P_IDLE;
        mcnt          <= 0;
    end
    else begin
        write_start_d <= {write_start_d[1:0],write_start};
        write_reset <= (write_start_d[2:1]==1);

        //frame buffer control
        if (write_reset) begin
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
                    if (mcnt==(burst_length-1)) begin
                        mstat <= P_IDLE;
                        mcnt <= 0;
                    end
                    else begin
                        mcnt <= mcnt + 1;
                    end // else: !if(mcnt==15)
                    mem_wen  <= 1;
                    mem_wdat <= fifo_rdat;
                end // else: !if(mem_wen & mem_waitrequest)
            end // case: P_WRIT
        endcase // case (mstat)
    end // else: !if(!resb)
end // always @ (posedge mem_clk or negedge resb)

assign mem_write     = mem_wen;
assign mem_address   = mem_addr;
assign mem_writedata = mem_wdat;

endmodule // zcnn_write_mif

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
