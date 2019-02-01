//  Last Change:    2015/06/19 21:32:44 (matsukura)
//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_regbank
(/*AUTOARG*/
// Outputs
avl_waitrequest, avl_readdata, avl_readdatavalid, fx_ctrlreg0,
fx_ctrlreg1, fx_ctrlreg2, fx_ctrlreg3, fx_xsize, fx_ysize, fx_w22,
fx_w21, fx_w20, fx_w12, fx_w11, fx_w10, fx_w02, fx_w01, fx_w00,
fx_bias, f0_ctrlreg0, f0_ctrlreg1, f0_ctrlreg2, f0_ctrlreg3, f0_xsize,
f0_ysize, f0_w00, f0_w01, f0_w02, f0_w10, f0_w11, f0_w12, f0_w20,
f0_w21, f0_w22, f0_bias, f1_ctrlreg0, f1_ctrlreg1, f1_ctrlreg2,
f1_ctrlreg3, f1_xsize, f1_ysize, f1_w00, f1_w01, f1_w02, f1_w10,
f1_w11, f1_w12, f1_w20, f1_w21, f1_w22, f1_bias, f2_ctrlreg0,
f2_ctrlreg1, f2_ctrlreg2, f2_ctrlreg3, f2_xsize, f2_ysize, f2_w00,
f2_w01, f2_w02, f2_w10, f2_w11, f2_w12, f2_w20, f2_w21, f2_w22,
f2_bias, f3_ctrlreg0, f3_ctrlreg1, f3_ctrlreg2, f3_ctrlreg3, f3_xsize,
f3_ysize, f3_w00, f3_w01, f3_w02, f3_w10, f3_w11, f3_w12, f3_w20,
f3_w21, f3_w22, f3_bias,
// Inputs
resb, avl_clk, avl_write, avl_read, avl_address, avl_writedata,
avl_byteenable, busy_status, com_ctrlreg1_0_clear_tgl,
fx_ctrlreg0_0_clear_tgl, fx_ctrlreg1_0_clear_tgl,
fx_ctrlreg1_1_clear_tgl, f0_ctrlreg0_0_clear_tgl,
f0_ctrlreg1_0_clear_tgl, f0_ctrlreg1_1_clear_tgl,
f1_ctrlreg0_0_clear_tgl, f1_ctrlreg1_0_clear_tgl,
f1_ctrlreg1_1_clear_tgl, f2_ctrlreg0_0_clear_tgl,
f2_ctrlreg1_0_clear_tgl, f2_ctrlreg1_1_clear_tgl,
f3_ctrlreg0_0_clear_tgl, f3_ctrlreg1_0_clear_tgl,
f3_ctrlreg1_1_clear_tgl
);

input wire         resb ;
input wire         avl_clk ;
input wire         avl_write;
input wire         avl_read;
input wire [9:0]   avl_address;
output wire        avl_waitrequest;
output wire [31:0] avl_readdata;
output wire        avl_readdatavalid;
input wire [31:0]  avl_writedata;
input wire [3:0]   avl_byteenable;

input wire         busy_status;
input wire         com_ctrlreg1_0_clear_tgl;
input wire         fx_ctrlreg0_0_clear_tgl;
input wire         fx_ctrlreg1_0_clear_tgl;
input wire         fx_ctrlreg1_1_clear_tgl;
input wire         f0_ctrlreg0_0_clear_tgl;
input wire         f0_ctrlreg1_0_clear_tgl;
input wire         f0_ctrlreg1_1_clear_tgl;
input wire         f1_ctrlreg0_0_clear_tgl;
input wire         f1_ctrlreg1_0_clear_tgl;
input wire         f1_ctrlreg1_1_clear_tgl;
input wire         f2_ctrlreg0_0_clear_tgl;
input wire         f2_ctrlreg1_0_clear_tgl;
input wire         f2_ctrlreg1_1_clear_tgl;
input wire         f3_ctrlreg0_0_clear_tgl;
input wire         f3_ctrlreg1_0_clear_tgl;
input wire         f3_ctrlreg1_1_clear_tgl;

