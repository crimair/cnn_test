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
reg [2:0]  scnt;
reg [15:0] xcnt;
reg [15:0] ycnt;
reg [25:0] dcnt;
localparam TG_IDLE    = 0;
localparam TG_DELAY   = 1;
localparam TG_READ    = 2;
localparam TG_PUSH    = 3;
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
        den          <= (stat==TG_READ);
        ren          <= (stat==TG_READ && scnt==0);
        dven         <= (stat==TG_READ) || (stat==TG_PUSH);

        if (stat==TG_READ) begin
            if (scnt==6) begin
                scnt <= 0;
            end
            else begin
                scnt <= scnt + 1;
            end
        end
        else begin
            scnt <= 0;
        end

        case (stat)
            TG_IDLE : begin
                if (read_start_x[2:1]==1) begin
                    stat <= TG_DELAY;
                end
                xcnt <= 1;
                ycnt <= 1;
                dcnt <= 0;
            end
            TG_DELAY : begin
                if (dcnt >= delay_max) begin
                    stat <= TG_READ;
                    xcnt <= 1;
                    ycnt <= 1;
                    dcnt <= 0;
                end
                else begin
                    dcnt <= dcnt + 1;
                end
            end // case: TG_DELAY
            TG_READ : begin
                if (xcnt>=read_xsize) begin
                    xcnt <= 1;
                    if (ycnt>=read_ysize) begin
                        ycnt <= 1;
                        stat <= TG_PUSH;
                    end
                    else begin
                        ycnt <= ycnt + 1;
                    end
                end
                else begin
                    xcnt <= xcnt + 1;
                end
            end
            TG_PUSH : begin
                if (xcnt>=read_xsize) begin
                    stat    <= TG_IDLE;
                    end_tgl <= ~end_tgl;
                    xcnt    <= 1;
                end
                else begin
                    xcnt <= xcnt + 1;
                end
            end
            default  : begin
                stat <= TG_IDLE;
                xcnt <= 1;
                ycnt <= 1;
                dcnt <= 1;
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
