//  Last Change:    2015/07/01 18:08:18 (matsukura)
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
f3_w21, f3_w22, f3_bias, ax_ctrlreg0, ax_ctrlreg1, ax_ctrlreg2,
ax_ctrlreg3, ax_xsize, ax_ysize, ax_w22, ax_w21, ax_w20, ax_w12,
ax_w11, ax_w10, ax_w02, ax_w01, ax_w00, ax_bias, a0_ctrlreg0,
a0_ctrlreg1, a0_ctrlreg2, a0_ctrlreg3, a0_xsize, a0_ysize, a0_w00,
a0_w01, a0_w02, a0_w10, a0_w11, a0_w12, a0_w20, a0_w21, a0_w22,
a0_bias, a1_ctrlreg0, a1_ctrlreg1, a1_ctrlreg2, a1_ctrlreg3, a1_xsize,
a1_ysize, a1_w00, a1_w01, a1_w02, a1_w10, a1_w11, a1_w12, a1_w20,
a1_w21, a1_w22, a1_bias, a2_ctrlreg0, a2_ctrlreg1, a2_ctrlreg2,
a2_ctrlreg3, a2_xsize, a2_ysize, a2_w00, a2_w01, a2_w02, a2_w10,
a2_w11, a2_w12, a2_w20, a2_w21, a2_w22, a2_bias, a3_ctrlreg0,
a3_ctrlreg1, a3_ctrlreg2, a3_ctrlreg3, a3_xsize, a3_ysize, a3_w00,
a3_w01, a3_w02, a3_w10, a3_w11, a3_w12, a3_w20, a3_w21, a3_w22,
a3_bias,
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
f3_ctrlreg1_1_clear_tgl, ax_ctrlreg1_1_clear_tgl
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

output wire [31:0] ax_ctrlreg0;
output wire [31:0] ax_ctrlreg1;
output wire [31:0] ax_ctrlreg2;
output wire [31:0] ax_ctrlreg3;
output wire [31:0] ax_xsize;
output wire [31:0] ax_ysize;
output wire [31:0] ax_w22;
output wire [31:0] ax_w21;
output wire [31:0] ax_w20;
output wire [31:0] ax_w12;
output wire [31:0] ax_w11;
output wire [31:0] ax_w10;
output wire [31:0] ax_w02;
output wire [31:0] ax_w01;
output wire [31:0] ax_w00;
output wire [31:0] ax_bias;
output wire [31:0] a0_ctrlreg0;
output wire [31:0] a0_ctrlreg1;
output wire [31:0] a0_ctrlreg2;
output wire [31:0] a0_ctrlreg3;
output wire [31:0] a0_xsize;
output wire [31:0] a0_ysize;
output wire [31:0] a0_w00;
output wire [31:0] a0_w01;
output wire [31:0] a0_w02;
output wire [31:0] a0_w10;
output wire [31:0] a0_w11;
output wire [31:0] a0_w12;
output wire [31:0] a0_w20;
output wire [31:0] a0_w21;
output wire [31:0] a0_w22;
output wire [31:0] a0_bias;
output wire [31:0] a1_ctrlreg0;
output wire [31:0] a1_ctrlreg1;
output wire [31:0] a1_ctrlreg2;
output wire [31:0] a1_ctrlreg3;
output wire [31:0] a1_xsize;
output wire [31:0] a1_ysize;
output wire [31:0] a1_w00;
output wire [31:0] a1_w01;
output wire [31:0] a1_w02;
output wire [31:0] a1_w10;
output wire [31:0] a1_w11;
output wire [31:0] a1_w12;
output wire [31:0] a1_w20;
output wire [31:0] a1_w21;
output wire [31:0] a1_w22;
output wire [31:0] a1_bias;
output wire [31:0] a2_ctrlreg0;
output wire [31:0] a2_ctrlreg1;
output wire [31:0] a2_ctrlreg2;
output wire [31:0] a2_ctrlreg3;
output wire [31:0] a2_xsize;
output wire [31:0] a2_ysize;
output wire [31:0] a2_w00;
output wire [31:0] a2_w01;
output wire [31:0] a2_w02;
output wire [31:0] a2_w10;
output wire [31:0] a2_w11;
output wire [31:0] a2_w12;
output wire [31:0] a2_w20;
output wire [31:0] a2_w21;
output wire [31:0] a2_w22;
output wire [31:0] a2_bias;
output wire [31:0] a3_ctrlreg0;
output wire [31:0] a3_ctrlreg1;
output wire [31:0] a3_ctrlreg2;
output wire [31:0] a3_ctrlreg3;
output wire [31:0] a3_xsize;
output wire [31:0] a3_ysize;
output wire [31:0] a3_w00;
output wire [31:0] a3_w01;
output wire [31:0] a3_w02;
output wire [31:0] a3_w10;
output wire [31:0] a3_w11;
output wire [31:0] a3_w12;
output wire [31:0] a3_w20;
output wire [31:0] a3_w21;
output wire [31:0] a3_w22;
output wire [31:0] a3_bias;