output wire [31:0] fx_ctrlreg0;
output wire [31:0] fx_ctrlreg1;
output wire [31:0] fx_ctrlreg2;
output wire [31:0] fx_ctrlreg3;
output wire [31:0] fx_xsize;
output wire [31:0] fx_ysize;
output wire [31:0] fx_w22;
output wire [31:0] fx_w21;
output wire [31:0] fx_w20;
output wire [31:0] fx_w12;
output wire [31:0] fx_w11;
output wire [31:0] fx_w10;
output wire [31:0] fx_w02;
output wire [31:0] fx_w01;
output wire [31:0] fx_w00;
output wire [31:0] fx_bias;
output wire [31:0] f0_ctrlreg0;
output wire [31:0] f0_ctrlreg1;
output wire [31:0] f0_ctrlreg2;
output wire [31:0] f0_ctrlreg3;
output wire [31:0] f0_xsize;
output wire [31:0] f0_ysize;
output wire [31:0] f0_w00;
output wire [31:0] f0_w01;
output wire [31:0] f0_w02;
output wire [31:0] f0_w10;
output wire [31:0] f0_w11;
output wire [31:0] f0_w12;
output wire [31:0] f0_w20;
output wire [31:0] f0_w21;
output wire [31:0] f0_w22;
output wire [31:0] f0_bias;
output wire [31:0] f1_ctrlreg0;
output wire [31:0] f1_ctrlreg1;
output wire [31:0] f1_ctrlreg2;
output wire [31:0] f1_ctrlreg3;
output wire [31:0] f1_xsize;
output wire [31:0] f1_ysize;
output wire [31:0] f1_w00;
output wire [31:0] f1_w01;
output wire [31:0] f1_w02;
output wire [31:0] f1_w10;
output wire [31:0] f1_w11;
output wire [31:0] f1_w12;
output wire [31:0] f1_w20;
output wire [31:0] f1_w21;
output wire [31:0] f1_w22;
output wire [31:0] f1_bias;
output wire [31:0] f2_ctrlreg0;
output wire [31:0] f2_ctrlreg1;
output wire [31:0] f2_ctrlreg2;
output wire [31:0] f2_ctrlreg3;
output wire [31:0] f2_xsize;
output wire [31:0] f2_ysize;
output wire [31:0] f2_w00;
output wire [31:0] f2_w01;
output wire [31:0] f2_w02;
output wire [31:0] f2_w10;
output wire [31:0] f2_w11;
output wire [31:0] f2_w12;
output wire [31:0] f2_w20;
output wire [31:0] f2_w21;
output wire [31:0] f2_w22;
output wire [31:0] f2_bias;
output wire [31:0] f3_ctrlreg0;
output wire [31:0] f3_ctrlreg1;
output wire [31:0] f3_ctrlreg2;
output wire [31:0] f3_ctrlreg3;
output wire [31:0] f3_xsize;
output wire [31:0] f3_ysize;
output wire [31:0] f3_w00;
output wire [31:0] f3_w01;
output wire [31:0] f3_w02;
output wire [31:0] f3_w10;
output wire [31:0] f3_w11;
output wire [31:0] f3_w12;
output wire [31:0] f3_w20;
output wire [31:0] f3_w21;
output wire [31:0] f3_w22;
output wire [31:0] f3_bias;

wire               fx_cs;
wire               f0_cs;
wire               f1_cs;
wire               f2_cs;
wire               f3_cs;
assign fx_cs = (avl_address[9:4]==0);
assign f0_cs = (avl_address[9:4]==1);
assign f1_cs = (avl_address[9:4]==2);
assign f2_cs = (avl_address[9:4]==3);
assign f3_cs = (avl_address[9:4]==4);

reg [15:0]  avl_address_l_dec;
always @ (*) begin
    case (avl_address[3:0])
        0 : avl_address_l_dec = 16'b0000000000000001;
        1 : avl_address_l_dec = 16'b0000000000000010;
        2 : avl_address_l_dec = 16'b0000000000000100;
        3 : avl_address_l_dec = 16'b0000000000001000;
        4 : avl_address_l_dec = 16'b0000000000010000;
        5 : avl_address_l_dec = 16'b0000000000100000;
        6 : avl_address_l_dec = 16'b0000000001000000;
        7 : avl_address_l_dec = 16'b0000000010000000;
        8 : avl_address_l_dec = 16'b0000000100000000;
        9 : avl_address_l_dec = 16'b0000001000000000;
       10 : avl_address_l_dec = 16'b0000010000000000;
       11 : avl_address_l_dec = 16'b0000100000000000;
       12 : avl_address_l_dec = 16'b0001000000000000;
       13 : avl_address_l_dec = 16'b0010000000000000;
       14 : avl_address_l_dec = 16'b0100000000000000;
       15 : avl_address_l_dec = 16'b1000000000000000;
       default : avl_address_l_dec = 16'b0000000000000001;
    endcase
