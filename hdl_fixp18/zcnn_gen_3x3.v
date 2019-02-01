//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_gen_3x3
(/*AUTOARG*/
// Outputs
en_out, d00_out, d01_out, d02_out, d10_out, d11_out, d12_out, d20_out,
d21_out, d22_out,
// Inputs
resb, clk, read_xsize, read_ysize, vp_in, en_in, ven_in, d_in
);

input wire         resb;
input wire         clk;
input wire [11:0]  read_xsize;
input wire [11:0]  read_ysize;
input wire         vp_in;
input wire         en_in;
input wire         ven_in;
input wire [17:0]  d_in;
output wire        en_out;
output wire [17:0] d00_out;
output wire [17:0] d01_out;
output wire [17:0] d02_out;
output wire [17:0] d10_out;
output wire [17:0] d11_out;
output wire [17:0] d12_out;
output wire [17:0] d20_out;
output wire [17:0] d21_out;
output wire [17:0] d22_out;

wire               ren;
wire               rxf;
wire               rxl;
wire [17:0]        rdat_p;
wire [17:0]        rdat_c;
wire [17:0]        rdat_n;

zcnn_gen_3x3_line c_line
(/*AUTOINST*/
 // Outputs
 .ren                                   (ren),
 .rxf                                   (rxf),
 .rxl                                   (rxl),
 .rdat_p                                (rdat_p[17:0]),
 .rdat_c                                (rdat_c[17:0]),
 .rdat_n                                (rdat_n[17:0]),
 // Inputs
 .resb                                  (resb),
 .clk                                   (clk),
 .read_xsize                            (read_xsize[11:0]),
 .read_ysize                            (read_ysize[11:0]),
 .vp_in                                 (vp_in),
 .en_in                                 (en_in),
 .ven_in                                (ven_in),
 .d_in                                  (d_in[17:0]));

reg        d1_ren;
reg        d2_ren;
reg        en;
reg [17:0] d22;
reg [17:0] d21;
reg [17:0] d20;
reg [17:0] d12;
reg [17:0] d11;
reg [17:0] d10;
reg [17:0] d02;
reg [17:0] d01;
reg [17:0] d00;
always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        d1_ren     <= 0;
        d2_ren     <= 0;
        en         <= 0;
        d22        <= 0;
        d21        <= 0;
        d20        <= 0;
        d12        <= 0;
        d11        <= 0;
        d10        <= 0;
        d02        <= 0;
        d01        <= 0;
        d00        <= 0;
    end // if (!resb)
    else begin
        d1_ren     <= ren;
        d2_ren     <= d1_ren;
//        en         <= ren & d1_ren & d2_ren;
        en         <= d1_ren;
        d00        <= d01;
        d10        <= d11;
        d20        <= d21;
        d01        <= (rxf) ? rdat_p : d02;
        d11        <= (rxf) ? rdat_c : d12;
        d21        <= (rxf) ? rdat_n : d22;
        d02        <= (ren) ? rdat_p : d02;
        d12        <= (ren) ? rdat_c : d12;
        d22        <= (ren) ? rdat_n : d22;
    end // else: !if(!resb)
end // always @ (posedge clk or negedge resb)
assign en_out  = en ;
assign d00_out = d00;
assign d01_out = d01;
assign d02_out = d02;
assign d10_out = d10;
assign d11_out = d11;
assign d12_out = d12;
assign d20_out = d20;
assign d21_out = d21;
assign d22_out = d22;

endmodule // zcnn_gen_3x3

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
