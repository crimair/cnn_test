//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_fil_3x3
(/*AUTOARG*/
// Outputs
en_out, d_out,
// Inputs
resb, clk, en_in, d00_in, d01_in, d02_in, d10_in, d11_in, d12_in,
d20_in, d21_in, d22_in, w00_in, w01_in, w02_in, w10_in, w11_in,
w12_in, w20_in, w21_in, w22_in
);

input wire         resb;
input wire         clk;
input wire         en_in;
/* //input data matrix
 (d00 , d01 , d02)
 (d10 , d11 , d12)
 (d20 , d21 , d22)
 */
input wire [31:0]  d00_in; //fp32bit
input wire [31:0]  d01_in; //fp32bit
input wire [31:0]  d02_in; //fp32bit
input wire [31:0]  d10_in; //fp32bit
input wire [31:0]  d11_in; //fp32bit
input wire [31:0]  d12_in; //fp32bit
input wire [31:0]  d20_in; //fp32bit
input wire [31:0]  d21_in; //fp32bit
input wire [31:0]  d22_in; //fp32bit
/* //weight parameter matrix
 (d00 , d01 , d02)
 (d10 , d11 , d12)
 (d20 , d21 , d22)
 */
input wire [31:0]  w00_in; //fp32bit
input wire [31:0]  w01_in; //fp32bit
input wire [31:0]  w02_in; //fp32bit
input wire [31:0]  w10_in; //fp32bit
input wire [31:0]  w11_in; //fp32bit
input wire [31:0]  w12_in; //fp32bit
input wire [31:0]  w20_in; //fp32bit
input wire [31:0]  w21_in; //fp32bit
input wire [31:0]  w22_in; //fp32bit

output wire        en_out;
output wire [31:0] d_out; //fp32bit

//mult 6delay
//add  10delay
localparam PIPE = 6+(13*4);
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

wire [31:0]  mq00; //fp32bit
wire [31:0]  mq01; //fp32bit
wire [31:0]  mq02; //fp32bit
wire [31:0]  mq10; //fp32bit
wire [31:0]  mq11; //fp32bit
wire [31:0]  mq12; //fp32bit
wire [31:0]  mq20; //fp32bit
wire [31:0]  mq21; //fp32bit
wire [31:0]  mq22; //fp32bit
/*fp_mult_32x32 AUTO_TEMPLATE(
 .clock  (clk),
 .dataa  (d@"(substring vl-cell-name 8 10)"_in[]),
 .datab  (w@"(substring vl-cell-name 8 10)"_in[]),
 .result (mq@"(substring vl-cell-name 8 10)"[]),
 );
*/
fp_mult_32x32 fp_mult_00 (/*AUTOINST*/
                          // Outputs
                          .result               (mq00[31:0]),    // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d00_in[31:0]),  // Templated
                          .datab                (w00_in[31:0]));  // Templated
fp_mult_32x32 fp_mult_01 (/*AUTOINST*/
                          // Outputs
                          .result               (mq01[31:0]),    // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d01_in[31:0]),  // Templated
                          .datab                (w01_in[31:0]));  // Templated
fp_mult_32x32 fp_mult_02 (/*AUTOINST*/
                          // Outputs
                          .result               (mq02[31:0]),    // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d02_in[31:0]),  // Templated
                          .datab                (w02_in[31:0]));  // Templated
fp_mult_32x32 fp_mult_10 (/*AUTOINST*/
                          // Outputs
                          .result               (mq10[31:0]),    // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d10_in[31:0]),  // Templated
                          .datab                (w10_in[31:0]));  // Templated
fp_mult_32x32 fp_mult_11 (/*AUTOINST*/
                          // Outputs
                          .result               (mq11[31:0]),    // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d11_in[31:0]),  // Templated
                          .datab                (w11_in[31:0]));  // Templated
fp_mult_32x32 fp_mult_12 (/*AUTOINST*/
                          // Outputs
                          .result               (mq12[31:0]),    // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d12_in[31:0]),  // Templated
                          .datab                (w12_in[31:0]));  // Templated
fp_mult_32x32 fp_mult_20 (/*AUTOINST*/
                          // Outputs
                          .result               (mq20[31:0]),    // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d20_in[31:0]),  // Templated
                          .datab                (w20_in[31:0]));  // Templated
fp_mult_32x32 fp_mult_21 (/*AUTOINST*/
                          // Outputs
                          .result               (mq21[31:0]),    // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d21_in[31:0]),  // Templated
                          .datab                (w21_in[31:0]));  // Templated
fp_mult_32x32 fp_mult_22 (/*AUTOINST*/
                          // Outputs
                          .result               (mq22[31:0]),    // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (d22_in[31:0]),  // Templated
                          .datab                (w22_in[31:0]));  // Templated

wire [31:0] mqXX;
wire [31:0] aXXXX;
wire [31:0] aXXXXXXXX;
assign mqXX = 0;
assign aXXXX = 0;
assign aXXXXXXXX = 0;
wire [31:0] a0001;
wire [31:0] a0210;
wire [31:0] a1112;
wire [31:0] a2021;
wire [31:0] a22XX;
wire [31:0] a00010210;
wire [31:0] a11122021;
wire [31:0] a22XXXXXX;
wire [31:0] a0001021011122021;
wire [31:0] a22XXXXXXXXXXXXXX;
//wire [31:0] a000102101112202122XXXXXXXXXXXXXX;

