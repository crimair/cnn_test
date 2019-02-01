//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_core
(/*AUTOARG*/
// Outputs
avl_waitrequest, avl_readdata, avl_readdatavalid, mrx_read,
mrx_address, mrx_burstcount, mr0_read, mr0_address, mr0_burstcount,
mr1_read, mr1_address, mr1_burstcount, mr2_read, mr2_address,
mr2_burstcount, mr3_read, mr3_address, mr3_burstcount, mwx_write,
mwx_address, mwx_burstcount, mwx_writedata, mw0_write, mw0_address,
mw0_burstcount, mw0_writedata, mw1_write, mw1_address, mw1_burstcount,
mw1_writedata, mw2_write, mw2_address, mw2_burstcount, mw2_writedata,
mw3_write, mw3_address, mw3_burstcount, mw3_writedata, mwa_write,
mwa_address, mwa_burstcount, mwa_writedata, zcnn_busy,
// Inputs
resb, avl_clk, avl_write, avl_read, avl_address, avl_writedata,
avl_byteenable, clk, mem_clk, mrx_waitrequest, mrx_readdatavalid,
mrx_readdata, mr0_waitrequest, mr0_readdatavalid, mr0_readdata,
mr1_waitrequest, mr1_readdatavalid, mr1_readdata, mr2_waitrequest,
mr2_readdatavalid, mr2_readdata, mr3_waitrequest, mr3_readdatavalid,
mr3_readdata, mwx_waitrequest, mw0_waitrequest, mw1_waitrequest,
mw2_waitrequest, mw3_waitrequest, mwa_waitrequest
);

parameter          CORE_ADR = 0;
input wire          resb;
input wire          avl_clk ;
input wire          avl_write;
input wire          avl_read;
input wire [9:0]    avl_address;
output wire         avl_waitrequest;
output wire [31:0]  avl_readdata;
output wire         avl_readdatavalid;
input wire [31:0]   avl_writedata;
input wire [3:0]    avl_byteenable;

input wire          clk; //local clock

input wire          mem_clk;
output wire         mrx_read;
output wire [25:0]  mrx_address;
output wire [7:0]   mrx_burstcount; //16burst fix
input wire          mrx_waitrequest;
input wire          mrx_readdatavalid;
input wire [127:0]  mrx_readdata;
output wire         mr0_read;
output wire [25:0]  mr0_address;
output wire [7:0]   mr0_burstcount; //16burst fix
input wire          mr0_waitrequest;
input wire          mr0_readdatavalid;
input wire [127:0]  mr0_readdata;
output wire         mr1_read;
output wire [25:0]  mr1_address;
output wire [7:0]   mr1_burstcount; //16burst fix
input wire          mr1_waitrequest;
input wire          mr1_readdatavalid;
input wire [127:0]  mr1_readdata;
output wire         mr2_read;
output wire [25:0]  mr2_address;
output wire [7:0]   mr2_burstcount; //16burst fix
input wire          mr2_waitrequest;
input wire          mr2_readdatavalid;
input wire [127:0]  mr2_readdata;
output wire         mr3_read;
output wire [25:0]  mr3_address;
output wire [7:0]   mr3_burstcount; //16burst fix
input wire          mr3_waitrequest;
input wire          mr3_readdatavalid;
input wire [127:0]  mr3_readdata;

output wire         mwx_write;
output wire [25:0]  mwx_address;
output wire [7:0]   mwx_burstcount; //16burst fix
input wire          mwx_waitrequest;
output wire [127:0] mwx_writedata;
output wire         mw0_write;
output wire [25:0]  mw0_address;
output wire [7:0]   mw0_burstcount; //16burst fix
input wire          mw0_waitrequest;
output wire [127:0] mw0_writedata;
output wire         mw1_write;
output wire [25:0]  mw1_address;
output wire [7:0]   mw1_burstcount; //16burst fix
input wire          mw1_waitrequest;
output wire [127:0] mw1_writedata;
output wire         mw2_write;
output wire [25:0]  mw2_address;
output wire [7:0]   mw2_burstcount; //16burst fix
input wire          mw2_waitrequest;
output wire [127:0] mw2_writedata;
output wire         mw3_write;
output wire [25:0]  mw3_address;
output wire [7:0]   mw3_burstcount; //16burst fix
input wire          mw3_waitrequest;
output wire [127:0] mw3_writedata;

output wire         mwa_write;
output wire [25:0]  mwa_address;
output wire [7:0]   mwa_burstcount; //16burst fix
input wire          mwa_waitrequest;
output wire [127:0] mwa_writedata;

output wire         zcnn_busy;

wire                fx_read_end_tgl;
wire                f0_read_end_tgl;
wire                f1_read_end_tgl;
wire                f2_read_end_tgl;
wire                f3_read_end_tgl;
wire                fx_write_end_tgl;
wire                f0_write_end_tgl;
wire                f1_write_end_tgl;
wire                f2_write_end_tgl;
wire                f3_write_end_tgl;
wire                ax_write_end_tgl;
wire                cache_end_tgl;
wire [31:0]         fx_ctrlreg0;
wire [31:0]         fx_ctrlreg1;
wire [31:0]         fx_ctrlreg2;
wire [31:0]         fx_ctrlreg3;
wire [31:0]         fx_xsize;
wire [31:0]         fx_ysize;
wire [31:0]         tg_delay; //fx_w00;
wire [31:0]         tg_ctrl; //fx_w01;
wire [31:0]         fx_w02;
wire [31:0]         fx_w10;
wire [31:0]         fx_w11;
wire [31:0]         fx_w12;
wire [31:0]         fx_w20;
wire [31:0]         write_mem_size;//fx_w21;
wire [31:0]         write_size; //fx_w22;
wire [31:0]         fx_bias;
wire [31:0]         f0_ctrlreg0;
wire [31:0]         f0_ctrlreg1;
wire [31:0]         f0_ctrlreg2;
wire [31:0]         f0_ctrlreg3;
wire [31:0]         f0_xsize;
wire [31:0]         f0_ysize;
wire [31:0]         f0_w00;
wire [31:0]         f0_w01;
wire [31:0]         f0_w02;
wire [31:0]         f0_w10;
wire [31:0]         f0_w11;
wire [31:0]         f0_w12;
wire [31:0]         f0_w20;
wire [31:0]         f0_w21;
wire [31:0]         f0_w22;
wire [31:0]         f0_bias;
wire [31:0]         f1_ctrlreg0;
wire [31:0]         f1_ctrlreg1;
wire [31:0]         f1_ctrlreg2;
wire [31:0]         f1_ctrlreg3;
wire [31:0]         f1_xsize;
wire [31:0]         f1_ysize;
wire [31:0]         f1_w00;
wire [31:0]         f1_w01;
wire [31:0]         f1_w02;
wire [31:0]         f1_w10;
wire [31:0]         f1_w11;
wire [31:0]         f1_w12;
wire [31:0]         f1_w20;
wire [31:0]         f1_w21;
wire [31:0]         f1_w22;
wire [31:0]         f1_bias;
wire [31:0]         f2_ctrlreg0;
wire [31:0]         f2_ctrlreg1;
wire [31:0]         f2_ctrlreg2;
wire [31:0]         f2_ctrlreg3;
wire [31:0]         f2_xsize;
wire [31:0]         f2_ysize;
wire [31:0]         f2_w00;
wire [31:0]         f2_w01;
wire [31:0]         f2_w02;
wire [31:0]         f2_w10;
wire [31:0]         f2_w11;
wire [31:0]         f2_w12;
wire [31:0]         f2_w20;
wire [31:0]         f2_w21;
wire [31:0]         f2_w22;
wire [31:0]         f2_bias;
wire [31:0]         f3_ctrlreg0;
wire [31:0]         f3_ctrlreg1;
wire [31:0]         f3_ctrlreg2;
wire [31:0]         f3_ctrlreg3;
wire [31:0]         f3_xsize;
wire [31:0]         f3_ysize;
wire [31:0]         f3_w00;
wire [31:0]         f3_w01;
wire [31:0]         f3_w02;
wire [31:0]         f3_w10;
wire [31:0]         f3_w11;
wire [31:0]         f3_w12;
wire [31:0]         f3_w20;
wire [31:0]         f3_w21;
wire [31:0]         f3_w22;
wire [31:0]         f3_bias;

wire                f0_g_en;
wire [31:0]         f0_g_d00;
wire [31:0]         f0_g_d01;
wire [31:0]         f0_g_d02;
wire [31:0]         f0_g_d10;
wire [31:0]         f0_g_d11;
wire [31:0]         f0_g_d12;
wire [31:0]         f0_g_d20;
wire [31:0]         f0_g_d21;
wire [31:0]         f0_g_d22;
wire                f1_g_en;
wire [31:0]         f1_g_d00;
wire [31:0]         f1_g_d01;
wire [31:0]         f1_g_d02;
wire [31:0]         f1_g_d10;
wire [31:0]         f1_g_d11;
wire [31:0]         f1_g_d12;
wire [31:0]         f1_g_d20;
wire [31:0]         f1_g_d21;
wire [31:0]         f1_g_d22;
wire                f2_g_en;
wire [31:0]         f2_g_d00;
wire [31:0]         f2_g_d01;
wire [31:0]         f2_g_d02;
wire [31:0]         f2_g_d10;
wire [31:0]         f2_g_d11;
wire [31:0]         f2_g_d12;
wire [31:0]         f2_g_d20;
wire [31:0]         f2_g_d21;
wire [31:0]         f2_g_d22;
wire                f3_g_en;
wire [31:0]         f3_g_d00;
wire [31:0]         f3_g_d01;
wire [31:0]         f3_g_d02;
wire [31:0]         f3_g_d10;
wire [31:0]         f3_g_d11;
wire [31:0]         f3_g_d12;
wire [31:0]         f3_g_d20;
wire [31:0]         f3_g_d21;
wire [31:0]         f3_g_d22;