//nouse
wire         ax_ctrlreg0_0_clear_tgl = 0;
wire         ax_ctrlreg1_0_clear_tgl = 0;
input wire   ax_ctrlreg1_1_clear_tgl;
wire         a0_ctrlreg0_0_clear_tgl = 0;
wire         a0_ctrlreg1_0_clear_tgl = 0;
wire         a0_ctrlreg1_1_clear_tgl = 0;
wire         a1_ctrlreg0_0_clear_tgl = 0;
wire         a1_ctrlreg1_0_clear_tgl = 0;
wire         a1_ctrlreg1_1_clear_tgl = 0;
wire         a2_ctrlreg0_0_clear_tgl = 0;
wire         a2_ctrlreg1_0_clear_tgl = 0;
wire         a2_ctrlreg1_1_clear_tgl = 0;
wire         a3_ctrlreg0_0_clear_tgl = 0;
wire         a3_ctrlreg1_0_clear_tgl = 0;
wire         a3_ctrlreg1_1_clear_tgl = 0;

wire               fx_cs;
wire               f0_cs;
wire               f1_cs;
wire               f2_cs;
wire               f3_cs;
wire               ax_cs;
wire               a0_cs;
wire               a1_cs;
wire               a2_cs;
wire               a3_cs;
assign fx_cs = (avl_address[9:4]==0);
assign f0_cs = (avl_address[9:4]==1);
assign f1_cs = (avl_address[9:4]==2);
assign f2_cs = (avl_address[9:4]==3);
assign f3_cs = (avl_address[9:4]==4);
assign ax_cs = (avl_address[9:4]==5);
assign a0_cs = (avl_address[9:4]==6);
assign a1_cs = (avl_address[9:4]==7);
assign a2_cs = (avl_address[9:4]==8);
assign a3_cs = (avl_address[9:4]==9);

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
wire        ax_avl_waitrequest;
wire [31:0] ax_avl_readdata;
wire        ax_avl_readdatavalid;
wire        a0_avl_waitrequest;
wire [31:0] a0_avl_readdata;
wire        a0_avl_readdatavalid;
wire        a1_avl_waitrequest;
wire [31:0] a1_avl_readdata;
wire        a1_avl_readdatavalid;
wire        a2_avl_waitrequest;
wire [31:0] a2_avl_readdata;
wire        a2_avl_readdatavalid;
wire        a3_avl_waitrequest;
wire [31:0] a3_avl_readdata;
wire        a3_avl_readdatavalid;

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