end
wire        fx_avl_waitrequest;
wire [31:0] fx_avl_readdata;
wire        fx_avl_readdatavalid;
wire        f0_avl_waitrequest;
wire [31:0] f0_avl_readdata;
wire        f0_avl_readdatavalid;
wire        f1_avl_waitrequest;
wire [31:0] f1_avl_readdata;
wire        f1_avl_readdatavalid;
wire        f2_avl_waitrequest;
wire [31:0] f2_avl_readdata;
wire        f2_avl_readdatavalid;
wire        f3_avl_waitrequest;
wire [31:0] f3_avl_readdata;
wire        f3_avl_readdatavalid;

/*zcnn_regbank_core AUTO_TEMPLATE(
 .avl_cs     (@"(substring vl-cell-name 0 2)"_cs),
 .\(ctrl.*\) (@"(substring vl-cell-name 0 2)"_\1),
 .\(.size\)  (@"(substring vl-cell-name 0 2)"_\1),
 .\(w..\)  (@"(substring vl-cell-name 0 2)"_\1),
 .\(bias\)  (@"(substring vl-cell-name 0 2)"_\1),
 .\(avl_wa.*\)     (@"(substring vl-cell-name 0 2)"_\1),
 .\(avl_readdata.*\)     (@"(substring vl-cell-name 0 2)"_\1),
 );
 */
