//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module fd_add_16x16
(/*AUTOARG*/
// Outputs
result,
// Inputs
clock, dataa, datab
);

input wire         clock;
input wire [15:0]  dataa;
input wire [15:0]  datab;
output wire [15:0] result;

wire signed [16:0] da;
wire signed [16:0] db;
wire signed [16:0] dx;

assign da = {dataa[15],dataa};
assign db = {datab[15],datab};
assign dx = da + db;

reg [15:0] dxr;
always @ (posedge clock) begin
    dxr <= (!dx[16] && (dx[15])) ? 16'h7FFF : //overflow
           (dx[16] && (~dx[15])) ? 16'h8000 : //underflow
           dx[15:0];
end
assign result = dxr;

endmodule // fd_add_18x18

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