wire                tg_end_tgl;
wire                tg_vp;
wire                tg_ren;
wire                tg_en;
wire                tg_ven;
wire                fx_rm_vp;
wire                fx_rm_en;
wire                fx_rm_ven;
wire [31:0]         fx_rm_d;
wire                f0_rm_vp;
wire                f0_rm_en;
wire                f0_rm_ven;
wire [31:0]         f0_rm_d;
wire                f1_rm_vp;
wire                f1_rm_en;
wire                f1_rm_ven;
wire [31:0]         f1_rm_d;
wire                f2_rm_vp;
wire                f2_rm_en;
wire                f2_rm_ven;
wire [31:0]         f2_rm_d;
wire                f3_rm_vp;
wire                f3_rm_en;
wire                f3_rm_ven;
wire [31:0]         f3_rm_d;
wire                f0_f_en;
wire [31:0]         f0_f_d;
wire                f1_f_en;
wire [31:0]         f1_f_d;
wire                f2_f_en;
wire [31:0]         f2_f_d;
wire                f3_f_en;
wire [31:0]         f3_f_d;
wire                fx_sum_en;
wire [31:0]         fx_sum_d;
wire                sum_en_dx;
wire                sum_ren_dx;
wire [31:0]         f_c_d;

/*add start */
wire [31:0]         ax_ctrlreg0;
wire [31:0]         ax_ctrlreg1;
wire [31:0]         ax_ctrlreg2;
wire [31:0]         ax_ctrlreg3;
wire [31:0]         ax_xsize;
wire [31:0]         ax_ysize;
wire [31:0]         ax_w00;
wire [31:0]         ax_w01;
wire [31:0]         ax_w02;
wire [31:0]         ax_w10;
wire [31:0]         ax_w11;
wire [31:0]         ax_w12;
wire [31:0]         ax_w20;
wire [31:0]         ax_w21;
wire [31:0]         ax_w22;
wire [31:0]         ax_bias;
wire [31:0]         a0_ctrlreg0;
wire [31:0]         a0_ctrlreg1;
wire [31:0]         a0_ctrlreg2;
wire [31:0]         a0_ctrlreg3;
wire [31:0]         a0_xsize;
wire [31:0]         a0_ysize;
wire [31:0]         a0_w00;
wire [31:0]         a0_w01;
wire [31:0]         a0_w02;
wire [31:0]         a0_w10;
wire [31:0]         a0_w11;
wire [31:0]         a0_w12;
wire [31:0]         a0_w20;
wire [31:0]         a0_w21;
wire [31:0]         a0_w22;
wire [31:0]         a0_bias;
wire [31:0]         a1_ctrlreg0;
wire [31:0]         a1_ctrlreg1;
wire [31:0]         a1_ctrlreg2;
wire [31:0]         a1_ctrlreg3;
wire [31:0]         a1_xsize;
wire [31:0]         a1_ysize;
wire [31:0]         a1_w00;
wire [31:0]         a1_w01;
wire [31:0]         a1_w02;
wire [31:0]         a1_w10;
wire [31:0]         a1_w11;
wire [31:0]         a1_w12;
wire [31:0]         a1_w20;
wire [31:0]         a1_w21;
wire [31:0]         a1_w22;
wire [31:0]         a1_bias;
wire [31:0]         a2_ctrlreg0;
wire [31:0]         a2_ctrlreg1;
wire [31:0]         a2_ctrlreg2;
wire [31:0]         a2_ctrlreg3;
wire [31:0]         a2_xsize;
wire [31:0]         a2_ysize;
wire [31:0]         a2_w00;
wire [31:0]         a2_w01;
wire [31:0]         a2_w02;
wire [31:0]         a2_w10;
wire [31:0]         a2_w11;
wire [31:0]         a2_w12;
wire [31:0]         a2_w20;
wire [31:0]         a2_w21;
wire [31:0]         a2_w22;
wire [31:0]         a2_bias;
wire [31:0]         a3_ctrlreg0;
wire [31:0]         a3_ctrlreg1;
wire [31:0]         a3_ctrlreg2;
wire [31:0]         a3_ctrlreg3;
wire [31:0]         a3_xsize;
wire [31:0]         a3_ysize;
wire [31:0]         a3_w00;
wire [31:0]         a3_w01;
wire [31:0]         a3_w02;
wire [31:0]         a3_w10;
wire [31:0]         a3_w11;
wire [31:0]         a3_w12;
wire [31:0]         a3_w20;
wire [31:0]         a3_w21;
wire [31:0]         a3_w22;
wire [31:0]         a3_bias;

wire                ax_rm_vp;
wire                ax_rm_en;
wire                ax_rm_ven;
wire [31:0]         ax_rm_d;
wire                a0_rm_vp;
wire                a0_rm_en;
wire                a0_rm_ven;
wire [31:0]         a0_rm_d;
wire                a1_rm_vp;
wire                a1_rm_en;
wire                a1_rm_ven;
wire [31:0]         a1_rm_d;
wire                a2_rm_vp;
wire                a2_rm_en;
wire                a2_rm_ven;
wire [31:0]         a2_rm_d;
wire                a3_rm_vp;
wire                a3_rm_en;
wire                a3_rm_ven;
wire [31:0]         a3_rm_d;
wire                a0_f_en;
wire [31:0]         a0_f_d;
wire                a1_f_en;
wire [31:0]         a1_f_d;
wire                a2_f_en;
wire [31:0]         a2_f_d;
wire                a3_f_en;
wire [31:0]         a3_f_d;
wire                ax_sum_en;
wire [31:0]         ax_sum_d;
wire                sum2_en_dx;
wire                sum2_ren_dx;
wire [31:0]         a_c_d;

wire                fx_buffer_empty;
wire                f0_buffer_empty;
wire                f1_buffer_empty;
wire                f2_buffer_empty;
wire                f3_buffer_empty;
wire                ax_buffer_empty;

wire                tg_stop;
wire                f0_buffer_full;
wire                f1_buffer_full;
wire                f2_buffer_full;
wire                f3_buffer_full;

wire                r0_buffer_empty;
wire                r1_buffer_empty;
wire                r2_buffer_empty;
wire                r3_buffer_empty;

assign tg_stop =
                (!tg_ctrl[0]) ?  0 :
                f0_buffer_full|
                f1_buffer_full|
                f2_buffer_full|
                f3_buffer_full|
                r0_buffer_empty|
                r1_buffer_empty|
                r2_buffer_empty|
                r3_buffer_empty|
                0;
/* 
 FX only
 0 00 common tg start --tg_end clear
 0 01 busy_status     -- all_start_or clear_or
 0 08 fx_on
 0 09 f0_on
 0 10 f1_on
 0 11 f2_on
 0 12 f3_on
 0 16 read plane force f0
 4    start_delay

 //common
 1 00 read_mif_start -- tg_end clear
 1 01 write_mif_start -- write end clear
 1 04 h-on
 2    read address
 3    write address
 */

assign zcnn_busy = fx_ctrlreg0[0]| 
fx_ctrlreg1[0]| fx_ctrlreg1[1]| 
f0_ctrlreg1[0]| f0_ctrlreg1[1]| 
f1_ctrlreg1[0]| f1_ctrlreg1[1]| 
f2_ctrlreg1[0]| f2_ctrlreg1[1]| 
f3_ctrlreg1[0]| f3_ctrlreg1[1]|
ax_ctrlreg1[1]|
(~fx_buffer_empty)|
(~f0_buffer_empty)|
(~f1_buffer_empty)|
(~f2_buffer_empty)|
(~f3_buffer_empty)|
(~ax_buffer_empty)|
0;

/*zcnn_regbank AUTO_TEMPLATE(
 .busy_status (zcnn_busy),
 .fx_ctrlreg0_0_clear_tgl (tg_end_tgl),
 .f0_ctrlreg0_0_clear_tgl (tg_end_tgl),
 .f1_ctrlreg0_0_clear_tgl (tg_end_tgl),
 .f2_ctrlreg0_0_clear_tgl (tg_end_tgl),
 .f3_ctrlreg0_0_clear_tgl (tg_end_tgl),
 .com_ctrlreg1_0_clear_tgl (fx_write_end_tgl^cache_end_tgl),
 .fx_ctrlreg1_0_clear_tgl (fx_write_end_tgl),
 .f0_ctrlreg1_0_clear_tgl (f0_write_end_tgl),
 .f1_ctrlreg1_0_clear_tgl (f1_write_end_tgl),
 .f2_ctrlreg1_0_clear_tgl (f2_write_end_tgl),
 .f3_ctrlreg1_0_clear_tgl (f3_write_end_tgl),
 .fx_ctrlreg1_1_clear_tgl (fx_write_end_tgl),
 .f0_ctrlreg1_1_clear_tgl (f0_write_end_tgl),
 .f1_ctrlreg1_1_clear_tgl (f1_write_end_tgl),
 .f2_ctrlreg1_1_clear_tgl (f2_write_end_tgl),
 .f3_ctrlreg1_1_clear_tgl (f3_write_end_tgl),
 .ax_ctrlreg1_1_clear_tgl (ax_write_end_tgl),

 .fx_w00  (tg_delay[]),
 .fx_w01  (tg_ctrl[]),
 .fx_w21 (write_mem_size),
 .fx_w22 (write_size),
 );
 */
