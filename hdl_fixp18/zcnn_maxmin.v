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
input wire [17:0]  bias_in;
input wire         en_in;
input wire [17:0]  d_in; //fp32bit
output wire        en_out;
output wire [17:0] d_out; //fp32bit

//mult 6delay
//add  13delay
localparam PIPE = (2)+2;
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
wire [17:0] bias_out;
wire [17:0] calc_bias;
assign calc_bias = (maxmin_on) ?
                   bias_in : //
                   18'h00000;  //0.0

/*fd_add_18x18 AUTO_TEMPLATE(
 .clock  (clk),
 .dataa  (d_in),
 .datab  (calc_bias),
 .result (bias_out),
 );
*/
fd_add_18x18 fd_add_bias (/*AUTOINST*/
                          // Outputs
                          .result               (bias_out),      // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d_in),          // Templated
                          .datab                (calc_bias));     // Templated

//minus 0.1
wire [17:0] calc_0p1;
assign calc_0p1 = (bias_out[17] && maxmin_on) ?
                  18'h01999 : //0.1
                  18'h10000;  //1.0

/*fd_mult_18x18 AUTO_TEMPLATE(
 .clock  (clk),
 .dataa  (bias_out),
 .datab  (calc_0p1),
 .result (d_out),
 );
*/
fd_mult_18x18 fd_mult_0p1 (/*AUTOINST*/
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