zcnn_regbank_core fx_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (fx_avl_waitrequest), // Templated
                           .avl_readdata        (fx_avl_readdata), // Templated
                           .avl_readdatavalid   (fx_avl_readdatavalid), // Templated
                           .ctrlreg0            (fx_ctrlreg0),   // Templated
                           .ctrlreg1            (fx_ctrlreg1),   // Templated
                           .ctrlreg2            (fx_ctrlreg2),   // Templated
                           .ctrlreg3            (fx_ctrlreg3),   // Templated
                           .xsize               (fx_xsize),      // Templated
                           .ysize               (fx_ysize),      // Templated
                           .w00                 (fx_w00),        // Templated
                           .w01                 (fx_w01),        // Templated
                           .w02                 (fx_w02),        // Templated
                           .w10                 (fx_w10),        // Templated
                           .w11                 (fx_w11),        // Templated
                           .w12                 (fx_w12),        // Templated
                           .w20                 (fx_w20),        // Templated
                           .w21                 (fx_w21),        // Templated
                           .w22                 (fx_w22),        // Templated
                           .bias                (fx_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (fx_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(fx_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(fx_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(fx_ctrlreg1_1_clear_tgl)); // Templated
zcnn_regbank_core f0_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (f0_avl_waitrequest), // Templated
                           .avl_readdata        (f0_avl_readdata), // Templated
                           .avl_readdatavalid   (f0_avl_readdatavalid), // Templated
                           .ctrlreg0            (f0_ctrlreg0),   // Templated
                           .ctrlreg1            (f0_ctrlreg1),   // Templated
                           .ctrlreg2            (f0_ctrlreg2),   // Templated
                           .ctrlreg3            (f0_ctrlreg3),   // Templated
                           .xsize               (f0_xsize),      // Templated
                           .ysize               (f0_ysize),      // Templated
                           .w00                 (f0_w00),        // Templated
                           .w01                 (f0_w01),        // Templated
                           .w02                 (f0_w02),        // Templated
                           .w10                 (f0_w10),        // Templated
                           .w11                 (f0_w11),        // Templated
                           .w12                 (f0_w12),        // Templated
                           .w20                 (f0_w20),        // Templated
                           .w21                 (f0_w21),        // Templated
                           .w22                 (f0_w22),        // Templated
                           .bias                (f0_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (f0_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(f0_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(f0_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(f0_ctrlreg1_1_clear_tgl)); // Templated
zcnn_regbank_core f1_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (f1_avl_waitrequest), // Templated
                           .avl_readdata        (f1_avl_readdata), // Templated
                           .avl_readdatavalid   (f1_avl_readdatavalid), // Templated
                           .ctrlreg0            (f1_ctrlreg0),   // Templated
                           .ctrlreg1            (f1_ctrlreg1),   // Templated
                           .ctrlreg2            (f1_ctrlreg2),   // Templated
                           .ctrlreg3            (f1_ctrlreg3),   // Templated
                           .xsize               (f1_xsize),      // Templated
                           .ysize               (f1_ysize),      // Templated
                           .w00                 (f1_w00),        // Templated
                           .w01                 (f1_w01),        // Templated
                           .w02                 (f1_w02),        // Templated
                           .w10                 (f1_w10),        // Templated
                           .w11                 (f1_w11),        // Templated
                           .w12                 (f1_w12),        // Templated
                           .w20                 (f1_w20),        // Templated
                           .w21                 (f1_w21),        // Templated
                           .w22                 (f1_w22),        // Templated
                           .bias                (f1_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (f1_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(f1_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(f1_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(f1_ctrlreg1_1_clear_tgl)); // Templated
zcnn_regbank_core f2_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (f2_avl_waitrequest), // Templated
                           .avl_readdata        (f2_avl_readdata), // Templated
                           .avl_readdatavalid   (f2_avl_readdatavalid), // Templated
                           .ctrlreg0            (f2_ctrlreg0),   // Templated
                           .ctrlreg1            (f2_ctrlreg1),   // Templated
                           .ctrlreg2            (f2_ctrlreg2),   // Templated
                           .ctrlreg3            (f2_ctrlreg3),   // Templated
                           .xsize               (f2_xsize),      // Templated
                           .ysize               (f2_ysize),      // Templated
                           .w00                 (f2_w00),        // Templated
                           .w01                 (f2_w01),        // Templated
                           .w02                 (f2_w02),        // Templated
                           .w10                 (f2_w10),        // Templated
                           .w11                 (f2_w11),        // Templated
                           .w12                 (f2_w12),        // Templated
                           .w20                 (f2_w20),        // Templated
                           .w21                 (f2_w21),        // Templated
                           .w22                 (f2_w22),        // Templated
                           .bias                (f2_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (f2_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(f2_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(f2_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(f2_ctrlreg1_1_clear_tgl)); // Templated
zcnn_regbank_core f3_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (f3_avl_waitrequest), // Templated
                           .avl_readdata        (f3_avl_readdata), // Templated
                           .avl_readdatavalid   (f3_avl_readdatavalid), // Templated
                           .ctrlreg0            (f3_ctrlreg0),   // Templated
                           .ctrlreg1            (f3_ctrlreg1),   // Templated
                           .ctrlreg2            (f3_ctrlreg2),   // Templated
                           .ctrlreg3            (f3_ctrlreg3),   // Templated
                           .xsize               (f3_xsize),      // Templated
                           .ysize               (f3_ysize),      // Templated
                           .w00                 (f3_w00),        // Templated
                           .w01                 (f3_w01),        // Templated
                           .w02                 (f3_w02),        // Templated
                           .w10                 (f3_w10),        // Templated
                           .w11                 (f3_w11),        // Templated
                           .w12                 (f3_w12),        // Templated
                           .w20                 (f3_w20),        // Templated
                           .w21                 (f3_w21),        // Templated
                           .w22                 (f3_w22),        // Templated
                           .bias                (f3_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (f3_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(f3_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(f3_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(f3_ctrlreg1_1_clear_tgl)); // Templated

assign avl_waitrequest = 
 fx_avl_waitrequest|
 f0_avl_waitrequest|
 f1_avl_waitrequest|
 f2_avl_waitrequest|
 f3_avl_waitrequest;
assign avl_readdata    = 
 fx_avl_readdata|
 f0_avl_readdata|
 f1_avl_readdata|
 f2_avl_readdata|
 f3_avl_readdata;
assign avl_readdatavalid    = 
 fx_avl_readdatavalid|
 f0_avl_readdatavalid|
 f1_avl_readdatavalid|
 f2_avl_readdatavalid|
 f3_avl_readdatavalid;

endmodule // reg_block
//synopsys translate_off
`default_nettype wire
//synopsys translate_on