zcnn_regbank regbank(/*AUTOINST*/
                     // Outputs
                     .avl_waitrequest   (avl_waitrequest),
                     .avl_readdata      (avl_readdata[31:0]),
                     .avl_readdatavalid (avl_readdatavalid),
                     .fx_ctrlreg0       (fx_ctrlreg0[31:0]),
                     .fx_ctrlreg1       (fx_ctrlreg1[31:0]),
                     .fx_ctrlreg2       (fx_ctrlreg2[31:0]),
                     .fx_ctrlreg3       (fx_ctrlreg3[31:0]),
                     .fx_xsize          (fx_xsize[31:0]),
                     .fx_ysize          (fx_ysize[31:0]),
                     .fx_w22            (write_size),            // Templated
                     .fx_w21            (write_mem_size),        // Templated
                     .fx_w20            (fx_w20[31:0]),
                     .fx_w12            (fx_w12[31:0]),
                     .fx_w11            (fx_w11[31:0]),
                     .fx_w10            (fx_w10[31:0]),
                     .fx_w02            (fx_w02[31:0]),
                     .fx_w01            (tg_ctrl[31:0]),         // Templated
                     .fx_w00            (tg_delay[31:0]),        // Templated
                     .fx_bias           (fx_bias[31:0]),
                     .f0_ctrlreg0       (f0_ctrlreg0[31:0]),
                     .f0_ctrlreg1       (f0_ctrlreg1[31:0]),
                     .f0_ctrlreg2       (f0_ctrlreg2[31:0]),
                     .f0_ctrlreg3       (f0_ctrlreg3[31:0]),
                     .f0_xsize          (f0_xsize[31:0]),
                     .f0_ysize          (f0_ysize[31:0]),
                     .f0_w00            (f0_w00[31:0]),
                     .f0_w01            (f0_w01[31:0]),
                     .f0_w02            (f0_w02[31:0]),
                     .f0_w10            (f0_w10[31:0]),
                     .f0_w11            (f0_w11[31:0]),
                     .f0_w12            (f0_w12[31:0]),
                     .f0_w20            (f0_w20[31:0]),
                     .f0_w21            (f0_w21[31:0]),
                     .f0_w22            (f0_w22[31:0]),
                     .f0_bias           (f0_bias[31:0]),
                     .f1_ctrlreg0       (f1_ctrlreg0[31:0]),
                     .f1_ctrlreg1       (f1_ctrlreg1[31:0]),
                     .f1_ctrlreg2       (f1_ctrlreg2[31:0]),
                     .f1_ctrlreg3       (f1_ctrlreg3[31:0]),
                     .f1_xsize          (f1_xsize[31:0]),
                     .f1_ysize          (f1_ysize[31:0]),
                     .f1_w00            (f1_w00[31:0]),
                     .f1_w01            (f1_w01[31:0]),
                     .f1_w02            (f1_w02[31:0]),
                     .f1_w10            (f1_w10[31:0]),
                     .f1_w11            (f1_w11[31:0]),
                     .f1_w12            (f1_w12[31:0]),
                     .f1_w20            (f1_w20[31:0]),
                     .f1_w21            (f1_w21[31:0]),
                     .f1_w22            (f1_w22[31:0]),
                     .f1_bias           (f1_bias[31:0]),
                     .f2_ctrlreg0       (f2_ctrlreg0[31:0]),
                     .f2_ctrlreg1       (f2_ctrlreg1[31:0]),
                     .f2_ctrlreg2       (f2_ctrlreg2[31:0]),
                     .f2_ctrlreg3       (f2_ctrlreg3[31:0]),
                     .f2_xsize          (f2_xsize[31:0]),
                     .f2_ysize          (f2_ysize[31:0]),
                     .f2_w00            (f2_w00[31:0]),
                     .f2_w01            (f2_w01[31:0]),
                     .f2_w02            (f2_w02[31:0]),
                     .f2_w10            (f2_w10[31:0]),
                     .f2_w11            (f2_w11[31:0]),
                     .f2_w12            (f2_w12[31:0]),
                     .f2_w20            (f2_w20[31:0]),
                     .f2_w21            (f2_w21[31:0]),
                     .f2_w22            (f2_w22[31:0]),
                     .f2_bias           (f2_bias[31:0]),
                     .f3_ctrlreg0       (f3_ctrlreg0[31:0]),
                     .f3_ctrlreg1       (f3_ctrlreg1[31:0]),
                     .f3_ctrlreg2       (f3_ctrlreg2[31:0]),
                     .f3_ctrlreg3       (f3_ctrlreg3[31:0]),
                     .f3_xsize          (f3_xsize[31:0]),
                     .f3_ysize          (f3_ysize[31:0]),
                     .f3_w00            (f3_w00[31:0]),
                     .f3_w01            (f3_w01[31:0]),
                     .f3_w02            (f3_w02[31:0]),
                     .f3_w10            (f3_w10[31:0]),
                     .f3_w11            (f3_w11[31:0]),
                     .f3_w12            (f3_w12[31:0]),
                     .f3_w20            (f3_w20[31:0]),
                     .f3_w21            (f3_w21[31:0]),
                     .f3_w22            (f3_w22[31:0]),
                     .f3_bias           (f3_bias[31:0]),
                     .ax_ctrlreg0       (ax_ctrlreg0[31:0]),
                     .ax_ctrlreg1       (ax_ctrlreg1[31:0]),
                     .ax_ctrlreg2       (ax_ctrlreg2[31:0]),
                     .ax_ctrlreg3       (ax_ctrlreg3[31:0]),
                     .ax_xsize          (ax_xsize[31:0]),
                     .ax_ysize          (ax_ysize[31:0]),
                     .ax_w22            (ax_w22[31:0]),
                     .ax_w21            (ax_w21[31:0]),
                     .ax_w20            (ax_w20[31:0]),
                     .ax_w12            (ax_w12[31:0]),
                     .ax_w11            (ax_w11[31:0]),
                     .ax_w10            (ax_w10[31:0]),
                     .ax_w02            (ax_w02[31:0]),
                     .ax_w01            (ax_w01[31:0]),
                     .ax_w00            (ax_w00[31:0]),
                     .ax_bias           (ax_bias[31:0]),
                     .a0_ctrlreg0       (a0_ctrlreg0[31:0]),
                     .a0_ctrlreg1       (a0_ctrlreg1[31:0]),
                     .a0_ctrlreg2       (a0_ctrlreg2[31:0]),
                     .a0_ctrlreg3       (a0_ctrlreg3[31:0]),
                     .a0_xsize          (a0_xsize[31:0]),
                     .a0_ysize          (a0_ysize[31:0]),
                     .a0_w00            (a0_w00[31:0]),
                     .a0_w01            (a0_w01[31:0]),
                     .a0_w02            (a0_w02[31:0]),
                     .a0_w10            (a0_w10[31:0]),
                     .a0_w11            (a0_w11[31:0]),
                     .a0_w12            (a0_w12[31:0]),
                     .a0_w20            (a0_w20[31:0]),
                     .a0_w21            (a0_w21[31:0]),
                     .a0_w22            (a0_w22[31:0]),
                     .a0_bias           (a0_bias[31:0]),
                     .a1_ctrlreg0       (a1_ctrlreg0[31:0]),
                     .a1_ctrlreg1       (a1_ctrlreg1[31:0]),
                     .a1_ctrlreg2       (a1_ctrlreg2[31:0]),
                     .a1_ctrlreg3       (a1_ctrlreg3[31:0]),
                     .a1_xsize          (a1_xsize[31:0]),
                     .a1_ysize          (a1_ysize[31:0]),
                     .a1_w00            (a1_w00[31:0]),
                     .a1_w01            (a1_w01[31:0]),
                     .a1_w02            (a1_w02[31:0]),
                     .a1_w10            (a1_w10[31:0]),
                     .a1_w11            (a1_w11[31:0]),
                     .a1_w12            (a1_w12[31:0]),
                     .a1_w20            (a1_w20[31:0]),
                     .a1_w21            (a1_w21[31:0]),
                     .a1_w22            (a1_w22[31:0]),
                     .a1_bias           (a1_bias[31:0]),
                     .a2_ctrlreg0       (a2_ctrlreg0[31:0]),
                     .a2_ctrlreg1       (a2_ctrlreg1[31:0]),
                     .a2_ctrlreg2       (a2_ctrlreg2[31:0]),
                     .a2_ctrlreg3       (a2_ctrlreg3[31:0]),
                     .a2_xsize          (a2_xsize[31:0]),
                     .a2_ysize          (a2_ysize[31:0]),
                     .a2_w00            (a2_w00[31:0]),
                     .a2_w01            (a2_w01[31:0]),
                     .a2_w02            (a2_w02[31:0]),
                     .a2_w10            (a2_w10[31:0]),
                     .a2_w11            (a2_w11[31:0]),
                     .a2_w12            (a2_w12[31:0]),
                     .a2_w20            (a2_w20[31:0]),
                     .a2_w21            (a2_w21[31:0]),
                     .a2_w22            (a2_w22[31:0]),
                     .a2_bias           (a2_bias[31:0]),
                     .a3_ctrlreg0       (a3_ctrlreg0[31:0]),
                     .a3_ctrlreg1       (a3_ctrlreg1[31:0]),
                     .a3_ctrlreg2       (a3_ctrlreg2[31:0]),
                     .a3_ctrlreg3       (a3_ctrlreg3[31:0]),
                     .a3_xsize          (a3_xsize[31:0]),
                     .a3_ysize          (a3_ysize[31:0]),
                     .a3_w00            (a3_w00[31:0]),
                     .a3_w01            (a3_w01[31:0]),
                     .a3_w02            (a3_w02[31:0]),
                     .a3_w10            (a3_w10[31:0]),
                     .a3_w11            (a3_w11[31:0]),
                     .a3_w12            (a3_w12[31:0]),
                     .a3_w20            (a3_w20[31:0]),
                     .a3_w21            (a3_w21[31:0]),
                     .a3_w22            (a3_w22[31:0]),
                     .a3_bias           (a3_bias[31:0]),
                     // Inputs
                     .resb              (resb),
                     .avl_clk           (avl_clk),
                     .avl_write         (avl_write),
                     .avl_read          (avl_read),
                     .avl_address       (avl_address[9:0]),
                     .avl_writedata     (avl_writedata[31:0]),
                     .avl_byteenable    (avl_byteenable[3:0]),
                     .busy_status       (zcnn_busy),             // Templated
                     .com_ctrlreg1_0_clear_tgl(fx_write_end_tgl^cache_end_tgl), // Templated
                     .fx_ctrlreg0_0_clear_tgl(tg_end_tgl),       // Templated
                     .fx_ctrlreg1_0_clear_tgl(fx_write_end_tgl), // Templated
                     .fx_ctrlreg1_1_clear_tgl(fx_write_end_tgl), // Templated
                     .f0_ctrlreg0_0_clear_tgl(tg_end_tgl),       // Templated
                     .f0_ctrlreg1_0_clear_tgl(f0_write_end_tgl), // Templated
                     .f0_ctrlreg1_1_clear_tgl(f0_write_end_tgl), // Templated
                     .f1_ctrlreg0_0_clear_tgl(tg_end_tgl),       // Templated
                     .f1_ctrlreg1_0_clear_tgl(f1_write_end_tgl), // Templated
                     .f1_ctrlreg1_1_clear_tgl(f1_write_end_tgl), // Templated
                     .f2_ctrlreg0_0_clear_tgl(tg_end_tgl),       // Templated
                     .f2_ctrlreg1_0_clear_tgl(f2_write_end_tgl), // Templated
                     .f2_ctrlreg1_1_clear_tgl(f2_write_end_tgl), // Templated
                     .f3_ctrlreg0_0_clear_tgl(tg_end_tgl),       // Templated
                     .f3_ctrlreg1_0_clear_tgl(f3_write_end_tgl), // Templated
                     .f3_ctrlreg1_1_clear_tgl(f3_write_end_tgl), // Templated
                     .ax_ctrlreg1_1_clear_tgl(ax_write_end_tgl)); // Templated

