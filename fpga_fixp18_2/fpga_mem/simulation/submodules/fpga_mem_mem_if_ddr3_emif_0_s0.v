// fpga_mem_mem_if_ddr3_emif_0_s0.v

// This file was auto-generated from qsys_sequencer_110_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 13.1 162 at 2015.07.03.12:56:09

`timescale 1 ps / 1 ps
module fpga_mem_mem_if_ddr3_emif_0_s0 (
		input  wire        avl_clk,                 //          avl_clk.clk
		input  wire        avl_reset_n,             //    sequencer_rst.reset
		output wire [15:0] avl_address,             //              avl.address
		output wire        avl_read,                //                 .read
		input  wire [31:0] avl_readdata,            //                 .readdata
		output wire        avl_write,               //                 .write
		output wire [31:0] avl_writedata,           //                 .writedata
		input  wire        avl_waitrequest,         //                 .waitrequest
		output wire [0:0]  scc_data,                //              scc.scc_data
		output wire [3:0]  scc_dqs_ena,             //                 .scc_dqs_ena
		output wire [3:0]  scc_dqs_io_ena,          //                 .scc_dqs_io_ena
		output wire [31:0] scc_dq_ena,              //                 .scc_dq_ena
		output wire [3:0]  scc_dm_ena,              //                 .scc_dm_ena
		input  wire [3:0]  capture_strobe_tracking, //                 .capture_strobe_tracking
		output wire [0:0]  scc_upd,                 //                 .scc_upd
		input  wire        afi_init_req,            // afi_init_cal_req.afi_init_req
		input  wire        afi_cal_req,             //                 .afi_cal_req
		input  wire        scc_clk,                 //          scc_clk.clk
		input  wire        reset_n_scc_clk,         //        scc_reset.reset_n
		output wire        seq_waitrequest,         //        seq_debug.waitrequest
		output wire [31:0] seq_readdata,            //                 .readdata
		output wire        seq_readdatavalid,       //                 .readdatavalid
		input  wire [0:0]  seq_burstcount,          //                 .burstcount
		input  wire [31:0] seq_writedata,           //                 .writedata
		input  wire [31:0] seq_address,             //                 .address
		input  wire        seq_write,               //                 .write
		input  wire        seq_read,                //                 .read
		input  wire [3:0]  seq_byteenable,          //                 .byteenable
		input  wire        seq_debugaccess          //                 .debugaccess
	);

	wire         sequencer_rst_reset_out_reset;                             // sequencer_rst:reset_out -> [cpu_inst:reset_n, hphy_bridge:reset_n, irq_mapper:reset, mm_interconnect_0:cpu_inst_reset_n_reset_bridge_in_reset_reset, seq_bridge:reset, sequencer_mem:reset1, sequencer_reg_file_inst:avl_reset_n, sequencer_scc_mgr_inst:avl_reset_n]
	wire         sequencer_rst_clken_out_clken;                             // sequencer_rst:clken_out -> sequencer_mem:clken1
	wire         mm_interconnect_0_sequencer_scc_mgr_inst_avl_waitrequest;  // sequencer_scc_mgr_inst:avl_waitrequest -> mm_interconnect_0:sequencer_scc_mgr_inst_avl_waitrequest
	wire  [31:0] mm_interconnect_0_sequencer_scc_mgr_inst_avl_writedata;    // mm_interconnect_0:sequencer_scc_mgr_inst_avl_writedata -> sequencer_scc_mgr_inst:avl_writedata
	wire  [12:0] mm_interconnect_0_sequencer_scc_mgr_inst_avl_address;      // mm_interconnect_0:sequencer_scc_mgr_inst_avl_address -> sequencer_scc_mgr_inst:avl_address
	wire         mm_interconnect_0_sequencer_scc_mgr_inst_avl_write;        // mm_interconnect_0:sequencer_scc_mgr_inst_avl_write -> sequencer_scc_mgr_inst:avl_write
	wire         mm_interconnect_0_sequencer_scc_mgr_inst_avl_read;         // mm_interconnect_0:sequencer_scc_mgr_inst_avl_read -> sequencer_scc_mgr_inst:avl_read
	wire  [31:0] mm_interconnect_0_sequencer_scc_mgr_inst_avl_readdata;     // sequencer_scc_mgr_inst:avl_readdata -> mm_interconnect_0:sequencer_scc_mgr_inst_avl_readdata
	wire         cpu_inst_data_master_waitrequest;                          // mm_interconnect_0:cpu_inst_data_master_waitrequest -> cpu_inst:d_waitrequest
	wire  [31:0] cpu_inst_data_master_writedata;                            // cpu_inst:d_writedata -> mm_interconnect_0:cpu_inst_data_master_writedata
	wire  [19:0] cpu_inst_data_master_address;                              // cpu_inst:d_address -> mm_interconnect_0:cpu_inst_data_master_address
	wire         cpu_inst_data_master_write;                                // cpu_inst:d_write -> mm_interconnect_0:cpu_inst_data_master_write
	wire         cpu_inst_data_master_read;                                 // cpu_inst:d_read -> mm_interconnect_0:cpu_inst_data_master_read
	wire  [31:0] cpu_inst_data_master_readdata;                             // mm_interconnect_0:cpu_inst_data_master_readdata -> cpu_inst:d_readdata
	wire   [3:0] cpu_inst_data_master_byteenable;                           // cpu_inst:d_byteenable -> mm_interconnect_0:cpu_inst_data_master_byteenable
	wire         mm_interconnect_0_hphy_bridge_s0_waitrequest;              // hphy_bridge:s0_waitrequest -> mm_interconnect_0:hphy_bridge_s0_waitrequest
	wire  [31:0] mm_interconnect_0_hphy_bridge_s0_writedata;                // mm_interconnect_0:hphy_bridge_s0_writedata -> hphy_bridge:s0_writedata
	wire  [15:0] mm_interconnect_0_hphy_bridge_s0_address;                  // mm_interconnect_0:hphy_bridge_s0_address -> hphy_bridge:s0_address
	wire         mm_interconnect_0_hphy_bridge_s0_write;                    // mm_interconnect_0:hphy_bridge_s0_write -> hphy_bridge:s0_write
	wire         mm_interconnect_0_hphy_bridge_s0_read;                     // mm_interconnect_0:hphy_bridge_s0_read -> hphy_bridge:s0_read
	wire  [31:0] mm_interconnect_0_hphy_bridge_s0_readdata;                 // hphy_bridge:s0_readdata -> mm_interconnect_0:hphy_bridge_s0_readdata
	wire         cpu_inst_instruction_master_waitrequest;                   // mm_interconnect_0:cpu_inst_instruction_master_waitrequest -> cpu_inst:i_waitrequest
	wire  [16:0] cpu_inst_instruction_master_address;                       // cpu_inst:i_address -> mm_interconnect_0:cpu_inst_instruction_master_address
	wire         cpu_inst_instruction_master_read;                          // cpu_inst:i_read -> mm_interconnect_0:cpu_inst_instruction_master_read
	wire  [31:0] cpu_inst_instruction_master_readdata;                      // mm_interconnect_0:cpu_inst_instruction_master_readdata -> cpu_inst:i_readdata
	wire   [0:0] seq_bridge_m0_burstcount;                                  // seq_bridge:m0_burstcount -> mm_interconnect_0:seq_bridge_m0_burstcount
	wire         seq_bridge_m0_waitrequest;                                 // mm_interconnect_0:seq_bridge_m0_waitrequest -> seq_bridge:m0_waitrequest
	wire  [31:0] seq_bridge_m0_address;                                     // seq_bridge:m0_address -> mm_interconnect_0:seq_bridge_m0_address
	wire  [31:0] seq_bridge_m0_writedata;                                   // seq_bridge:m0_writedata -> mm_interconnect_0:seq_bridge_m0_writedata
	wire         seq_bridge_m0_write;                                       // seq_bridge:m0_write -> mm_interconnect_0:seq_bridge_m0_write
	wire         seq_bridge_m0_read;                                        // seq_bridge:m0_read -> mm_interconnect_0:seq_bridge_m0_read
	wire  [31:0] seq_bridge_m0_readdata;                                    // mm_interconnect_0:seq_bridge_m0_readdata -> seq_bridge:m0_readdata
	wire         seq_bridge_m0_debugaccess;                                 // seq_bridge:m0_debugaccess -> mm_interconnect_0:seq_bridge_m0_debugaccess
	wire   [3:0] seq_bridge_m0_byteenable;                                  // seq_bridge:m0_byteenable -> mm_interconnect_0:seq_bridge_m0_byteenable
	wire         seq_bridge_m0_readdatavalid;                               // mm_interconnect_0:seq_bridge_m0_readdatavalid -> seq_bridge:m0_readdatavalid
	wire  [31:0] mm_interconnect_0_sequencer_mem_s1_writedata;              // mm_interconnect_0:sequencer_mem_s1_writedata -> sequencer_mem:s1_writedata
	wire  [11:0] mm_interconnect_0_sequencer_mem_s1_address;                // mm_interconnect_0:sequencer_mem_s1_address -> sequencer_mem:s1_address
	wire         mm_interconnect_0_sequencer_mem_s1_chipselect;             // mm_interconnect_0:sequencer_mem_s1_chipselect -> sequencer_mem:s1_chipselect
	wire         mm_interconnect_0_sequencer_mem_s1_write;                  // mm_interconnect_0:sequencer_mem_s1_write -> sequencer_mem:s1_write
	wire  [31:0] mm_interconnect_0_sequencer_mem_s1_readdata;               // sequencer_mem:s1_readdata -> mm_interconnect_0:sequencer_mem_s1_readdata
	wire   [3:0] mm_interconnect_0_sequencer_mem_s1_byteenable;             // mm_interconnect_0:sequencer_mem_s1_byteenable -> sequencer_mem:s1_be
	wire         mm_interconnect_0_sequencer_reg_file_inst_avl_waitrequest; // sequencer_reg_file_inst:avl_waitrequest -> mm_interconnect_0:sequencer_reg_file_inst_avl_waitrequest
	wire  [31:0] mm_interconnect_0_sequencer_reg_file_inst_avl_writedata;   // mm_interconnect_0:sequencer_reg_file_inst_avl_writedata -> sequencer_reg_file_inst:avl_writedata
	wire   [3:0] mm_interconnect_0_sequencer_reg_file_inst_avl_address;     // mm_interconnect_0:sequencer_reg_file_inst_avl_address -> sequencer_reg_file_inst:avl_address
	wire         mm_interconnect_0_sequencer_reg_file_inst_avl_write;       // mm_interconnect_0:sequencer_reg_file_inst_avl_write -> sequencer_reg_file_inst:avl_write
	wire         mm_interconnect_0_sequencer_reg_file_inst_avl_read;        // mm_interconnect_0:sequencer_reg_file_inst_avl_read -> sequencer_reg_file_inst:avl_read
	wire  [31:0] mm_interconnect_0_sequencer_reg_file_inst_avl_readdata;    // sequencer_reg_file_inst:avl_readdata -> mm_interconnect_0:sequencer_reg_file_inst_avl_readdata
	wire   [3:0] mm_interconnect_0_sequencer_reg_file_inst_avl_byteenable;  // mm_interconnect_0:sequencer_reg_file_inst_avl_byteenable -> sequencer_reg_file_inst:avl_be
	wire  [31:0] cpu_inst_d_irq_irq;                                        // irq_mapper:sender_irq -> cpu_inst:d_irq

	altera_mem_if_sequencer_rst #(
		.DEPTH            (10),
		.CLKEN_LAGS_RESET (0)
	) sequencer_rst (
		.clk       (avl_clk),                       //       clk.clk
		.rst       (avl_reset_n),                   //       rst.reset
		.reset_out (sequencer_rst_reset_out_reset), // reset_out.reset
		.clken_out (sequencer_rst_clken_out_clken)  // clken_out.clken
	);

	altera_mem_if_sequencer_cpu_cv_sim_cpu_inst #(
		.DEVICE_FAMILY ("CYCLONEV")
	) cpu_inst (
		.clk           (avl_clk),                                 //                       clk.clk
		.reset_n       (~sequencer_rst_reset_out_reset),          //                   reset_n.reset_n
		.d_address     (cpu_inst_data_master_address),            //               data_master.address
		.d_byteenable  (cpu_inst_data_master_byteenable),         //                          .byteenable
		.d_read        (cpu_inst_data_master_read),               //                          .read
		.d_readdata    (cpu_inst_data_master_readdata),           //                          .readdata
		.d_waitrequest (cpu_inst_data_master_waitrequest),        //                          .waitrequest
		.d_write       (cpu_inst_data_master_write),              //                          .write
		.d_writedata   (cpu_inst_data_master_writedata),          //                          .writedata
		.i_address     (cpu_inst_instruction_master_address),     //        instruction_master.address
		.i_read        (cpu_inst_instruction_master_read),        //                          .read
		.i_readdata    (cpu_inst_instruction_master_readdata),    //                          .readdata
		.i_waitrequest (cpu_inst_instruction_master_waitrequest), //                          .waitrequest
		.d_irq         (cpu_inst_d_irq_irq),                      //                     d_irq.irq
		.no_ci_readra  ()                                         // custom_instruction_master.readra
	);

	sequencer_scc_mgr #(
		.AVL_DATA_WIDTH         (32),
		.AVL_ADDR_WIDTH         (13),
		.MEM_IF_READ_DQS_WIDTH  (4),
		.MEM_IF_WRITE_DQS_WIDTH (4),
		.MEM_IF_DQ_WIDTH        (32),
		.MEM_IF_DM_WIDTH        (4),
		.MEM_NUMBER_OF_RANKS    (1),
		.DLL_DELAY_CHAIN_LENGTH (8),
		.FAMILY                 ("CYCLONEV"),
		.USE_2X_DLL             ("true"),
		.USE_SHADOW_REGS        (0),
		.USE_DQS_TRACKING       (0),
		.DUAL_WRITE_CLOCK       (0),
		.SCC_DATA_WIDTH         (1),
		.TRK_PARALLEL_SCC_LOAD  (0)
	) sequencer_scc_mgr_inst (
		.avl_clk                      (avl_clk),                                                  //          avl_clk.clk
		.avl_reset_n                  (~sequencer_rst_reset_out_reset),                           //        avl_reset.reset_n
		.avl_address                  (mm_interconnect_0_sequencer_scc_mgr_inst_avl_address),     //              avl.address
		.avl_write                    (mm_interconnect_0_sequencer_scc_mgr_inst_avl_write),       //                 .write
		.avl_writedata                (mm_interconnect_0_sequencer_scc_mgr_inst_avl_writedata),   //                 .writedata
		.avl_read                     (mm_interconnect_0_sequencer_scc_mgr_inst_avl_read),        //                 .read
		.avl_readdata                 (mm_interconnect_0_sequencer_scc_mgr_inst_avl_readdata),    //                 .readdata
		.avl_waitrequest              (mm_interconnect_0_sequencer_scc_mgr_inst_avl_waitrequest), //                 .waitrequest
		.scc_clk                      (scc_clk),                                                  //          scc_clk.clk
		.scc_reset_n                  (reset_n_scc_clk),                                          //        scc_reset.reset_n
		.scc_data                     (scc_data),                                                 //              scc.scc_data
		.scc_dqs_ena                  (scc_dqs_ena),                                              //                 .scc_dqs_ena
		.scc_dqs_io_ena               (scc_dqs_io_ena),                                           //                 .scc_dqs_io_ena
		.scc_dq_ena                   (scc_dq_ena),                                               //                 .scc_dq_ena
		.scc_dm_ena                   (scc_dm_ena),                                               //                 .scc_dm_ena
		.capture_strobe_tracking      (capture_strobe_tracking),                                  //                 .capture_strobe_tracking
		.scc_upd                      (scc_upd),                                                  //                 .scc_upd
		.afi_init_req                 (afi_init_req),                                             // afi_init_cal_req.afi_init_req
		.afi_cal_req                  (afi_cal_req),                                              //                 .afi_cal_req
		.scc_sr_dqsenable_delayctrl   (),                                                         //      (terminated)
		.scc_sr_dqsdisablen_delayctrl (),                                                         //      (terminated)
		.scc_sr_multirank_delayctrl   ()                                                          //      (terminated)
	);

	sequencer_reg_file #(
		.AVL_DATA_WIDTH    (32),
		.AVL_ADDR_WIDTH    (4),
		.AVL_NUM_SYMBOLS   (4),
		.AVL_SYMBOL_WIDTH  (8),
		.REGISTER_RDATA    (0),
		.NUM_REGFILE_WORDS (16)
	) sequencer_reg_file_inst (
		.avl_clk         (avl_clk),                                                   //   avl_clk.clk
		.avl_reset_n     (~sequencer_rst_reset_out_reset),                            // avl_reset.reset_n
		.avl_address     (mm_interconnect_0_sequencer_reg_file_inst_avl_address),     //       avl.address
		.avl_write       (mm_interconnect_0_sequencer_reg_file_inst_avl_write),       //          .write
		.avl_writedata   (mm_interconnect_0_sequencer_reg_file_inst_avl_writedata),   //          .writedata
		.avl_read        (mm_interconnect_0_sequencer_reg_file_inst_avl_read),        //          .read
		.avl_readdata    (mm_interconnect_0_sequencer_reg_file_inst_avl_readdata),    //          .readdata
		.avl_waitrequest (mm_interconnect_0_sequencer_reg_file_inst_avl_waitrequest), //          .waitrequest
		.avl_be          (mm_interconnect_0_sequencer_reg_file_inst_avl_byteenable)   //          .byteenable
	);

	altera_mem_if_simple_avalon_mm_bridge #(
		.DATA_WIDTH                (32),
		.SLAVE_DATA_WIDTH          (32),
		.MASTER_DATA_WIDTH         (32),
		.SYMBOL_WIDTH              (8),
		.ADDRESS_WIDTH             (16),
		.MASTER_ADDRESS_WIDTH      (10),
		.SLAVE_ADDRESS_WIDTH       (10),
		.BURSTCOUNT_WIDTH          (3),
		.WORKAROUND_HARD_PHY_ISSUE (1)
	) hphy_bridge (
		.clk                   (avl_clk),                                      //   clk.clk
		.reset_n               (~sequencer_rst_reset_out_reset),               // reset.reset_n
		.s0_address            (mm_interconnect_0_hphy_bridge_s0_address),     //    s0.address
		.s0_read               (mm_interconnect_0_hphy_bridge_s0_read),        //      .read
		.s0_readdata           (mm_interconnect_0_hphy_bridge_s0_readdata),    //      .readdata
		.s0_write              (mm_interconnect_0_hphy_bridge_s0_write),       //      .write
		.s0_writedata          (mm_interconnect_0_hphy_bridge_s0_writedata),   //      .writedata
		.s0_waitrequest        (mm_interconnect_0_hphy_bridge_s0_waitrequest), //      .waitrequest
		.m0_address            (avl_address),                                  //    m0.address
		.m0_read               (avl_read),                                     //      .read
		.m0_readdata           (avl_readdata),                                 //      .readdata
		.m0_write              (avl_write),                                    //      .write
		.m0_writedata          (avl_writedata),                                //      .writedata
		.m0_waitrequest        (avl_waitrequest),                              //      .waitrequest
		.s0_waitrequest_n      (),                                             // (terminated)
		.s0_beginbursttransfer (1'b0),                                         // (terminated)
		.s0_burstcount         (3'b000),                                       // (terminated)
		.s0_byteenable         (4'b1111),                                      // (terminated)
		.s0_readdatavalid      (),                                             // (terminated)
		.m0_beginbursttransfer (),                                             // (terminated)
		.m0_burstcount         (),                                             // (terminated)
		.m0_byteenable         (),                                             // (terminated)
		.m0_readdatavalid      (1'b0)                                          // (terminated)
	);

	altera_mem_if_sequencer_mem_no_ifdef_params #(
		.AVL_DATA_WIDTH   (32),
		.AVL_ADDR_WIDTH   (12),
		.AVL_NUM_SYMBOLS  (4),
		.AVL_SYMBOL_WIDTH (8),
		.MEM_SIZE         (11264),
		.INIT_FILE        ("fpga_mem_mem_if_ddr3_emif_0_s0_sequencer_mem.hex"),
		.RAM_BLOCK_TYPE   ("AUTO")
	) sequencer_mem (
		.clk1          (avl_clk),                                       //   clk1.clk
		.reset1        (sequencer_rst_reset_out_reset),                 // reset1.reset
		.clken1        (sequencer_rst_clken_out_clken),                 // clken1.clken
		.s1_address    (mm_interconnect_0_sequencer_mem_s1_address),    //     s1.address
		.s1_write      (mm_interconnect_0_sequencer_mem_s1_write),      //       .write
		.s1_writedata  (mm_interconnect_0_sequencer_mem_s1_writedata),  //       .writedata
		.s1_readdata   (mm_interconnect_0_sequencer_mem_s1_readdata),   //       .readdata
		.s1_be         (mm_interconnect_0_sequencer_mem_s1_byteenable), //       .byteenable
		.s1_chipselect (mm_interconnect_0_sequencer_mem_s1_chipselect)  //       .chipselect
	);

	altera_avalon_mm_bridge #(
		.DATA_WIDTH        (32),
		.SYMBOL_WIDTH      (8),
		.ADDRESS_WIDTH     (32),
		.BURSTCOUNT_WIDTH  (1),
		.PIPELINE_COMMAND  (1),
		.PIPELINE_RESPONSE (1)
	) seq_bridge (
		.clk              (avl_clk),                       //   clk.clk
		.reset            (sequencer_rst_reset_out_reset), // reset.reset
		.s0_waitrequest   (seq_waitrequest),               //    s0.waitrequest
		.s0_readdata      (seq_readdata),                  //      .readdata
		.s0_readdatavalid (seq_readdatavalid),             //      .readdatavalid
		.s0_burstcount    (seq_burstcount),                //      .burstcount
		.s0_writedata     (seq_writedata),                 //      .writedata
		.s0_address       (seq_address),                   //      .address
		.s0_write         (seq_write),                     //      .write
		.s0_read          (seq_read),                      //      .read
		.s0_byteenable    (seq_byteenable),                //      .byteenable
		.s0_debugaccess   (seq_debugaccess),               //      .debugaccess
		.m0_waitrequest   (seq_bridge_m0_waitrequest),     //    m0.waitrequest
		.m0_readdata      (seq_bridge_m0_readdata),        //      .readdata
		.m0_readdatavalid (seq_bridge_m0_readdatavalid),   //      .readdatavalid
		.m0_burstcount    (seq_bridge_m0_burstcount),      //      .burstcount
		.m0_writedata     (seq_bridge_m0_writedata),       //      .writedata
		.m0_address       (seq_bridge_m0_address),         //      .address
		.m0_write         (seq_bridge_m0_write),           //      .write
		.m0_read          (seq_bridge_m0_read),            //      .read
		.m0_byteenable    (seq_bridge_m0_byteenable),      //      .byteenable
		.m0_debugaccess   (seq_bridge_m0_debugaccess)      //      .debugaccess
	);

	fpga_mem_mem_if_ddr3_emif_0_s0_mm_interconnect_0 mm_interconnect_0 (
		.avl_clk_out_clk_clk                          (avl_clk),                                                   //                        avl_clk_out_clk.clk
		.cpu_inst_reset_n_reset_bridge_in_reset_reset (sequencer_rst_reset_out_reset),                             // cpu_inst_reset_n_reset_bridge_in_reset.reset
		.cpu_inst_data_master_address                 (cpu_inst_data_master_address),                              //                   cpu_inst_data_master.address
		.cpu_inst_data_master_waitrequest             (cpu_inst_data_master_waitrequest),                          //                                       .waitrequest
		.cpu_inst_data_master_byteenable              (cpu_inst_data_master_byteenable),                           //                                       .byteenable
		.cpu_inst_data_master_read                    (cpu_inst_data_master_read),                                 //                                       .read
		.cpu_inst_data_master_readdata                (cpu_inst_data_master_readdata),                             //                                       .readdata
		.cpu_inst_data_master_write                   (cpu_inst_data_master_write),                                //                                       .write
		.cpu_inst_data_master_writedata               (cpu_inst_data_master_writedata),                            //                                       .writedata
		.cpu_inst_instruction_master_address          (cpu_inst_instruction_master_address),                       //            cpu_inst_instruction_master.address
		.cpu_inst_instruction_master_waitrequest      (cpu_inst_instruction_master_waitrequest),                   //                                       .waitrequest
		.cpu_inst_instruction_master_read             (cpu_inst_instruction_master_read),                          //                                       .read
		.cpu_inst_instruction_master_readdata         (cpu_inst_instruction_master_readdata),                      //                                       .readdata
		.seq_bridge_m0_address                        (seq_bridge_m0_address),                                     //                          seq_bridge_m0.address
		.seq_bridge_m0_waitrequest                    (seq_bridge_m0_waitrequest),                                 //                                       .waitrequest
		.seq_bridge_m0_burstcount                     (seq_bridge_m0_burstcount),                                  //                                       .burstcount
		.seq_bridge_m0_byteenable                     (seq_bridge_m0_byteenable),                                  //                                       .byteenable
		.seq_bridge_m0_read                           (seq_bridge_m0_read),                                        //                                       .read
		.seq_bridge_m0_readdata                       (seq_bridge_m0_readdata),                                    //                                       .readdata
		.seq_bridge_m0_readdatavalid                  (seq_bridge_m0_readdatavalid),                               //                                       .readdatavalid
		.seq_bridge_m0_write                          (seq_bridge_m0_write),                                       //                                       .write
		.seq_bridge_m0_writedata                      (seq_bridge_m0_writedata),                                   //                                       .writedata
		.seq_bridge_m0_debugaccess                    (seq_bridge_m0_debugaccess),                                 //                                       .debugaccess
		.hphy_bridge_s0_address                       (mm_interconnect_0_hphy_bridge_s0_address),                  //                         hphy_bridge_s0.address
		.hphy_bridge_s0_write                         (mm_interconnect_0_hphy_bridge_s0_write),                    //                                       .write
		.hphy_bridge_s0_read                          (mm_interconnect_0_hphy_bridge_s0_read),                     //                                       .read
		.hphy_bridge_s0_readdata                      (mm_interconnect_0_hphy_bridge_s0_readdata),                 //                                       .readdata
		.hphy_bridge_s0_writedata                     (mm_interconnect_0_hphy_bridge_s0_writedata),                //                                       .writedata
		.hphy_bridge_s0_waitrequest                   (mm_interconnect_0_hphy_bridge_s0_waitrequest),              //                                       .waitrequest
		.sequencer_mem_s1_address                     (mm_interconnect_0_sequencer_mem_s1_address),                //                       sequencer_mem_s1.address
		.sequencer_mem_s1_write                       (mm_interconnect_0_sequencer_mem_s1_write),                  //                                       .write
		.sequencer_mem_s1_readdata                    (mm_interconnect_0_sequencer_mem_s1_readdata),               //                                       .readdata
		.sequencer_mem_s1_writedata                   (mm_interconnect_0_sequencer_mem_s1_writedata),              //                                       .writedata
		.sequencer_mem_s1_byteenable                  (mm_interconnect_0_sequencer_mem_s1_byteenable),             //                                       .byteenable
		.sequencer_mem_s1_chipselect                  (mm_interconnect_0_sequencer_mem_s1_chipselect),             //                                       .chipselect
		.sequencer_reg_file_inst_avl_address          (mm_interconnect_0_sequencer_reg_file_inst_avl_address),     //            sequencer_reg_file_inst_avl.address
		.sequencer_reg_file_inst_avl_write            (mm_interconnect_0_sequencer_reg_file_inst_avl_write),       //                                       .write
		.sequencer_reg_file_inst_avl_read             (mm_interconnect_0_sequencer_reg_file_inst_avl_read),        //                                       .read
		.sequencer_reg_file_inst_avl_readdata         (mm_interconnect_0_sequencer_reg_file_inst_avl_readdata),    //                                       .readdata
		.sequencer_reg_file_inst_avl_writedata        (mm_interconnect_0_sequencer_reg_file_inst_avl_writedata),   //                                       .writedata
		.sequencer_reg_file_inst_avl_byteenable       (mm_interconnect_0_sequencer_reg_file_inst_avl_byteenable),  //                                       .byteenable
		.sequencer_reg_file_inst_avl_waitrequest      (mm_interconnect_0_sequencer_reg_file_inst_avl_waitrequest), //                                       .waitrequest
		.sequencer_scc_mgr_inst_avl_address           (mm_interconnect_0_sequencer_scc_mgr_inst_avl_address),      //             sequencer_scc_mgr_inst_avl.address
		.sequencer_scc_mgr_inst_avl_write             (mm_interconnect_0_sequencer_scc_mgr_inst_avl_write),        //                                       .write
		.sequencer_scc_mgr_inst_avl_read              (mm_interconnect_0_sequencer_scc_mgr_inst_avl_read),         //                                       .read
		.sequencer_scc_mgr_inst_avl_readdata          (mm_interconnect_0_sequencer_scc_mgr_inst_avl_readdata),     //                                       .readdata
		.sequencer_scc_mgr_inst_avl_writedata         (mm_interconnect_0_sequencer_scc_mgr_inst_avl_writedata),    //                                       .writedata
		.sequencer_scc_mgr_inst_avl_waitrequest       (mm_interconnect_0_sequencer_scc_mgr_inst_avl_waitrequest)   //                                       .waitrequest
	);

	fpga_mem_mem_if_ddr3_emif_0_s0_irq_mapper irq_mapper (
		.clk        (avl_clk),                       //       clk.clk
		.reset      (sequencer_rst_reset_out_reset), // clk_reset.reset
		.sender_irq (cpu_inst_d_irq_irq)             //    sender.irq
	);

endmodule
