// fpga_mem_mm_interconnect_1.v

// This file was auto-generated from altera_merlin_interconnect_wrapper_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 13.1 182 at 2015.06.18.23:37:56

`timescale 1 ps / 1 ps
module fpga_mem_mm_interconnect_1 (
		input  wire         mem_if_ddr3_emif_0_afi_clk_clk,                                      //                                    mem_if_ddr3_emif_0_afi_clk.clk
		input  wire         center_mm_bridge_reset_reset_bridge_in_reset_reset,                  //                  center_mm_bridge_reset_reset_bridge_in_reset.reset
		input  wire         mem_if_ddr3_emif_0_avl_translator_reset_reset_bridge_in_reset_reset, // mem_if_ddr3_emif_0_avl_translator_reset_reset_bridge_in_reset.reset
		input  wire [25:0]  center_mm_bridge_m0_address,                                         //                                           center_mm_bridge_m0.address
		output wire         center_mm_bridge_m0_waitrequest,                                     //                                                              .waitrequest
		input  wire [5:0]   center_mm_bridge_m0_burstcount,                                      //                                                              .burstcount
		input  wire [15:0]  center_mm_bridge_m0_byteenable,                                      //                                                              .byteenable
		input  wire         center_mm_bridge_m0_read,                                            //                                                              .read
		output wire [127:0] center_mm_bridge_m0_readdata,                                        //                                                              .readdata
		output wire         center_mm_bridge_m0_readdatavalid,                                   //                                                              .readdatavalid
		input  wire         center_mm_bridge_m0_write,                                           //                                                              .write
		input  wire [127:0] center_mm_bridge_m0_writedata,                                       //                                                              .writedata
		input  wire         center_mm_bridge_m0_debugaccess,                                     //                                                              .debugaccess
		output wire [25:0]  mem_if_ddr3_emif_0_avl_address,                                      //                                        mem_if_ddr3_emif_0_avl.address
		output wire         mem_if_ddr3_emif_0_avl_write,                                        //                                                              .write
		output wire         mem_if_ddr3_emif_0_avl_read,                                         //                                                              .read
		input  wire [127:0] mem_if_ddr3_emif_0_avl_readdata,                                     //                                                              .readdata
		output wire [127:0] mem_if_ddr3_emif_0_avl_writedata,                                    //                                                              .writedata
		output wire         mem_if_ddr3_emif_0_avl_beginbursttransfer,                           //                                                              .beginbursttransfer
		output wire [5:0]   mem_if_ddr3_emif_0_avl_burstcount,                                   //                                                              .burstcount
		output wire [15:0]  mem_if_ddr3_emif_0_avl_byteenable,                                   //                                                              .byteenable
		input  wire         mem_if_ddr3_emif_0_avl_readdatavalid,                                //                                                              .readdatavalid
		input  wire         mem_if_ddr3_emif_0_avl_waitrequest                                   //                                                              .waitrequest
	);

	wire          center_mm_bridge_m0_translator_avalon_universal_master_0_waitrequest;   // mem_if_ddr3_emif_0_avl_translator:uav_waitrequest -> center_mm_bridge_m0_translator:uav_waitrequest
	wire    [9:0] center_mm_bridge_m0_translator_avalon_universal_master_0_burstcount;    // center_mm_bridge_m0_translator:uav_burstcount -> mem_if_ddr3_emif_0_avl_translator:uav_burstcount
	wire  [127:0] center_mm_bridge_m0_translator_avalon_universal_master_0_writedata;     // center_mm_bridge_m0_translator:uav_writedata -> mem_if_ddr3_emif_0_avl_translator:uav_writedata
	wire   [29:0] center_mm_bridge_m0_translator_avalon_universal_master_0_address;       // center_mm_bridge_m0_translator:uav_address -> mem_if_ddr3_emif_0_avl_translator:uav_address
	wire          center_mm_bridge_m0_translator_avalon_universal_master_0_lock;          // center_mm_bridge_m0_translator:uav_lock -> mem_if_ddr3_emif_0_avl_translator:uav_lock
	wire          center_mm_bridge_m0_translator_avalon_universal_master_0_write;         // center_mm_bridge_m0_translator:uav_write -> mem_if_ddr3_emif_0_avl_translator:uav_write
	wire          center_mm_bridge_m0_translator_avalon_universal_master_0_read;          // center_mm_bridge_m0_translator:uav_read -> mem_if_ddr3_emif_0_avl_translator:uav_read
	wire  [127:0] center_mm_bridge_m0_translator_avalon_universal_master_0_readdata;      // mem_if_ddr3_emif_0_avl_translator:uav_readdata -> center_mm_bridge_m0_translator:uav_readdata
	wire          center_mm_bridge_m0_translator_avalon_universal_master_0_debugaccess;   // center_mm_bridge_m0_translator:uav_debugaccess -> mem_if_ddr3_emif_0_avl_translator:uav_debugaccess
	wire   [15:0] center_mm_bridge_m0_translator_avalon_universal_master_0_byteenable;    // center_mm_bridge_m0_translator:uav_byteenable -> mem_if_ddr3_emif_0_avl_translator:uav_byteenable
	wire          center_mm_bridge_m0_translator_avalon_universal_master_0_readdatavalid; // mem_if_ddr3_emif_0_avl_translator:uav_readdatavalid -> center_mm_bridge_m0_translator:uav_readdatavalid

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (26),
		.AV_DATA_W                   (128),
		.AV_BURSTCOUNT_W             (6),
		.AV_BYTEENABLE_W             (16),
		.UAV_ADDRESS_W               (30),
		.UAV_BURSTCOUNT_W            (10),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (16),
		.AV_ADDRESS_SYMBOLS          (0),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (1),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) center_mm_bridge_m0_translator (
		.clk                      (mem_if_ddr3_emif_0_afi_clk_clk),                                         //                       clk.clk
		.reset                    (center_mm_bridge_reset_reset_bridge_in_reset_reset),                     //                     reset.reset
		.uav_address              (center_mm_bridge_m0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount           (center_mm_bridge_m0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read                 (center_mm_bridge_m0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write                (center_mm_bridge_m0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest          (center_mm_bridge_m0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid        (center_mm_bridge_m0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable           (center_mm_bridge_m0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata             (center_mm_bridge_m0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata            (center_mm_bridge_m0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock                 (center_mm_bridge_m0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess          (center_mm_bridge_m0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address               (center_mm_bridge_m0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest           (center_mm_bridge_m0_waitrequest),                                        //                          .waitrequest
		.av_burstcount            (center_mm_bridge_m0_burstcount),                                         //                          .burstcount
		.av_byteenable            (center_mm_bridge_m0_byteenable),                                         //                          .byteenable
		.av_read                  (center_mm_bridge_m0_read),                                               //                          .read
		.av_readdata              (center_mm_bridge_m0_readdata),                                           //                          .readdata
		.av_readdatavalid         (center_mm_bridge_m0_readdatavalid),                                      //                          .readdatavalid
		.av_write                 (center_mm_bridge_m0_write),                                              //                          .write
		.av_writedata             (center_mm_bridge_m0_writedata),                                          //                          .writedata
		.av_debugaccess           (center_mm_bridge_m0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer    (1'b0),                                                                   //               (terminated)
		.av_begintransfer         (1'b0),                                                                   //               (terminated)
		.av_chipselect            (1'b0),                                                                   //               (terminated)
		.av_lock                  (1'b0),                                                                   //               (terminated)
		.uav_clken                (),                                                                       //               (terminated)
		.av_clken                 (1'b1),                                                                   //               (terminated)
		.uav_response             (2'b00),                                                                  //               (terminated)
		.av_response              (),                                                                       //               (terminated)
		.uav_writeresponserequest (),                                                                       //               (terminated)
		.uav_writeresponsevalid   (1'b0),                                                                   //               (terminated)
		.av_writeresponserequest  (1'b0),                                                                   //               (terminated)
		.av_writeresponsevalid    ()                                                                        //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (26),
		.AV_DATA_W                      (128),
		.UAV_DATA_W                     (128),
		.AV_BURSTCOUNT_W                (6),
		.AV_BYTEENABLE_W                (16),
		.UAV_BYTEENABLE_W               (16),
		.UAV_ADDRESS_W                  (30),
		.UAV_BURSTCOUNT_W               (10),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (16),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) mem_if_ddr3_emif_0_avl_translator (
		.clk                      (mem_if_ddr3_emif_0_afi_clk_clk),                                         //                      clk.clk
		.reset                    (mem_if_ddr3_emif_0_avl_translator_reset_reset_bridge_in_reset_reset),    //                    reset.reset
		.uav_address              (center_mm_bridge_m0_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount           (center_mm_bridge_m0_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read                 (center_mm_bridge_m0_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write                (center_mm_bridge_m0_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest          (center_mm_bridge_m0_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid        (center_mm_bridge_m0_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable           (center_mm_bridge_m0_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata             (center_mm_bridge_m0_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata            (center_mm_bridge_m0_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock                 (center_mm_bridge_m0_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess          (center_mm_bridge_m0_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address               (mem_if_ddr3_emif_0_avl_address),                                         //      avalon_anti_slave_0.address
		.av_write                 (mem_if_ddr3_emif_0_avl_write),                                           //                         .write
		.av_read                  (mem_if_ddr3_emif_0_avl_read),                                            //                         .read
		.av_readdata              (mem_if_ddr3_emif_0_avl_readdata),                                        //                         .readdata
		.av_writedata             (mem_if_ddr3_emif_0_avl_writedata),                                       //                         .writedata
		.av_beginbursttransfer    (mem_if_ddr3_emif_0_avl_beginbursttransfer),                              //                         .beginbursttransfer
		.av_burstcount            (mem_if_ddr3_emif_0_avl_burstcount),                                      //                         .burstcount
		.av_byteenable            (mem_if_ddr3_emif_0_avl_byteenable),                                      //                         .byteenable
		.av_readdatavalid         (mem_if_ddr3_emif_0_avl_readdatavalid),                                   //                         .readdatavalid
		.av_waitrequest           (mem_if_ddr3_emif_0_avl_waitrequest),                                     //                         .waitrequest
		.av_begintransfer         (),                                                                       //              (terminated)
		.av_writebyteenable       (),                                                                       //              (terminated)
		.av_lock                  (),                                                                       //              (terminated)
		.av_chipselect            (),                                                                       //              (terminated)
		.av_clken                 (),                                                                       //              (terminated)
		.uav_clken                (1'b0),                                                                   //              (terminated)
		.av_debugaccess           (),                                                                       //              (terminated)
		.av_outputenable          (),                                                                       //              (terminated)
		.uav_response             (),                                                                       //              (terminated)
		.av_response              (2'b00),                                                                  //              (terminated)
		.uav_writeresponserequest (1'b0),                                                                   //              (terminated)
		.uav_writeresponsevalid   (),                                                                       //              (terminated)
		.av_writeresponserequest  (),                                                                       //              (terminated)
		.av_writeresponsevalid    (1'b0)                                                                    //              (terminated)
	);

endmodule