/*zcnn_tg AUTO_TEMPLATE(
 .read_start                 (fx_ctrlreg0[0]),
 .read_start_delay           (tg_delay[]),
 .read_xsize                 (fx_xsize[]),
 .read_ysize                 (fx_ysize[]),
 .vp_out                     (tg_vp),
 .ren_out                    (tg_ren),
 .en_out                     (tg_en),
 .ven_out                    (tg_ven),
 );
 */
zcnn_tg tg (/*AUTOINST*/
            // Outputs
            .tg_end_tgl                 (tg_end_tgl),
            .vp_out                     (tg_vp),                 // Templated
            .ren_out                    (tg_ren),                // Templated
            .en_out                     (tg_en),                 // Templated
            .ven_out                    (tg_ven),                // Templated
            // Inputs
            .resb                       (resb),
            .clk                        (clk),
            .tg_stop                    (tg_stop),
            .read_start                 (fx_ctrlreg0[0]),        // Templated
            .read_start_delay           (tg_delay[31:0]),        // Templated
            .read_xsize                 (fx_xsize[15:0]),        // Templated
            .read_ysize                 (fx_ysize[15:0]));        // Templated

/*zcnn_read_mif AUTO_TEMPLATE(
 .vp_out          (@"(substring vl-cell-name 0 2)"_rm_vp),
 .ven_out         (@"(substring vl-cell-name 0 2)"_rm_ven),
 .en_out          (@"(substring vl-cell-name 0 2)"_rm_en),
 .\(d\)_out       (@"(substring vl-cell-name 0 2)"_rm_\1[]),
 .read_start      (@"(substring vl-cell-name 0 2)"_ctrlreg1[0]),
 .read_address    (@"(substring vl-cell-name 0 2)"_ctrlreg2[]),
 .read_\(.size\)  (@"(substring vl-cell-name 0 2)"_\1[]),
 .read_end_tgl    (@"(substring vl-cell-name 0 2)"_read_end_tgl),
 .mem_clk         (mem_clk),
 .mem_\(.*\)      (mr@"(substring vl-cell-name 1 2)"_\1[]),
 .vp_in           (tg_vp),
 .en_in           (sum_en_dx),
 .ren_in          (sum_ren_dx),
 .ven_in          (1'b0),
 .read_mem_size   (write_mem_size[]),
 );
 */
//zcnn_read_mif fx_rmif (/*AUTOINST*/);
assign  mrx_read       = 0;
assign  mrx_address    = 0;
assign  mrx_burstcount = 0; //16burst fix

/*zcnn_read_mif AUTO_TEMPLATE(
 .vp_out          (@"(substring vl-cell-name 0 2)"_rm_vp),
 .ven_out         (@"(substring vl-cell-name 0 2)"_rm_ven),
 .en_out          (@"(substring vl-cell-name 0 2)"_rm_en),
 .\(d\)_out       (@"(substring vl-cell-name 0 2)"_rm_\1[]),
 .read_start      (@"(substring vl-cell-name 0 2)"_ctrlreg1[0]),
 .read_address    (@"(substring vl-cell-name 0 2)"_ctrlreg2[]),
 .read_\(.size\)  (@"(substring vl-cell-name 0 2)"_\1[]),
 .read_end_tgl    (@"(substring vl-cell-name 0 2)"_read_end_tgl),
 .mem_clk         (mem_clk),
 .mem_\(.*\)      (mr@"(substring vl-cell-name 1 2)"_\1[]),
 .vp_in           (tg_vp),
 .en_in           (tg_en),
 .ren_in          (tg_ren),
 .ven_in          (tg_ven),
 .read_mem_size   (write_mem_size[]),
 .buffer_empty  (r@"(substring vl-cell-name 1 2)"_buffer_empty),
 );
 */
zcnn_read_mif f0_rmif (/*AUTOINST*/
                       // Outputs
                       .vp_out          (f0_rm_vp),              // Templated
                       .en_out          (f0_rm_en),              // Templated
                       .ven_out         (f0_rm_ven),             // Templated
                       .d_out           (f0_rm_d[17:0]),         // Templated
                       .read_end_tgl    (f0_read_end_tgl),       // Templated
                       .mem_read        (mr0_read),              // Templated
                       .mem_address     (mr0_address[25:0]),     // Templated
                       .mem_burstcount  (mr0_burstcount[7:0]),   // Templated
                       .buffer_empty    (r0_buffer_empty),       // Templated
                       // Inputs
                       .resb            (resb),
                       .clk             (clk),
                       .read_start      (f0_ctrlreg1[0]),        // Templated
                       .read_address    (f0_ctrlreg2[31:0]),     // Templated
                       .read_mem_size   (write_mem_size[31:0]),  // Templated
                       .vp_in           (tg_vp),                 // Templated
                       .en_in           (tg_en),                 // Templated
                       .ren_in          (tg_ren),                // Templated
                       .ven_in          (tg_ven),                // Templated
                       .mem_clk         (mem_clk),               // Templated
                       .mem_waitrequest (mr0_waitrequest),       // Templated
                       .mem_readdatavalid(mr0_readdatavalid),    // Templated
                       .mem_readdata    (mr0_readdata[127:0]));   // Templated
zcnn_read_mif f1_rmif (/*AUTOINST*/
                       // Outputs
                       .vp_out          (f1_rm_vp),              // Templated
                       .en_out          (f1_rm_en),              // Templated
                       .ven_out         (f1_rm_ven),             // Templated
                       .d_out           (f1_rm_d[17:0]),         // Templated
                       .read_end_tgl    (f1_read_end_tgl),       // Templated
                       .mem_read        (mr1_read),              // Templated
                       .mem_address     (mr1_address[25:0]),     // Templated
                       .mem_burstcount  (mr1_burstcount[7:0]),   // Templated
                       .buffer_empty    (r1_buffer_empty),       // Templated
                       // Inputs
                       .resb            (resb),
                       .clk             (clk),
                       .read_start      (f1_ctrlreg1[0]),        // Templated
                       .read_address    (f1_ctrlreg2[31:0]),     // Templated
                       .read_mem_size   (write_mem_size[31:0]),  // Templated
                       .vp_in           (tg_vp),                 // Templated
                       .en_in           (tg_en),                 // Templated
                       .ren_in          (tg_ren),                // Templated
                       .ven_in          (tg_ven),                // Templated
                       .mem_clk         (mem_clk),               // Templated
                       .mem_waitrequest (mr1_waitrequest),       // Templated
                       .mem_readdatavalid(mr1_readdatavalid),    // Templated
                       .mem_readdata    (mr1_readdata[127:0]));   // Templated
zcnn_read_mif f2_rmif (/*AUTOINST*/
                       // Outputs
                       .vp_out          (f2_rm_vp),              // Templated
                       .en_out          (f2_rm_en),              // Templated
                       .ven_out         (f2_rm_ven),             // Templated
                       .d_out           (f2_rm_d[17:0]),         // Templated
                       .read_end_tgl    (f2_read_end_tgl),       // Templated
                       .mem_read        (mr2_read),              // Templated
                       .mem_address     (mr2_address[25:0]),     // Templated
                       .mem_burstcount  (mr2_burstcount[7:0]),   // Templated
                       .buffer_empty    (r2_buffer_empty),       // Templated
                       // Inputs
                       .resb            (resb),
                       .clk             (clk),
                       .read_start      (f2_ctrlreg1[0]),        // Templated
                       .read_address    (f2_ctrlreg2[31:0]),     // Templated
                       .read_mem_size   (write_mem_size[31:0]),  // Templated
                       .vp_in           (tg_vp),                 // Templated
                       .en_in           (tg_en),                 // Templated
                       .ren_in          (tg_ren),                // Templated
                       .ven_in          (tg_ven),                // Templated
                       .mem_clk         (mem_clk),               // Templated
                       .mem_waitrequest (mr2_waitrequest),       // Templated
                       .mem_readdatavalid(mr2_readdatavalid),    // Templated
                       .mem_readdata    (mr2_readdata[127:0]));   // Templated
zcnn_read_mif f3_rmif (/*AUTOINST*/
                       // Outputs
                       .vp_out          (f3_rm_vp),              // Templated
                       .en_out          (f3_rm_en),              // Templated
                       .ven_out         (f3_rm_ven),             // Templated
                       .d_out           (f3_rm_d[17:0]),         // Templated
                       .read_end_tgl    (f3_read_end_tgl),       // Templated
                       .mem_read        (mr3_read),              // Templated
                       .mem_address     (mr3_address[25:0]),     // Templated
                       .mem_burstcount  (mr3_burstcount[7:0]),   // Templated
                       .buffer_empty    (r3_buffer_empty),       // Templated
                       // Inputs
                       .resb            (resb),
                       .clk             (clk),
                       .read_start      (f3_ctrlreg1[0]),        // Templated
                       .read_address    (f3_ctrlreg2[31:0]),     // Templated
                       .read_mem_size   (write_mem_size[31:0]),  // Templated
                       .vp_in           (tg_vp),                 // Templated
                       .en_in           (tg_en),                 // Templated
                       .ren_in          (tg_ren),                // Templated
                       .ven_in          (tg_ven),                // Templated
                       .mem_clk         (mem_clk),               // Templated
                       .mem_waitrequest (mr3_waitrequest),       // Templated
                       .mem_readdatavalid(mr3_readdatavalid),    // Templated
                       .mem_readdata    (mr3_readdata[127:0]));   // Templated

