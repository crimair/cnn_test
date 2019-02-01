//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_maxmin
(/*AUTOARG*/
// Outputs
en_out, d_out,
// Inputs
resb, clk, maxmin_on, bias_in, en_in, d_in
);

input wire         resb;
input wire         clk;
input wire         maxmin_on;
input wire [15:0]  bias_in;
input wire         en_in;
input wire [15:0]  d_in;
output wire        en_out;
output wire [15:0] d_out;

//mult 6delay
//add  13delay
localparam PIPE = (1)+1;
reg [PIPE-1:0] en_dly;
always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        en_dly <= 0;
    end
    else begin
        en_dly <= {en_dly[PIPE-2:0], en_in};
    end
end
assign en_out = en_dly[PIPE-1];

//Bias
wire [15:0] bias_out;
wire [15:0] calc_bias;
assign calc_bias = (maxmin_on) ?
                   bias_in : //
                   16'h0000;  //0.0

/*fd_add_16x16 AUTO_TEMPLATE(
 .clock  (clk),
 .dataa  (d_in),
 .datab  (calc_bias),
 .result (bias_out),
 );
*/
fd_add_16x16 fd_add_bias (/*AUTOINST*/
                          // Outputs
                          .result               (bias_out),      // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d_in),          // Templated
                          .datab                (calc_bias));     // Templated

//minus 0.1
wire [15:0] calc_0p1;
assign calc_0p1 = (bias_out[15] && maxmin_on) ?
                  16'h0666 : //0.1
                  16'h4000;  //1.0

/*fd_mult_16x16 AUTO_TEMPLATE(
 .clock  (clk),
 .dataa  (bias_out),
 .datab  (calc_0p1),
 .result (d_out),
 );
*/
fd_mult_16x16 fd_mult_0p1 (/*AUTOINST*/
                           // Outputs
                           .result              (d_out),         // Templated
                           // Inputs
                           .clock               (clk),           // Templated
                           .dataa               (bias_out),      // Templated
                           .datab               (calc_0p1));      // Templated

endmodule // zcnn_maxmin

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
