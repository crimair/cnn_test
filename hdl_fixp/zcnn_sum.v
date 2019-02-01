//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_sum
(/*AUTOARG*/
// Outputs
en_out, d_out, en_dx, ren_dx,
// Inputs
resb, clk, dx_on, d0_on, d1_on, d2_on, d3_on, en_in, dx_in, d0_in,
d1_in, d2_in, d3_in, vp_in
);

input wire         resb;
input wire         clk;
input wire         dx_on;
input wire         d0_on;
input wire         d1_on;
input wire         d2_on;
input wire         d3_on;
input wire         en_in;
input wire [31:0]  dx_in; //fp32bit
input wire [31:0]  d0_in; //fp32bit
input wire [31:0]  d1_in; //fp32bit
input wire [31:0]  d2_in; //fp32bit
input wire [31:0]  d3_in; //fp32bit
output wire        en_out;
output wire [31:0] d_out; //fp32bit

input wire         vp_in;
output wire        en_dx;
output wire        ren_dx;

//mult 6delay
//add  13delay
localparam PIPE = (1*3);
reg [PIPE-1:0] en_dly;
integer        i;
always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        en_dly <= 0;
    end
    else begin
        en_dly <= {en_dly[PIPE-2:0], en_in};
    end
end
assign en_out = en_dly[PIPE-1];

localparam PIPE2 = (1*2) - 1;
assign en_dx = en_dly[PIPE2-1];
reg [1:0] rencnt;
always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        rencnt <= 0;
    end
    else begin
        if (vp_in) begin
            rencnt <= 0;
        end
        else begin
            if (en_dx) begin
                rencnt <= rencnt + 1;
            end
        end
    end
end
assign ren_dx = (rencnt==0 & en_dly[PIPE2-1]);

wire [31:0] a01;
wire [31:0] a23;
wire [31:0] a0123;
/*fd_add_32x32 AUTO_TEMPLATE(
 .clock (clk),
 .dataa ((d@"(substring vl-cell-name 7 8)"_on) ? d@"(substring vl-cell-name 7 8)"_in[] : 32'd0),
 .datab ((d@"(substring vl-cell-name 8 9)"_on) ? d@"(substring vl-cell-name 8 9)"_in[] : 32'd0),
 .result(a@"(substring vl-cell-name 7 9)"[]),
 );
*/
fd_add_32x32 fd_add_01(/*AUTOINST*/
                       // Outputs
                       .result          (a01[31:0]),             // Templated
                       // Inputs
                       .clock           (clk),                   // Templated
                       .dataa           ((d0_on) ? d0_in[31:0] : 32'd0), // Templated
                       .datab           ((d1_on) ? d1_in[31:0] : 32'd0)); // Templated
fd_add_32x32 fd_add_23(/*AUTOINST*/
                       // Outputs
                       .result          (a23[31:0]),             // Templated
                       // Inputs
                       .clock           (clk),                   // Templated
                       .dataa           ((d2_on) ? d2_in[31:0] : 32'd0), // Templated
                       .datab           ((d3_on) ? d3_in[31:0] : 32'd0)); // Templated
/*fd_add_32x32 AUTO_TEMPLATE(
 .clock (clk),
 .dataa (a@"(substring vl-cell-name 7 9)"[]),
 .datab (a@"(substring vl-cell-name 9 11)"[]),
 .result(a@"(substring vl-cell-name 7 11)"[]),
 );
*/
fd_add_32x32 fd_add_0123(/*AUTOINST*/
                         // Outputs
                         .result                (a0123[31:0]),   // Templated
                         // Inputs
                         .clock                 (clk),           // Templated
                         .dataa                 (a01[31:0]),     // Templated
                         .datab                 (a23[31:0]));     // Templated

//assign d_out = a0123;

/*fd_add_32x32 AUTO_TEMPLATE(
 .clock (clk),
 .dataa (a@"(substring vl-cell-name 7 11)"[]),
 .datab ((dx_on) ? dx_in[] : 32'd0),
 .result(d_out[]),
 );
*/
fd_add_32x32 fd_add_0123x(/*AUTOINST*/
                          // Outputs
                          .result               (d_out[31:0]),   // Templated
                          // Inputs
                          .clock                (clk),           // Templated
                          .dataa                (a0123[31:0]),   // Templated
                          .datab                ((dx_on) ? dx_in[31:0] : 32'd0)); // Templated


endmodule // zx_fil_3x3

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