/*zcnn_gen_3x3 AUTO_TEMPLATE(
 .en_out          (@"(substring vl-cell-name 0 2)"_g_en),
 .\(d..\)_out     (@"(substring vl-cell-name 0 2)"_g_\1[]),
 .read_\(.size\)  (fx_\1[]),
 .vp_in           ((fx_ctrlreg0[16]) ? f0_rm_vp  : @"(substring vl-cell-name 0 2)"_rm_vp),
 .en_in           ((fx_ctrlreg0[16]) ? f0_rm_en  : @"(substring vl-cell-name 0 2)"_rm_en),
 .ven_in          ((fx_ctrlreg0[16]) ? f0_rm_ven : @"(substring vl-cell-name 0 2)"_rm_ven),
 .d_in            ((fx_ctrlreg0[16]) ? f0_rm_d[] : @"(substring vl-cell-name 0 2)"_rm_d[]),
 );
 */
zcnn_gen_3x3 f0_gen (/*AUTOINST*/
                     // Outputs
                     .en_out            (f0_g_en),               // Templated
                     .d00_out           (f0_g_d00[17:0]),        // Templated
                     .d01_out           (f0_g_d01[17:0]),        // Templated
                     .d02_out           (f0_g_d02[17:0]),        // Templated
                     .d10_out           (f0_g_d10[17:0]),        // Templated
                     .d11_out           (f0_g_d11[17:0]),        // Templated
                     .d12_out           (f0_g_d12[17:0]),        // Templated
                     .d20_out           (f0_g_d20[17:0]),        // Templated
                     .d21_out           (f0_g_d21[17:0]),        // Templated
                     .d22_out           (f0_g_d22[17:0]),        // Templated
                     // Inputs
                     .resb              (resb),
                     .clk               (clk),
                     .read_xsize        (fx_xsize[11:0]),        // Templated
                     .read_ysize        (fx_ysize[11:0]),        // Templated
                     .vp_in             ((fx_ctrlreg0[16]) ? f0_rm_vp  : f0_rm_vp), // Templated
                     .en_in             ((fx_ctrlreg0[16]) ? f0_rm_en  : f0_rm_en), // Templated
                     .ven_in            ((fx_ctrlreg0[16]) ? f0_rm_ven : f0_rm_ven), // Templated
                     .d_in              ((fx_ctrlreg0[16]) ? f0_rm_d[17:0] : f0_rm_d[17:0])); // Templated
zcnn_gen_3x3 f1_gen (/*AUTOINST*/
                     // Outputs
                     .en_out            (f1_g_en),               // Templated
                     .d00_out           (f1_g_d00[17:0]),        // Templated
                     .d01_out           (f1_g_d01[17:0]),        // Templated
                     .d02_out           (f1_g_d02[17:0]),        // Templated
                     .d10_out           (f1_g_d10[17:0]),        // Templated
                     .d11_out           (f1_g_d11[17:0]),        // Templated
                     .d12_out           (f1_g_d12[17:0]),        // Templated
                     .d20_out           (f1_g_d20[17:0]),        // Templated
                     .d21_out           (f1_g_d21[17:0]),        // Templated
                     .d22_out           (f1_g_d22[17:0]),        // Templated
                     // Inputs
                     .resb              (resb),
                     .clk               (clk),
                     .read_xsize        (fx_xsize[11:0]),        // Templated
                     .read_ysize        (fx_ysize[11:0]),        // Templated
                     .vp_in             ((fx_ctrlreg0[16]) ? f0_rm_vp  : f1_rm_vp), // Templated
                     .en_in             ((fx_ctrlreg0[16]) ? f0_rm_en  : f1_rm_en), // Templated
                     .ven_in            ((fx_ctrlreg0[16]) ? f0_rm_ven : f1_rm_ven), // Templated
                     .d_in              ((fx_ctrlreg0[16]) ? f0_rm_d[17:0] : f1_rm_d[17:0])); // Templated
zcnn_gen_3x3 f2_gen (/*AUTOINST*/
                     // Outputs
                     .en_out            (f2_g_en),               // Templated
                     .d00_out           (f2_g_d00[17:0]),        // Templated
                     .d01_out           (f2_g_d01[17:0]),        // Templated
                     .d02_out           (f2_g_d02[17:0]),        // Templated
                     .d10_out           (f2_g_d10[17:0]),        // Templated
                     .d11_out           (f2_g_d11[17:0]),        // Templated
                     .d12_out           (f2_g_d12[17:0]),        // Templated
                     .d20_out           (f2_g_d20[17:0]),        // Templated
                     .d21_out           (f2_g_d21[17:0]),        // Templated
                     .d22_out           (f2_g_d22[17:0]),        // Templated
                     // Inputs
                     .resb              (resb),
                     .clk               (clk),
                     .read_xsize        (fx_xsize[11:0]),        // Templated
                     .read_ysize        (fx_ysize[11:0]),        // Templated
                     .vp_in             ((fx_ctrlreg0[16]) ? f0_rm_vp  : f2_rm_vp), // Templated
                     .en_in             ((fx_ctrlreg0[16]) ? f0_rm_en  : f2_rm_en), // Templated
                     .ven_in            ((fx_ctrlreg0[16]) ? f0_rm_ven : f2_rm_ven), // Templated
                     .d_in              ((fx_ctrlreg0[16]) ? f0_rm_d[17:0] : f2_rm_d[17:0])); // Templated
zcnn_gen_3x3 f3_gen (/*AUTOINST*/
                     // Outputs
                     .en_out            (f3_g_en),               // Templated
                     .d00_out           (f3_g_d00[17:0]),        // Templated
                     .d01_out           (f3_g_d01[17:0]),        // Templated
                     .d02_out           (f3_g_d02[17:0]),        // Templated
                     .d10_out           (f3_g_d10[17:0]),        // Templated
                     .d11_out           (f3_g_d11[17:0]),        // Templated
                     .d12_out           (f3_g_d12[17:0]),        // Templated
                     .d20_out           (f3_g_d20[17:0]),        // Templated
                     .d21_out           (f3_g_d21[17:0]),        // Templated
                     .d22_out           (f3_g_d22[17:0]),        // Templated
                     // Inputs
                     .resb              (resb),
                     .clk               (clk),
                     .read_xsize        (fx_xsize[11:0]),        // Templated
                     .read_ysize        (fx_ysize[11:0]),        // Templated
                     .vp_in             ((fx_ctrlreg0[16]) ? f0_rm_vp  : f3_rm_vp), // Templated
                     .en_in             ((fx_ctrlreg0[16]) ? f0_rm_en  : f3_rm_en), // Templated
                     .ven_in            ((fx_ctrlreg0[16]) ? f0_rm_ven : f3_rm_ven), // Templated
                     .d_in              ((fx_ctrlreg0[16]) ? f0_rm_d[17:0] : f3_rm_d[17:0])); // Templated

/*zcnn_fil_3x3 AUTO_TEMPLATE(
 .\(w..\)_in (@"(substring vl-cell-name 0 2)"_\1[]),
 .\(bias\)_in (@"(substring vl-cell-name 0 2)"_\1[]),
 .en_out      (@"(substring vl-cell-name 0 2)"_f_en),
 .d_out       (@"(substring vl-cell-name 0 2)"_f_d[]),
 .\(d..\)_in  (@"(substring vl-cell-name 0 2)"_g_\1[]),
 .\(en\)_in   (@"(substring vl-cell-name 0 2)"_g_\1[]),
 );
 */
zcnn_fil_3x3 f0_fil (/*AUTOINST*/
                     // Outputs
                     .en_out            (f0_f_en),               // Templated
                     .d_out             (f0_f_d[17:0]),          // Templated
                     // Inputs
                     .resb              (resb),
                     .clk               (clk),
                     .en_in             (f0_g_en),               // Templated
                     .d00_in            (f0_g_d00[17:0]),        // Templated
                     .d01_in            (f0_g_d01[17:0]),        // Templated
                     .d02_in            (f0_g_d02[17:0]),        // Templated
                     .d10_in            (f0_g_d10[17:0]),        // Templated
                     .d11_in            (f0_g_d11[17:0]),        // Templated
                     .d12_in            (f0_g_d12[17:0]),        // Templated
                     .d20_in            (f0_g_d20[17:0]),        // Templated
                     .d21_in            (f0_g_d21[17:0]),        // Templated
                     .d22_in            (f0_g_d22[17:0]),        // Templated
                     .w00_in            (f0_w00[17:0]),          // Templated
                     .w01_in            (f0_w01[17:0]),          // Templated
                     .w02_in            (f0_w02[17:0]),          // Templated
                     .w10_in            (f0_w10[17:0]),          // Templated
                     .w11_in            (f0_w11[17:0]),          // Templated
                     .w12_in            (f0_w12[17:0]),          // Templated
                     .w20_in            (f0_w20[17:0]),          // Templated
                     .w21_in            (f0_w21[17:0]),          // Templated
                     .w22_in            (f0_w22[17:0]));          // Templated
