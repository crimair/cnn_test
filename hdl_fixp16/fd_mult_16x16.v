//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module fd_mult_16x16
(/*AUTOARG*/
// Outputs
result,
// Inputs
clock, dataa, datab
);

input wire         clock;
input wire [15:0]  dataa; //S0.14
input wire [15:0]  datab; //S0.14
output wire [15:0] result;

wire signed [15:0] da;
wire signed [15:0] db;
wire signed [31:0] dx;

assign da = dataa;
assign db = datab;
assign dx = da * db;

reg [15:0] dxr;
always @ (posedge clock) begin
    dxr <= (!dx[31] && (|dx[30:29])) ? 16'h7FFF : //overflow
           (dx[31] && (~&dx[30:29])) ? 16'h8000 : //underflow
           dx[29:14];
end
assign result = dxr;

endmodule // fd_mult_16x16

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
