//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module fd_mult_32x32
(/*AUTOARG*/
// Outputs
result,
// Inputs
clock, dataa, datab
);

input wire         clock;
input wire [31:0]  dataa;
input wire [31:0]  datab;
output wire [31:0] result;

wire signed [31:0] da;
wire signed [31:0] db;
wire signed [63:0] dx;

assign da = dataa;
assign db = datab;
assign dx = da * db;

reg [31:0] dxr;
always @ (posedge clock) begin
    dxr <= (!dx[63] && (|dx[62:55])) ? 32'h7FFFFFFF : //overflow
           (dx[63] && (~&dx[62:55])) ? 32'h80000000 : //underflow
           dx[55:24];
end
assign result = dxr;

endmodule // fd_mult_32x32

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