zcnn_fil_3x3 f1_fil (/*AUTOINST*/
                     // Outputs
                     .en_out            (f1_f_en),               // Templated
                     .d_out             (f1_f_d[17:0]),          // Templated
                     // Inputs
                     .resb              (resb),
                     .clk               (clk),
                     .en_in             (f1_g_en),               // Templated
                     .d00_in            (f1_g_d00[17:0]),        // Templated
                     .d01_in            (f1_g_d01[17:0]),        // Templated
                     .d02_in            (f1_g_d02[17:0]),        // Templated
                     .d10_in            (f1_g_d10[17:0]),        // Templated
                     .d11_in            (f1_g_d11[17:0]),        // Templated
                     .d12_in            (f1_g_d12[17:0]),        // Templated
                     .d20_in            (f1_g_d20[17:0]),        // Templated
                     .d21_in            (f1_g_d21[17:0]),        // Templated
                     .d22_in            (f1_g_d22[17:0]),        // Templated
                     .w00_in            (f1_w00[17:0]),          // Templated
                     .w01_in            (f1_w01[17:0]),          // Templated
                     .w02_in            (f1_w02[17:0]),          // Templated
                     .w10_in            (f1_w10[17:0]),          // Templated
                     .w11_in            (f1_w11[17:0]),          // Templated
                     .w12_in            (f1_w12[17:0]),          // Templated
                     .w20_in            (f1_w20[17:0]),          // Templated
                     .w21_in            (f1_w21[17:0]),          // Templated
                     .w22_in            (f1_w22[17:0]));          // Templated
zcnn_fil_3x3 f2_fil (/*AUTOINST*/
                     // Outputs
                     .en_out            (f2_f_en),               // Templated
                     .d_out             (f2_f_d[17:0]),          // Templated
                     // Inputs
                     .resb              (resb),
                     .clk               (clk),
                     .en_in             (f2_g_en),               // Templated
                     .d00_in            (f2_g_d00[17:0]),        // Templated
                     .d01_in            (f2_g_d01[17:0]),        // Templated
                     .d02_in            (f2_g_d02[17:0]),        // Templated
                     .d10_in            (f2_g_d10[17:0]),        // Templated
                     .d11_in            (f2_g_d11[17:0]),        // Templated
                     .d12_in            (f2_g_d12[17:0]),        // Templated
                     .d20_in            (f2_g_d20[17:0]),        // Templated
                     .d21_in            (f2_g_d21[17:0]),        // Templated
                     .d22_in            (f2_g_d22[17:0]),        // Templated
                     .w00_in            (f2_w00[17:0]),          // Templated
                     .w01_in            (f2_w01[17:0]),          // Templated
                     .w02_in            (f2_w02[17:0]),          // Templated
                     .w10_in            (f2_w10[17:0]),          // Templated
                     .w11_in            (f2_w11[17:0]),          // Templated
                     .w12_in            (f2_w12[17:0]),          // Templated
                     .w20_in            (f2_w20[17:0]),          // Templated
                     .w21_in            (f2_w21[17:0]),          // Templated
                     .w22_in            (f2_w22[17:0]));          // Templated
zcnn_fil_3x3 f3_fil (/*AUTOINST*/
                     // Outputs
                     .en_out            (f3_f_en),               // Templated
                     .d_out             (f3_f_d[17:0]),          // Templated
                     // Inputs
                     .resb              (resb),
                     .clk               (clk),
                     .en_in             (f3_g_en),               // Templated
                     .d00_in            (f3_g_d00[17:0]),        // Templated
                     .d01_in            (f3_g_d01[17:0]),        // Templated
                     .d02_in            (f3_g_d02[17:0]),        // Templated
                     .d10_in            (f3_g_d10[17:0]),        // Templated
                     .d11_in            (f3_g_d11[17:0]),        // Templated
                     .d12_in            (f3_g_d12[17:0]),        // Templated
                     .d20_in            (f3_g_d20[17:0]),        // Templated
                     .d21_in            (f3_g_d21[17:0]),        // Templated
                     .d22_in            (f3_g_d22[17:0]),        // Templated
                     .w00_in            (f3_w00[17:0]),          // Templated
                     .w01_in            (f3_w01[17:0]),          // Templated
                     .w02_in            (f3_w02[17:0]),          // Templated
                     .w10_in            (f3_w10[17:0]),          // Templated
                     .w11_in            (f3_w11[17:0]),          // Templated
                     .w12_in            (f3_w12[17:0]),          // Templated
                     .w20_in            (f3_w20[17:0]),          // Templated
                     .w21_in            (f3_w21[17:0]),          // Templated
                     .w22_in            (f3_w22[17:0]));          // Templated


/*zcnn_sum AUTO_TEMPLATE(
 .en_out    (fx_sum_en),
 .d_out     (fx_sum_d[]),
 .dx_on     (fx_ctrlreg0[8]),
 .d0_on     (fx_ctrlreg0[9]),
 .d1_on     (fx_ctrlreg0[10]),
 .d2_on     (fx_ctrlreg0[11]),
 .d3_on     (fx_ctrlreg0[12]),
 .en_in     (f0_f_en | f1_f_en | f2_f_en | f3_f_en),
 .dx_in     (fx_ctrlreg0[17] ? f_c_d[] : fx_rm_d[]),
 .d0_in     (f0_f_d[]),
 .d1_in     (f1_f_d[]),
 .d2_in     (f2_f_d[]),
 .d3_in     (f3_f_d[]),
 .en_dx     (sum_en_dx),
 .ren_dx    (sum_ren_dx),
 .vp_in     (tg_vp),
 );
 */
zcnn_sum f_sum (/*AUTOINST*/
                // Outputs
                .en_out                 (fx_sum_en),             // Templated
                .d_out                  (fx_sum_d[17:0]),        // Templated
                .en_dx                  (sum_en_dx),             // Templated
                .ren_dx                 (sum_ren_dx),            // Templated
                // Inputs
                .resb                   (resb),
                .clk                    (clk),
                .dx_on                  (fx_ctrlreg0[8]),        // Templated
                .d0_on                  (fx_ctrlreg0[9]),        // Templated
                .d1_on                  (fx_ctrlreg0[10]),       // Templated
                .d2_on                  (fx_ctrlreg0[11]),       // Templated
                .d3_on                  (fx_ctrlreg0[12]),       // Templated
                .en_in                  (f0_f_en | f1_f_en | f2_f_en | f3_f_en), // Templated
                .dx_in                  (fx_ctrlreg0[17] ? f_c_d[17:0] : fx_rm_d[17:0]), // Templated
                .d0_in                  (f0_f_d[17:0]),          // Templated
                .d1_in                  (f1_f_d[17:0]),          // Templated
                .d2_in                  (f2_f_d[17:0]),          // Templated
                .d3_in                  (f3_f_d[17:0]),          // Templated
                .vp_in                  (tg_vp));                 // Templated

wire        fx_mm_en;
wire [31:0] fx_mm_d;
wire        f0_mm_en;
wire [31:0] f0_mm_d;
wire        f1_mm_en;
wire [31:0] f1_mm_d;
wire        f2_mm_en;
wire [31:0] f2_mm_d;
wire        f3_mm_en;
wire [31:0] f3_mm_d;

/*zcnn_maxmin AUTO_TEMPLATE(
 .maxmin_on   (@"(substring vl-cell-name 0 2)"_ctrlreg1[4]),
 .\(bias\)_in (@"(substring vl-cell-name 0 2)"_\1[]),
 .d_in    (fx_sum_d[]),
 .en_in   (fx_sum_en),
 .en_out  (fx_mm_en[]),
 .d_out   (fx_mm_d[]),
 );
 */
zcnn_maxmin fx_mm (/*AUTOINST*/
                   // Outputs
                   .en_out              (fx_mm_en),              // Templated
                   .d_out               (fx_mm_d[17:0]),         // Templated
                   // Inputs
                   .resb                (resb),
                   .clk                 (clk),
                   .maxmin_on           (fx_ctrlreg1[4]),        // Templated
                   .bias_in             (fx_bias[17:0]),         // Templated
                   .en_in               (fx_sum_en),             // Templated
                   .d_in                (fx_sum_d[17:0]));        // Templated

/*zcnn_maxmin AUTO_TEMPLATE(
 .maxmin_on   (@"(substring vl-cell-name 0 2)"_ctrlreg1[4]),
 .\(bias\)_in (@"(substring vl-cell-name 0 2)"_\1[]),
 .d_in    (@"(substring vl-cell-name 0 2)"_f_d[]),
 .en_in   (@"(substring vl-cell-name 0 2)"_f_en),
 .en_out  (@"(substring vl-cell-name 0 2)"_mm_en[]),
 .d_out   (@"(substring vl-cell-name 0 2)"_mm_d[]),
 );
 */
zcnn_maxmin f0_mm (/*AUTOINST*/
                   // Outputs
                   .en_out              (f0_mm_en),              // Templated
                   .d_out               (f0_mm_d[17:0]),         // Templated
                   // Inputs
                   .resb                (resb),
                   .clk                 (clk),
                   .maxmin_on           (f0_ctrlreg1[4]),        // Templated
                   .bias_in             (f0_bias[17:0]),         // Templated
                   .en_in               (f0_f_en),               // Templated
                   .d_in                (f0_f_d[17:0]));          // Templated
zcnn_maxmin f1_mm (/*AUTOINST*/
                   // Outputs
                   .en_out              (f1_mm_en),              // Templated
                   .d_out               (f1_mm_d[17:0]),         // Templated
                   // Inputs
                   .resb                (resb),
                   .clk                 (clk),
                   .maxmin_on           (f1_ctrlreg1[4]),        // Templated
                   .bias_in             (f1_bias[17:0]),         // Templated
                   .en_in               (f1_f_en),               // Templated
                   .d_in                (f1_f_d[17:0]));          // Templated
zcnn_maxmin f2_mm (/*AUTOINST*/
                   // Outputs
                   .en_out              (f2_mm_en),              // Templated
                   .d_out               (f2_mm_d[17:0]),         // Templated
                   // Inputs
                   .resb                (resb),
                   .clk                 (clk),
                   .maxmin_on           (f2_ctrlreg1[4]),        // Templated
                   .bias_in             (f2_bias[17:0]),         // Templated
                   .en_in               (f2_f_en),               // Templated
                   .d_in                (f2_f_d[17:0]));          // Templated
zcnn_maxmin f3_mm (/*AUTOINST*/
                   // Outputs
                   .en_out              (f3_mm_en),              // Templated
                   .d_out               (f3_mm_d[17:0]),         // Templated
                   // Inputs
                   .resb                (resb),
                   .clk                 (clk),
                   .maxmin_on           (f3_ctrlreg1[4]),        // Templated
                   .bias_in             (f3_bias[17:0]),         // Templated
                   .en_in               (f3_f_en),               // Templated
                   .d_in                (f3_f_d[17:0]));          // Templated