/*fp_add_32x32 AUTO_TEMPLATE(
 .clock (clk),
 .dataa (mq@"(substring vl-cell-name 7 9)"[]),
 .datab (mq@"(substring vl-cell-name 9 11)"[]),
 .result(a@"(substring vl-cell-name 7 11)"[]),
 );
*/
fp_add_32x32 fp_add_0001(/*AUTOINST*/
                         // Outputs
                         .result                (a0001[31:0]),   // Templated
                         // Inputs
                         .clock                 (clk),           // Templated
                         .dataa                 (mq00[31:0]),    // Templated
                         .datab                 (mq01[31:0]));    // Templated
fp_add_32x32 fp_add_0210(/*AUTOINST*/
                         // Outputs
                         .result                (a0210[31:0]),   // Templated
                         // Inputs
                         .clock                 (clk),           // Templated
                         .dataa                 (mq02[31:0]),    // Templated
                         .datab                 (mq10[31:0]));    // Templated
fp_add_32x32 fp_add_1112(/*AUTOINST*/
                         // Outputs
                         .result                (a1112[31:0]),   // Templated
                         // Inputs
                         .clock                 (clk),           // Templated
                         .dataa                 (mq11[31:0]),    // Templated
                         .datab                 (mq12[31:0]));    // Templated
fp_add_32x32 fp_add_2021(/*AUTOINST*/
                         // Outputs
                         .result                (a2021[31:0]),   // Templated
                         // Inputs
                         .clock                 (clk),           // Templated
                         .dataa                 (mq20[31:0]),    // Templated
                         .datab                 (mq21[31:0]));    // Templated
fp_add_32x32 fp_add_22XX(/*AUTOINST*/
                         // Outputs
                         .result                (a22XX[31:0]),   // Templated
                         // Inputs
                         .clock                 (clk),           // Templated
                         .dataa                 (mq22[31:0]),    // Templated
                         .datab                 (mqXX[31:0]));    // Templated

/*fp_add_32x32 AUTO_TEMPLATE(
 .clock (clk),
 .dataa (a@"(substring vl-cell-name 7 11)"[]),
 .datab (a@"(substring vl-cell-name 11 15)"[]),
 .result(a@"(substring vl-cell-name 7 15)"[]),
 );
*/
fp_add_32x32 fp_add_00010210(/*AUTOINST*/
                             // Outputs
                             .result            (a00010210[31:0]), // Templated
                             // Inputs
                             .clock             (clk),           // Templated
                             .dataa             (a0001[31:0]),   // Templated
                             .datab             (a0210[31:0]));   // Templated
fp_add_32x32 fp_add_11122021(/*AUTOINST*/
                             // Outputs
                             .result            (a11122021[31:0]), // Templated
                             // Inputs
                             .clock             (clk),           // Templated
                             .dataa             (a1112[31:0]),   // Templated
                             .datab             (a2021[31:0]));   // Templated
fp_add_32x32 fp_add_22XXXXXX(/*AUTOINST*/
                             // Outputs
                             .result            (a22XXXXXX[31:0]), // Templated
                             // Inputs
                             .clock             (clk),           // Templated
                             .dataa             (a22XX[31:0]),   // Templated
                             .datab             (aXXXX[31:0]));   // Templated

/*fp_add_32x32 AUTO_TEMPLATE(
 .clock (clk),
 .dataa (a@"(substring vl-cell-name 7 15)"[]),
 .datab (a@"(substring vl-cell-name 15 23)"[]),
 .result(a@"(substring vl-cell-name 7 23)"[]),
 );
*/
fp_add_32x32 fp_add_0001021011122021(/*AUTOINST*/
                                     // Outputs
                                     .result            (a0001021011122021[31:0]), // Templated
                                     // Inputs
                                     .clock             (clk),           // Templated
                                     .dataa             (a00010210[31:0]), // Templated
                                     .datab             (a11122021[31:0])); // Templated
fp_add_32x32 fp_add_22XXXXXXXXXXXXXX(/*AUTOINST*/
                                     // Outputs
                                     .result            (a22XXXXXXXXXXXXXX[31:0]), // Templated
                                     // Inputs
                                     .clock             (clk),           // Templated
                                     .dataa             (a22XXXXXX[31:0]), // Templated
                                     .datab             (aXXXXXXXX[31:0])); // Templated


/*fp_add_32x32 AUTO_TEMPLATE(
 .clock (clk),
 .dataa (a@"(substring vl-cell-name 7 23)"[]),
 .datab (a@"(substring vl-cell-name 23 39)"[]),
 .result(d_out[]),
 );
*/
// .result(a@"(substring vl-cell-name 7 39)"[]),
fp_add_32x32 fp_add_000102101112202122XXXXXXXXXXXXXX(/*AUTOINST*/
                                                     // Outputs
                                                     .result            (d_out[31:0]),   // Templated
                                                     // Inputs
                                                     .clock             (clk),           // Templated
                                                     .dataa             (a0001021011122021[31:0]), // Templated
                                                     .datab             (a22XXXXXXXXXXXXXX[31:0])); // Templated

endmodule // zx_fil_3x3

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
