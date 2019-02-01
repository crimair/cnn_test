//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module fd_mult_18x18
(/*AUTOARG*/
// Outputs
result,
// Inputs
clock, dataa, datab
);

input wire         clock;
input wire [17:0]  dataa;
input wire [17:0]  datab;
output wire [17:0] result;

wire signed [17:0] da;
wire signed [17:0] db;
wire signed [35:0] dx;

assign da = dataa;
assign db = datab;
assign dx = da * db;

reg [35:0] dxx;
reg [17:0] dxr;
always @ (posedge clock) begin
    dxx <= dx;
    dxr <= (!dxx[35] && (|dxx[34:33])) ? 18'h1FFFF : //overflow
           (dxx[35] && (~&dxx[34:33])) ? 18'h20000 : //underflow
           dxx[33:16];
end

//reg [17:0] dxr;
//always @ (posedge clock) begin
//    dxr <= (!dx[35] && (|dx[34:33])) ? 18'h1FFFF : //overflow
//           (dx[35] && (~&dx[34:33])) ? 18'h20000 : //underflow
//           dx[33:16];
//end
assign result = dxr;

endmodule // fd_mult_32x32

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