/*zcnn_write_mif AUTO_TEMPLATE(
 .mem_clk       (mem_clk),
 .mem_\(.*\)    (mw@"(substring vl-cell-name 1 2)"_\1[]),
 .write_start   (@"(substring vl-cell-name 0 2)"_ctrlreg1[1]),
 .write_address (@"(substring vl-cell-name 0 2)"_ctrlreg3[]),
 .write_xsize   (@"(substring vl-cell-name 0 2)"_xsize[]),
 .write_ysize   (@"(substring vl-cell-name 0 2)"_ysize[]),
 .write_end_tgl (@"(substring vl-cell-name 0 2)"_write_end_tgl),
 .en_in         (@"(substring vl-cell-name 0 2)"_mm_en),
 .d_in          (@"(substring vl-cell-name 0 2)"_mm_d[]),
 .buffer_empty  (@"(substring vl-cell-name 0 2)"_buffer_empty),
 .buffer_full   (@"(substring vl-cell-name 0 2)"_buffer_full),
 );
 */

zcnn_write_mif f0_wmif (/*AUTOINST*/
                        // Outputs
                        .write_end_tgl  (f0_write_end_tgl),      // Templated
                        .mem_write      (mw0_write),             // Templated
                        .mem_address    (mw0_address[25:0]),     // Templated
                        .mem_writedata  (mw0_writedata[127:0]),  // Templated
                        .mem_burstcount (mw0_burstcount[7:0]),   // Templated
                        .buffer_empty   (f0_buffer_empty),       // Templated
                        .buffer_full    (f0_buffer_full),        // Templated
                        // Inputs
                        .resb           (resb),
                        .clk            (clk),
                        .write_start    (f0_ctrlreg1[1]),        // Templated
                        .write_address  (f0_ctrlreg3[31:0]),     // Templated
                        .write_size     (write_size[31:0]),
                        .en_in          (f0_mm_en),              // Templated
                        .d_in           (f0_mm_d[17:0]),         // Templated
                        .mem_clk        (mem_clk),               // Templated
                        .mem_waitrequest(mw0_waitrequest));       // Templated
zcnn_write_mif f1_wmif (/*AUTOINST*/
                        // Outputs
                        .write_end_tgl  (f1_write_end_tgl),      // Templated
                        .mem_write      (mw1_write),             // Templated
                        .mem_address    (mw1_address[25:0]),     // Templated
                        .mem_writedata  (mw1_writedata[127:0]),  // Templated
                        .mem_burstcount (mw1_burstcount[7:0]),   // Templated
                        .buffer_empty   (f1_buffer_empty),       // Templated
                        .buffer_full    (f1_buffer_full),        // Templated
                        // Inputs
                        .resb           (resb),
                        .clk            (clk),
                        .write_start    (f1_ctrlreg1[1]),        // Templated
                        .write_address  (f1_ctrlreg3[31:0]),     // Templated
                        .write_size     (write_size[31:0]),
                        .en_in          (f1_mm_en),              // Templated
                        .d_in           (f1_mm_d[17:0]),         // Templated
                        .mem_clk        (mem_clk),               // Templated
                        .mem_waitrequest(mw1_waitrequest));       // Templated
zcnn_write_mif f2_wmif (/*AUTOINST*/
                        // Outputs
                        .write_end_tgl  (f2_write_end_tgl),      // Templated
                        .mem_write      (mw2_write),             // Templated
                        .mem_address    (mw2_address[25:0]),     // Templated
                        .mem_writedata  (mw2_writedata[127:0]),  // Templated
                        .mem_burstcount (mw2_burstcount[7:0]),   // Templated
                        .buffer_empty   (f2_buffer_empty),       // Templated
                        .buffer_full    (f2_buffer_full),        // Templated
                        // Inputs
                        .resb           (resb),
                        .clk            (clk),
                        .write_start    (f2_ctrlreg1[1]),        // Templated
                        .write_address  (f2_ctrlreg3[31:0]),     // Templated
                        .write_size     (write_size[31:0]),
                        .en_in          (f2_mm_en),              // Templated
                        .d_in           (f2_mm_d[17:0]),         // Templated
                        .mem_clk        (mem_clk),               // Templated
                        .mem_waitrequest(mw2_waitrequest));       // Templated
zcnn_write_mif f3_wmif (/*AUTOINST*/
                        // Outputs
                        .write_end_tgl  (f3_write_end_tgl),      // Templated
                        .mem_write      (mw3_write),             // Templated
                        .mem_address    (mw3_address[25:0]),     // Templated
                        .mem_writedata  (mw3_writedata[127:0]),  // Templated
                        .mem_burstcount (mw3_burstcount[7:0]),   // Templated
                        .buffer_empty   (f3_buffer_empty),       // Templated
                        .buffer_full    (f3_buffer_full),        // Templated
                        // Inputs
                        .resb           (resb),
                        .clk            (clk),
                        .write_start    (f3_ctrlreg1[1]),        // Templated
                        .write_address  (f3_ctrlreg3[31:0]),     // Templated
                        .write_size     (write_size[31:0]),
                        .en_in          (f3_mm_en),              // Templated
                        .d_in           (f3_mm_d[17:0]),         // Templated
                        .mem_clk        (mem_clk),               // Templated
                        .mem_waitrequest(mw3_waitrequest));       // Templated

/*zcnn_cache AUTO_TEMPLATE(
 .wvp_in    (tg_vp),
 .wen_in    (fx_mm_en),
 .wd_in     (fx_mm_d[]),
 .rvp_in    (tg_vp),
 .ren_in    (sum_en_dx),
 .rd_out    (f_c_d[]),
 .write_cache_on (fx_ctrlreg0[17]),
 .write_address  (fx_ctrlreg3[]),
 .write_xsize    (fx_xsize[]),
 .write_ysize    (fx_ysize[]),
 .mem_clk       (mem_clk),
 .mem_\(.*\)    (mw@"(substring vl-cell-name 1 2)"_\1[]),
 .write_start   (@"(substring vl-cell-name 0 2)"_ctrlreg1[1]),
 .write_end_tgl (@"(substring vl-cell-name 0 2)"_write_end_tgl),
 .buffer_empty (fx_buffer_empty),
 );
 */

zcnn_cache fx_wmif
(/*AUTOINST*/
 // Outputs
 .rd_out                                (f_c_d[17:0]),           // Templated
 .cache_end_tgl                         (cache_end_tgl),
 .write_end_tgl                         (fx_write_end_tgl),      // Templated
 .mem_write                             (mwx_write),             // Templated
 .mem_address                           (mwx_address[25:0]),     // Templated
 .mem_writedata                         (mwx_writedata[127:0]),  // Templated
 .mem_burstcount                        (mwx_burstcount[7:0]),   // Templated
 .buffer_empty                          (fx_buffer_empty),       // Templated
 // Inputs
 .resb                                  (resb),
 .clk                                   (clk),
 .wvp_in                                (tg_vp),                 // Templated
 .wen_in                                (fx_mm_en),              // Templated
 .wd_in                                 (fx_mm_d[17:0]),         // Templated
 .rvp_in                                (tg_vp),                 // Templated
 .ren_in                                (sum_en_dx),             // Templated
 .write_cache_on                        (fx_ctrlreg0[17]),       // Templated
 .write_start                           (fx_ctrlreg1[1]),        // Templated
 .write_address                         (fx_ctrlreg3[31:0]),     // Templated
 .write_size                            (write_size[31:0]),
 .write_mem_size                        (write_mem_size[31:0]),
 .mem_clk                               (mem_clk),               // Templated
 .mem_waitrequest                       (mwx_waitrequest));       // Templated


//ADD
/*zcnn_fil_3x3 AUTO_TEMPLATE(
 .\(w..\)_in (@"(substring vl-cell-name 3 5)"_\1[]),
 .\(bias\)_in (@"(substring vl-cell-name 0 2)"_\1[]),
 .en_out      (@"(substring vl-cell-name 3 5)"_f_en),
 .d_out       (@"(substring vl-cell-name 3 5)"_f_d[]),
 .\(d..\)_in  (@"(substring vl-cell-name 0 2)"_g_\1[]),
 .\(en\)_in   (@"(substring vl-cell-name 0 2)"_g_\1[]),
 );
 */
zcnn_fil_3x3 f0_a0_fil (/*AUTOINST*/
                        // Outputs
                        .en_out         (a0_f_en),               // Templated
                        .d_out          (a0_f_d[17:0]),          // Templated
                        // Inputs
                        .resb           (resb),
                        .clk            (clk),
                        .en_in          (f0_g_en),               // Templated
                        .d00_in         (f0_g_d00[17:0]),        // Templated
                        .d01_in         (f0_g_d01[17:0]),        // Templated
                        .d02_in         (f0_g_d02[17:0]),        // Templated
                        .d10_in         (f0_g_d10[17:0]),        // Templated
                        .d11_in         (f0_g_d11[17:0]),        // Templated
                        .d12_in         (f0_g_d12[17:0]),        // Templated
                        .d20_in         (f0_g_d20[17:0]),        // Templated
                        .d21_in         (f0_g_d21[17:0]),        // Templated
                        .d22_in         (f0_g_d22[17:0]),        // Templated
                        .w00_in         (a0_w00[17:0]),          // Templated
                        .w01_in         (a0_w01[17:0]),          // Templated
                        .w02_in         (a0_w02[17:0]),          // Templated
                        .w10_in         (a0_w10[17:0]),          // Templated
                        .w11_in         (a0_w11[17:0]),          // Templated
                        .w12_in         (a0_w12[17:0]),          // Templated
                        .w20_in         (a0_w20[17:0]),          // Templated
                        .w21_in         (a0_w21[17:0]),          // Templated
                        .w22_in         (a0_w22[17:0]));          // Templated
