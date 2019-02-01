//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_read_mif
(/*AUTOARG*/
// Outputs
vp_out, en_out, ven_out, d_out, read_end_tgl, mem_read, mem_address,
mem_burstcount,
// Inputs
resb, clk, read_start, read_address, read_xsize, read_ysize, vp_in,
en_in, ren_in, ven_in, mem_clk, mem_waitrequest, mem_readdatavalid,
mem_readdata
);

input wire         resb;
input wire         clk;
input wire         read_start;
input wire [31:0]  read_address;
input wire [15:0]  read_xsize;
input wire [15:0]  read_ysize;
input wire         vp_in;
input wire         en_in;
input wire         ren_in;
input wire         ven_in;
output wire        vp_out;
output wire        en_out;
output wire        ven_out;
output wire [31:0] d_out; //fp32bit

output wire        read_end_tgl;

input wire         mem_clk;
output wire        mem_read;
output wire [25:0] mem_address;
output wire [7:0]  mem_burstcount; //16burst fix
input wire         mem_waitrequest;
input wire         mem_readdatavalid;
input wire [127:0] mem_readdata;

localparam burstc  = 16;
assign mem_burstcount = burstc; //16burst fix

wire [31:0] psize;
wire [25:0] psize_max;

assign psize = read_xsize * read_ysize;
//assign psize_max = psize[31:6] - 1 + ((psize[5:0]!=0) ? 1 : 0); //4pack
assign psize_max = psize[31:2] - 1 + ((psize[1:0]!=0) ? 1 : 0); //4pack

wire       fifo_wfull;

reg [3:0]  rstat;
reg        fifo_reset;
reg        mread;
reg [25:0] madr;
reg [25:0] mcnt;
reg [ 5:0] bcnt;
reg [2:0]  read_start_d;
reg        mread_end_tgl;
localparam P_IDLE   = 0;
localparam P_START  = 1;
localparam P_COLOR  = 2;
localparam P_RESET1 = 3;
localparam P_RESET2 = 4;
localparam P_RESET3 = 5;
localparam P_MREAD  = 6;
always @ (posedge mem_clk or negedge resb) begin
    if (!resb) begin
        read_start_d  <= 0;
        rstat         <= P_IDLE;
        mread         <= 0;
        madr          <= 0;
        mcnt          <= 0;
        bcnt          <= 1;
        mread_end_tgl <= 0;
        fifo_reset    <= 0;
    end
    else begin
        read_start_d <= {read_start_d[1:0] , read_start};
        case (rstat)
            P_IDLE : begin
                if (read_start_d[2:1]==1) begin
                    rstat <= P_START;
                end
                mread      <= 0;
                madr       <= 0;
                mcnt       <= 0;
                bcnt       <= 1;
                fifo_reset <= 0;
            end
            P_START : begin
                mread <= 0;
                madr  <= 0;
                rstat <= P_RESET1;
                mcnt  <= 0;
                bcnt       <= 1;
            end
            P_RESET1 : begin
                if (mcnt>=3) begin
                    mcnt  <= 0;
                    rstat <= P_RESET2;
                end
                else begin
                    mcnt <= mcnt + 1;
                end
                mread      <= 0;
                madr       <= 0;
                bcnt       <= 1;
                fifo_reset <= 1;
            end // case: P_RESET1
            P_RESET2 : begin
                if (mcnt==7) begin
                    rstat <= P_RESET3;
                    mcnt <= 0;
                end
                else begin
                    mcnt <= mcnt + 1;
                end
                mread      <= 0;
                madr       <= 0;
                bcnt       <= 1;
                fifo_reset <= 1;
            end
            P_RESET3 : begin
                if (mcnt==7) begin
                    rstat <= P_MREAD;
                    mcnt  <= 0;
                    mread <= (bcnt==1);
                    madr  <= read_address[25:0];
                    if (bcnt==burstc) begin
                        bcnt <= 1;
                    end
                    else begin
                        bcnt   <= bcnt + 1;
                    end
                end
                else begin
                    mcnt <= mcnt + 1;
                end
                fifo_reset <= 0;
            end
            P_MREAD : begin
                if (mread & mem_waitrequest) begin
                    mread <= mread;
                end
                else if (fifo_wfull) begin
                    mread <= 0;
                end
                else begin
                    if (mcnt>=psize_max) begin
                        if (bcnt!=1) begin
                            mread         <= 0;
                            rstat         <= P_IDLE;
                            mcnt          <= 0;
                            mread_end_tgl <= ~mread_end_tgl ;
                        end
                    end
                    else begin
                        madr      <= madr + 1; //1burst fix
                        mcnt      <= mcnt + 1;
                        mread     <= (bcnt==1);
                    end // else: !if(scnt==mem_rcnt_max_burst)

                    if (bcnt==burstc) begin
                        bcnt <= 1;
                    end
                    else begin
                        bcnt   <= bcnt + 1;
                    end
                end
                fifo_reset <= 0;
            end // case: P_MREAD
            default : begin
                rstat      <= P_IDLE;
                mread      <= 0;
                madr       <= 0;
                mcnt       <= 0;
                fifo_reset <= 0;
            end
        endcase // case (rstat)
    end // else: !if(!resb)
end // always @ (posedge mem_clk or negedge resb)
assign mem_read = mread;
assign mem_address = madr;

assign read_end_tgl = mread_end_tgl;

//async fifo
wire         fifo_ren;
wire [127:0] fifo_rdat;
wire         fifo_empty;
wire [10:0]   wrusedw;


async_fifo_128x2048 c_fifo
(
 .aclr    (fifo_reset),
 .wrclk   (mem_clk),
 .wrreq   (mem_readdatavalid),
 .data    (mem_readdata),
 .rdclk   (clk),
 .rdreq   (fifo_ren),
 .q       (fifo_rdat),
 .rdempty (fifo_empty),
 .wrusedw (wrusedw),
 .wrfull  ()
 );
assign fifo_wfull = wrusedw[10];
//

assign fifo_ren = ren_in & read_start_d[2];

reg         dvp;
reg         den;
reg         dven;
reg [127:0] dout;
always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        dvp  <= 0;
        den  <= 0;
        dven <= 0;
        dout <= 0;
    end
    else begin
        dvp  <= vp_in & read_start_d[2];
        den  <= en_in & read_start_d[2];
        dven <= ven_in & read_start_d[2];
        dout <= (fifo_ren & read_start_d[2]) ? fifo_rdat : {32'd0,dout[127:32]};
    end // else: !if(!resb)
end // always @ (posedge clk or negedge resb)
assign vp_out  = dvp;
assign en_out  = den;
assign ven_out = dven;
assign d_out   = dout[31:0];

endmodule // zcnn_read_mif

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
