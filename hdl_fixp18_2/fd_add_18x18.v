//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module fd_add_18x18
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

wire signed [18:0] da;
wire signed [18:0] db;
reg signed [18:0] dx;

assign da = {dataa[17],dataa};
assign db = {datab[17],datab};

always @ (posedge clock) begin
    dx <= da + db;
end

reg [17:0] dxr;
always @ (posedge clock) begin
    dxr <= (!dx[18] && (dx[17])) ? 18'h1FFFF : //overflow
           (dx[18] && (~dx[17])) ? 18'h20000 : //underflow
           dx[17:0];
end
assign result = dxr;

endmodule // fd_add_32x32

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
