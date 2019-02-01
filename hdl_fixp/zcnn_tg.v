//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_tg
(/*AUTOARG*/
// Outputs
tg_end_tgl, vp_out, ren_out, en_out, ven_out,
// Inputs
resb, clk, read_start, read_start_delay, read_xsize, read_ysize
);

input wire         resb;
input wire         clk;
input wire         read_start;
input wire [31:0]  read_start_delay;
input wire [15:0]  read_xsize;
input wire [15:0]  read_ysize;
output wire        tg_end_tgl;
output wire        vp_out;
output wire        ren_out;
output wire        en_out;
output wire        ven_out;


reg [2:0]  stat;
reg [2:0]  read_start_x;
reg [1:0]  scnt;
reg [15:0] xcnt;
reg [15:0] ycnt;
localparam TG_IDLE    = 0;
localparam TG_DELAY   = 1;
localparam TG_READ    = 2;
localparam TG_READ_PS = 3;
localparam TG_BP      = 4;
localparam TG_PUSH    = 5;
localparam TG_PUSH_BP = 6;
reg         end_tgl;

wire [31:0] delay_max;
reg         dvp;
reg         ren;
reg         den;
reg         dven;
assign delay_max = read_start_delay;

always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        read_start_x <= 0;
        stat         <= TG_IDLE;
        xcnt         <= 0;
        ycnt         <= 0;
        scnt         <= 0;
        dvp          <= 0;
        ren          <= 0;
        den          <= 0;
        dven         <= 0;
        end_tgl      <= 0;
    end
    else begin
        read_start_x <= {read_start_x[1:0],read_start};
        dvp          <= (read_start_x[2:1]==1);
        den          <= (stat==TG_READ) || (stat==TG_READ_PS);
        ren          <= (stat==TG_READ);
        dven         <= (stat==TG_READ) || (stat==TG_READ_PS) || (stat==TG_PUSH);
        case (stat)
            TG_IDLE : begin
                if (read_start_x[2:1]==1) begin
                    stat <= TG_DELAY;
                end
                scnt <= 0;
                xcnt <= 0;
                ycnt <= 0;
            end
            TG_DELAY : begin
                if ({ycnt,xcnt} >= delay_max) begin
                    stat <= TG_READ;
                    xcnt <= 1;
                    ycnt <= 1;
                end
                else begin
                    {ycnt,xcnt} <= {ycnt,xcnt} + 1;
                end
                scnt <= 0;
            end // case: TG_DELAY
            TG_READ : begin
                stat <= TG_READ_PS;
                scnt <= 1;
                xcnt <= xcnt + 1;
            end
            TG_READ_PS : begin
                scnt <= scnt + 1;
                if (scnt==3) begin
                    if (xcnt>=read_xsize) begin
                        stat <= TG_BP;
                        xcnt <= 1;
                    end
                    else begin
                        stat <= TG_READ;
                        xcnt <= xcnt + 1;
                    end
                end
                else begin
                    xcnt <= xcnt + 1;
                end // else: !if(scnt==3)
            end // case: TG_READ_PS
            TG_BP : begin
                if (xcnt>=6) begin
                    if (ycnt>=read_ysize) begin
                        stat <= TG_PUSH;
                        xcnt <= 1;
                        ycnt <= 1;
                    end
                    else begin
                        stat <= TG_READ;
                        xcnt <= 1;
                        ycnt <= ycnt + 1;
                    end
                end // if (xcnt>=6)
                else begin
                    xcnt <= xcnt + 1;
                end // else: !if(xcnt>=6)
            end // case: TG_BP
            TG_PUSH : begin
                if (xcnt>=read_xsize) begin
                    stat <= TG_PUSH_BP;
                    xcnt <= 1;
                end
                else begin
                    xcnt <= xcnt + 1;
                end
            end
            TG_PUSH_BP : begin
                if (xcnt>=6) begin
                    if (ycnt>=2) begin
                        stat    <= TG_IDLE;
                        xcnt    <= 1;
                        ycnt    <= 1;
                        end_tgl <= ~end_tgl ;
                    end
                    else begin
                        stat <= TG_PUSH;
                        xcnt    <= 1;
                        ycnt <= ycnt + 1;
                    end
                end // if (xcnt>=6)
                else begin
                    xcnt <= xcnt + 1;
                end // else: !if(xcnt>=6)
            end // case: TG_PUSH_BP
            default  : begin
                stat <= TG_IDLE;
                xcnt <= 1;
                ycnt <= 1;
            end
        endcase // case (stat)
    end // else: !if(!resb)
end // always @ (posedge clk or negedge resb)
assign vp_out = dvp;
assign en_out = den;
assign ren_out = ren;
assign ven_out = dven;
assign tg_end_tgl = end_tgl;

endmodule // zcnn_tg

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