zcnn_fil_3x3 f1_a1_fil (/*AUTOINST*/
                        // Outputs
                        .en_out         (a1_f_en),               // Templated
                        .d_out          (a1_f_d[17:0]),          // Templated
                        // Inputs
                        .resb           (resb),
                        .clk            (clk),
                        .en_in          (f1_g_en),               // Templated
                        .d00_in         (f1_g_d00[17:0]),        // Templated
                        .d01_in         (f1_g_d01[17:0]),        // Templated
                        .d02_in         (f1_g_d02[17:0]),        // Templated
                        .d10_in         (f1_g_d10[17:0]),        // Templated
                        .d11_in         (f1_g_d11[17:0]),        // Templated
                        .d12_in         (f1_g_d12[17:0]),        // Templated
                        .d20_in         (f1_g_d20[17:0]),        // Templated
                        .d21_in         (f1_g_d21[17:0]),        // Templated
                        .d22_in         (f1_g_d22[17:0]),        // Templated
                        .w00_in         (a1_w00[17:0]),          // Templated
                        .w01_in         (a1_w01[17:0]),          // Templated
                        .w02_in         (a1_w02[17:0]),          // Templated
                        .w10_in         (a1_w10[17:0]),          // Templated
                        .w11_in         (a1_w11[17:0]),          // Templated
                        .w12_in         (a1_w12[17:0]),          // Templated
                        .w20_in         (a1_w20[17:0]),          // Templated
                        .w21_in         (a1_w21[17:0]),          // Templated
                        .w22_in         (a1_w22[17:0]));          // Templated
zcnn_fil_3x3 f2_a2_fil (/*AUTOINST*/
                        // Outputs
                        .en_out         (a2_f_en),               // Templated
                        .d_out          (a2_f_d[17:0]),          // Templated
                        // Inputs
                        .resb           (resb),
                        .clk            (clk),
                        .en_in          (f2_g_en),               // Templated
                        .d00_in         (f2_g_d00[17:0]),        // Templated
                        .d01_in         (f2_g_d01[17:0]),        // Templated
                        .d02_in         (f2_g_d02[17:0]),        // Templated
                        .d10_in         (f2_g_d10[17:0]),        // Templated
                        .d11_in         (f2_g_d11[17:0]),        // Templated
                        .d12_in         (f2_g_d12[17:0]),        // Templated
                        .d20_in         (f2_g_d20[17:0]),        // Templated
                        .d21_in         (f2_g_d21[17:0]),        // Templated
                        .d22_in         (f2_g_d22[17:0]),        // Templated
                        .w00_in         (a2_w00[17:0]),          // Templated
                        .w01_in         (a2_w01[17:0]),          // Templated
                        .w02_in         (a2_w02[17:0]),          // Templated
                        .w10_in         (a2_w10[17:0]),          // Templated
                        .w11_in         (a2_w11[17:0]),          // Templated
                        .w12_in         (a2_w12[17:0]),          // Templated
                        .w20_in         (a2_w20[17:0]),          // Templated
                        .w21_in         (a2_w21[17:0]),          // Templated
                        .w22_in         (a2_w22[17:0]));          // Templated
zcnn_fil_3x3 f3_a3_fil (/*AUTOINST*/
                        // Outputs
                        .en_out         (a3_f_en),               // Templated
                        .d_out          (a3_f_d[17:0]),          // Templated
                        // Inputs
                        .resb           (resb),
                        .clk            (clk),
                        .en_in          (f3_g_en),               // Templated
                        .d00_in         (f3_g_d00[17:0]),        // Templated
                        .d01_in         (f3_g_d01[17:0]),        // Templated
                        .d02_in         (f3_g_d02[17:0]),        // Templated
                        .d10_in         (f3_g_d10[17:0]),        // Templated
                        .d11_in         (f3_g_d11[17:0]),        // Templated
                        .d12_in         (f3_g_d12[17:0]),        // Templated
                        .d20_in         (f3_g_d20[17:0]),        // Templated
                        .d21_in         (f3_g_d21[17:0]),        // Templated
                        .d22_in         (f3_g_d22[17:0]),        // Templated
                        .w00_in         (a3_w00[17:0]),          // Templated
                        .w01_in         (a3_w01[17:0]),          // Templated
                        .w02_in         (a3_w02[17:0]),          // Templated
                        .w10_in         (a3_w10[17:0]),          // Templated
                        .w11_in         (a3_w11[17:0]),          // Templated
                        .w12_in         (a3_w12[17:0]),          // Templated
                        .w20_in         (a3_w20[17:0]),          // Templated
                        .w21_in         (a3_w21[17:0]),          // Templated
                        .w22_in         (a3_w22[17:0]));          // Templated


/*zcnn_sum AUTO_TEMPLATE(
 .en_out    (ax_sum_en),
 .d_out     (ax_sum_d[]),
 .dx_on     (ax_ctrlreg0[8]),
 .d0_on     (ax_ctrlreg0[9]),
 .d1_on     (ax_ctrlreg0[10]),
 .d2_on     (ax_ctrlreg0[11]),
 .d3_on     (ax_ctrlreg0[12]),
 .en_in     (a0_f_en | a1_f_en | a2_f_en | a3_f_en),
 .dx_in     (a_c_d[]),
 .d0_in     (a0_f_d[]),
 .d1_in     (a1_f_d[]),
 .d2_in     (a2_f_d[]),
 .d3_in     (a3_f_d[]),
 .en_dx     (sum2_en_dx),
 .ren_dx    (sum2_ren_dx),
 .vp_in     (tg_vp),
 );
 */
zcnn_sum a_sum (/*AUTOINST*/
                // Outputs
                .en_out                 (ax_sum_en),             // Templated
                .d_out                  (ax_sum_d[17:0]),        // Templated
                .en_dx                  (sum2_en_dx),            // Templated
                .ren_dx                 (sum2_ren_dx),           // Templated
                // Inputs
                .resb                   (resb),
                .clk                    (clk),
                .dx_on                  (ax_ctrlreg0[8]),        // Templated
                .d0_on                  (ax_ctrlreg0[9]),        // Templated
                .d1_on                  (ax_ctrlreg0[10]),       // Templated
                .d2_on                  (ax_ctrlreg0[11]),       // Templated
                .d3_on                  (ax_ctrlreg0[12]),       // Templated
                .en_in                  (a0_f_en | a1_f_en | a2_f_en | a3_f_en), // Templated
                .dx_in                  (a_c_d[17:0]),           // Templated
                .d0_in                  (a0_f_d[17:0]),          // Templated
                .d1_in                  (a1_f_d[17:0]),          // Templated
                .d2_in                  (a2_f_d[17:0]),          // Templated
                .d3_in                  (a3_f_d[17:0]),          // Templated
                .vp_in                  (tg_vp));                 // Templated

wire        ax_mm_en;
wire [31:0] ax_mm_d;

/*zcnn_maxmin AUTO_TEMPLATE(
 .maxmin_on   (@"(substring vl-cell-name 0 2)"_ctrlreg1[4]),
 .\(bias\)_in (@"(substring vl-cell-name 0 2)"_\1[]),
 .d_in    (ax_sum_d[]),
 .en_in   (ax_sum_en),
 .en_out  (ax_mm_en[]),
 .d_out   (ax_mm_d[]),
 );
 */
zcnn_maxmin ax_mm (/*AUTOINST*/
                   // Outputs
                   .en_out              (ax_mm_en),              // Templated
                   .d_out               (ax_mm_d[17:0]),         // Templated
                   // Inputs
                   .resb                (resb),
                   .clk                 (clk),
                   .maxmin_on           (ax_ctrlreg1[4]),        // Templated
                   .bias_in             (ax_bias[17:0]),         // Templated
                   .en_in               (ax_sum_en),             // Templated
                   .d_in                (ax_sum_d[17:0]));        // Templated

/*zcnn_cache AUTO_TEMPLATE(
 .wvp_in    (tg_vp),
 .wen_in    (ax_mm_en),
 .wd_in     (ax_mm_d[]),
 .rvp_in    (tg_vp),
 .ren_in    (sum2_en_dx),
 .rd_out    (a_c_d[]),
 .cache_end_tgl (),
 .write_cache_on (ax_ctrlreg0[17]),
 .write_address  (ax_ctrlreg3[]),
 .write_xsize    (ax_xsize[]),
 .write_ysize    (ax_ysize[]),
 .mem_clk       (mem_clk),
 .mem_\(.*\)    (mw@"(substring vl-cell-name 0 1)"_\1[]),
 .write_start   (@"(substring vl-cell-name 0 2)"_ctrlreg1[1]),
 .write_end_tgl (ax_write_end_tgl),
 .buffer_empty (ax_buffer_empty),
 );
 */
zcnn_cache ax_wmif
(/*AUTOINST*/
 // Outputs
 .rd_out                                (a_c_d[17:0]),           // Templated
 .cache_end_tgl                         (),                      // Templated
 .write_end_tgl                         (ax_write_end_tgl),      // Templated
 .mem_write                             (mwa_write),             // Templated
 .mem_address                           (mwa_address[25:0]),     // Templated
 .mem_writedata                         (mwa_writedata[127:0]),  // Templated
 .mem_burstcount                        (mwa_burstcount[7:0]),   // Templated
 .buffer_empty                          (ax_buffer_empty),       // Templated
 // Inputs
 .resb                                  (resb),
 .clk                                   (clk),
 .wvp_in                                (tg_vp),                 // Templated
 .wen_in                                (ax_mm_en),              // Templated
 .wd_in                                 (ax_mm_d[17:0]),         // Templated
 .rvp_in                                (tg_vp),                 // Templated
 .ren_in                                (sum2_en_dx),            // Templated
 .write_cache_on                        (ax_ctrlreg0[17]),       // Templated
 .write_start                           (ax_ctrlreg1[1]),        // Templated
 .write_address                         (ax_ctrlreg3[31:0]),     // Templated
 .write_size                            (write_size[31:0]),
 .write_mem_size                        (write_mem_size[31:0]),
 .mem_clk                               (mem_clk),               // Templated
 .mem_waitrequest                       (mwa_waitrequest));       // Templated







endmodule // top

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