zcnn_regbank_core ax_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (ax_avl_waitrequest), // Templated
                           .avl_readdata        (ax_avl_readdata), // Templated
                           .avl_readdatavalid   (ax_avl_readdatavalid), // Templated
                           .ctrlreg0            (ax_ctrlreg0),   // Templated
                           .ctrlreg1            (ax_ctrlreg1),   // Templated
                           .ctrlreg2            (ax_ctrlreg2),   // Templated
                           .ctrlreg3            (ax_ctrlreg3),   // Templated
                           .xsize               (ax_xsize),      // Templated
                           .ysize               (ax_ysize),      // Templated
                           .w00                 (ax_w00),        // Templated
                           .w01                 (ax_w01),        // Templated
                           .w02                 (ax_w02),        // Templated
                           .w10                 (ax_w10),        // Templated
                           .w11                 (ax_w11),        // Templated
                           .w12                 (ax_w12),        // Templated
                           .w20                 (ax_w20),        // Templated
                           .w21                 (ax_w21),        // Templated
                           .w22                 (ax_w22),        // Templated
                           .bias                (ax_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (ax_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(ax_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(ax_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(ax_ctrlreg1_1_clear_tgl)); // Templated
zcnn_regbank_core a0_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (a0_avl_waitrequest), // Templated
                           .avl_readdata        (a0_avl_readdata), // Templated
                           .avl_readdatavalid   (a0_avl_readdatavalid), // Templated
                           .ctrlreg0            (a0_ctrlreg0),   // Templated
                           .ctrlreg1            (a0_ctrlreg1),   // Templated
                           .ctrlreg2            (a0_ctrlreg2),   // Templated
                           .ctrlreg3            (a0_ctrlreg3),   // Templated
                           .xsize               (a0_xsize),      // Templated
                           .ysize               (a0_ysize),      // Templated
                           .w00                 (a0_w00),        // Templated
                           .w01                 (a0_w01),        // Templated
                           .w02                 (a0_w02),        // Templated
                           .w10                 (a0_w10),        // Templated
                           .w11                 (a0_w11),        // Templated
                           .w12                 (a0_w12),        // Templated
                           .w20                 (a0_w20),        // Templated
                           .w21                 (a0_w21),        // Templated
                           .w22                 (a0_w22),        // Templated
                           .bias                (a0_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (a0_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(a0_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(a0_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(a0_ctrlreg1_1_clear_tgl)); // Templated
zcnn_regbank_core a1_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (a1_avl_waitrequest), // Templated
                           .avl_readdata        (a1_avl_readdata), // Templated
                           .avl_readdatavalid   (a1_avl_readdatavalid), // Templated
                           .ctrlreg0            (a1_ctrlreg0),   // Templated
                           .ctrlreg1            (a1_ctrlreg1),   // Templated
                           .ctrlreg2            (a1_ctrlreg2),   // Templated
                           .ctrlreg3            (a1_ctrlreg3),   // Templated
                           .xsize               (a1_xsize),      // Templated
                           .ysize               (a1_ysize),      // Templated
                           .w00                 (a1_w00),        // Templated
                           .w01                 (a1_w01),        // Templated
                           .w02                 (a1_w02),        // Templated
                           .w10                 (a1_w10),        // Templated
                           .w11                 (a1_w11),        // Templated
                           .w12                 (a1_w12),        // Templated
                           .w20                 (a1_w20),        // Templated
                           .w21                 (a1_w21),        // Templated
                           .w22                 (a1_w22),        // Templated
                           .bias                (a1_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (a1_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(a1_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(a1_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(a1_ctrlreg1_1_clear_tgl)); // Templated
zcnn_regbank_core a2_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (a2_avl_waitrequest), // Templated
                           .avl_readdata        (a2_avl_readdata), // Templated
                           .avl_readdatavalid   (a2_avl_readdatavalid), // Templated
                           .ctrlreg0            (a2_ctrlreg0),   // Templated
                           .ctrlreg1            (a2_ctrlreg1),   // Templated
                           .ctrlreg2            (a2_ctrlreg2),   // Templated
                           .ctrlreg3            (a2_ctrlreg3),   // Templated
                           .xsize               (a2_xsize),      // Templated
                           .ysize               (a2_ysize),      // Templated
                           .w00                 (a2_w00),        // Templated
                           .w01                 (a2_w01),        // Templated
                           .w02                 (a2_w02),        // Templated
                           .w10                 (a2_w10),        // Templated
                           .w11                 (a2_w11),        // Templated
                           .w12                 (a2_w12),        // Templated
                           .w20                 (a2_w20),        // Templated
                           .w21                 (a2_w21),        // Templated
                           .w22                 (a2_w22),        // Templated
                           .bias                (a2_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (a2_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(a2_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(a2_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(a2_ctrlreg1_1_clear_tgl)); // Templated
zcnn_regbank_core a3_core (/*AUTOINST*/
                           // Outputs
                           .avl_waitrequest     (a3_avl_waitrequest), // Templated
                           .avl_readdata        (a3_avl_readdata), // Templated
                           .avl_readdatavalid   (a3_avl_readdatavalid), // Templated
                           .ctrlreg0            (a3_ctrlreg0),   // Templated
                           .ctrlreg1            (a3_ctrlreg1),   // Templated
                           .ctrlreg2            (a3_ctrlreg2),   // Templated
                           .ctrlreg3            (a3_ctrlreg3),   // Templated
                           .xsize               (a3_xsize),      // Templated
                           .ysize               (a3_ysize),      // Templated
                           .w00                 (a3_w00),        // Templated
                           .w01                 (a3_w01),        // Templated
                           .w02                 (a3_w02),        // Templated
                           .w10                 (a3_w10),        // Templated
                           .w11                 (a3_w11),        // Templated
                           .w12                 (a3_w12),        // Templated
                           .w20                 (a3_w20),        // Templated
                           .w21                 (a3_w21),        // Templated
                           .w22                 (a3_w22),        // Templated
                           .bias                (a3_bias),       // Templated
                           // Inputs
                           .resb                (resb),
                           .avl_clk             (avl_clk),
                           .avl_write           (avl_write),
                           .avl_read            (avl_read),
                           .avl_cs              (a3_cs),         // Templated
                           .avl_address_l_dec   (avl_address_l_dec[15:0]),
                           .avl_writedata       (avl_writedata[31:0]),
                           .avl_byteenable      (avl_byteenable[3:0]),
                           .busy_status         (busy_status),
                           .com_ctrlreg1_0_clear_tgl(com_ctrlreg1_0_clear_tgl),
                           .ctrlreg0_0_clear_tgl(a3_ctrlreg0_0_clear_tgl), // Templated
                           .ctrlreg1_0_clear_tgl(a3_ctrlreg1_0_clear_tgl), // Templated
                           .ctrlreg1_1_clear_tgl(a3_ctrlreg1_1_clear_tgl)); // Templated

assign avl_waitrequest = 
                         fx_avl_waitrequest|
                         f0_avl_waitrequest|
                         f1_avl_waitrequest|
                         f2_avl_waitrequest|
                         f3_avl_waitrequest|
                         ax_avl_waitrequest|
                         a0_avl_waitrequest|
                         a1_avl_waitrequest|
                         a2_avl_waitrequest|
                         a3_avl_waitrequest|
                         0;
assign avl_readdata    = 
                         fx_avl_readdata|
                         f0_avl_readdata|
                         f1_avl_readdata|
                         f2_avl_readdata|
                         f3_avl_readdata|
                         ax_avl_readdata|
                         a0_avl_readdata|
                         a1_avl_readdata|
                         a2_avl_readdata|
                         a3_avl_readdata|
                         0;
assign avl_readdatavalid = 
                           fx_avl_readdatavalid|
                           f0_avl_readdatavalid|
                           f1_avl_readdatavalid|
                           f2_avl_readdatavalid|
                           f3_avl_readdatavalid|
                           ax_avl_readdatavalid|
                           a0_avl_readdatavalid|
                           a1_avl_readdatavalid|
                           a2_avl_readdatavalid|
                           a3_avl_readdatavalid|
                           0;

endmodule // reg_block
//synopsys translate_off
`default_nettype wire
//synopsys translate_on
