//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module top
(/*AUTOARG*/
// Outputs
AUD_DACDAT, AUD_I2C_SCLK, AUD_MUTE, AUD_XCK, DDR3_A, DDR3_BA,
DDR3_CAS_n, DDR3_CKE, DDR3_CK_n, DDR3_CK_p, DDR3_CS_n, DDR3_DM,
DDR3_ODT, DDR3_RAS_n, DDR3_RESET_n, DDR3_WE_n, FAN_CTRL,
HPS_DDR3_ADDR, HPS_DDR3_BA, HPS_DDR3_CAS_N, HPS_DDR3_CKE,
HPS_DDR3_CK_N, HPS_DDR3_CK_P, HPS_DDR3_CS_N, HPS_DDR3_DM,
HPS_DDR3_ODT, HPS_DDR3_RAS_N, HPS_DDR3_RESET_N, HPS_DDR3_WE_N,
HPS_ENET_GTX_CLK, HPS_ENET_MDC, HPS_ENET_TX_DATA, HPS_ENET_TX_EN,
HPS_FLASH_DCLK, HPS_FLASH_NCSO, HPS_LCM_SPIM_CLK, HPS_LCM_SPIM_MOSI,
HPS_LCM_SPIM_SS, HPS_SD_CLK, HPS_SPIM_CLK, HPS_SPIM_MOSI, HPS_UART_TX,
HPS_USB_STP, LED, PCIE_WAKE_n, TEMP_CS_n, TEMP_DIN, TEMP_SCLK, VGA_B,
VGA_BLANK_n, VGA_CLK, VGA_G, VGA_HS, VGA_R, VGA_SYNC_n, VGA_VS,
// Inouts
AUD_ADCLRCK, AUD_BCLK, AUD_DACLRCK, AUD_I2C_SDAT, DDR3_DQ, DDR3_DQS_n,
DDR3_DQS_p, HPS_CONV_USB_n, HPS_DDR3_DQ, HPS_DDR3_DQS_N,
HPS_DDR3_DQS_P, HPS_ENET_INT_n, HPS_ENET_MDIO, HPS_FLASH_DATA,
HPS_GSENSOR_INT, HPS_I2C_CLK, HPS_I2C_SDA, HPS_LCM_BK, HPS_LCM_D_C,
HPS_LCM_RST_N, HPS_LED, HPS_LTC_GPIO, HPS_SD_CMD, HPS_SD_DATA,
HPS_SPIM_SS, HPS_USB_DATA, SI5338_SCL, SI5338_SDA,
// Inputs
AUD_ADCDAT, DDR3_RZQ, HPS_DDR3_RZQ, HPS_ENET_RX_CLK, HPS_ENET_RX_DATA,
HPS_ENET_RX_DV, HPS_LCM_SPIM_MISO, HPS_SPIM_MISO, HPS_UART_RX,
HPS_USB_CLKOUT, HPS_USB_DIR, HPS_USB_NXT, IRDA_RXD, KEY, OSC_50_B3B,
OSC_50_B4A, OSC_50_B5B, OSC_50_B8A, PCIE_PERST_n, RESET_n, SW,
TEMP_DOUT
);

///////// AUD /////////
input wire         AUD_ADCDAT;
inout wire         AUD_ADCLRCK;
inout wire         AUD_BCLK;
output wire        AUD_DACDAT;
inout wire         AUD_DACLRCK;
output wire        AUD_I2C_SCLK;
inout wire         AUD_I2C_SDAT;
output wire        AUD_MUTE;
output wire        AUD_XCK;

///////// DDR3 /////////
output wire [14:0] DDR3_A;
output wire [2:0]  DDR3_BA;
output wire        DDR3_CAS_n;
output wire        DDR3_CKE;
output wire        DDR3_CK_n;
output wire        DDR3_CK_p;
output wire        DDR3_CS_n;
output wire [3:0]  DDR3_DM;
inout wire [31:0]  DDR3_DQ;
inout wire [3:0]   DDR3_DQS_n;
inout wire [3:0]   DDR3_DQS_p;
output wire        DDR3_ODT;
output wire        DDR3_RAS_n;
output wire        DDR3_RESET_n;
input wire         DDR3_RZQ;
output wire        DDR3_WE_n;

///////// FAN /////////
output wire        FAN_CTRL;

///////// HPS /////////
inout wire         HPS_CONV_USB_n;
//DDR3 
output wire [14:0] HPS_DDR3_ADDR;
output wire [2:0]  HPS_DDR3_BA;
output wire        HPS_DDR3_CAS_N;
output wire        HPS_DDR3_CKE;
output wire        HPS_DDR3_CK_N;
output wire        HPS_DDR3_CK_P;
output wire        HPS_DDR3_CS_N;
output wire [3:0]  HPS_DDR3_DM;
inout wire [31:0]  HPS_DDR3_DQ;
inout wire [3:0]   HPS_DDR3_DQS_N;
inout wire [3:0]   HPS_DDR3_DQS_P;
output wire        HPS_DDR3_ODT;
output wire        HPS_DDR3_RAS_N;
output wire        HPS_DDR3_RESET_N;
input wire         HPS_DDR3_RZQ;
output wire        HPS_DDR3_WE_N;

output wire        HPS_ENET_GTX_CLK;
inout wire         HPS_ENET_INT_n;
output wire        HPS_ENET_MDC;
inout wire         HPS_ENET_MDIO;
input wire         HPS_ENET_RX_CLK;
input wire [3:0]   HPS_ENET_RX_DATA;
input wire         HPS_ENET_RX_DV;
output wire [3:0]  HPS_ENET_TX_DATA;
output wire        HPS_ENET_TX_EN;

inout wire [3:0]   HPS_FLASH_DATA;
output wire        HPS_FLASH_DCLK;
output wire        HPS_FLASH_NCSO;
inout wire         HPS_GSENSOR_INT;
inout wire         HPS_I2C_CLK;
inout wire         HPS_I2C_SDA;
inout wire         HPS_LCM_BK;
inout wire         HPS_LCM_D_C;
inout wire         HPS_LCM_RST_N;
output wire        HPS_LCM_SPIM_CLK;
output wire        HPS_LCM_SPIM_MOSI;
input wire         HPS_LCM_SPIM_MISO;
output wire        HPS_LCM_SPIM_SS;
inout wire [3:0]   HPS_LED;
inout wire         HPS_LTC_GPIO;
output wire        HPS_SD_CLK;
inout wire         HPS_SD_CMD;
inout wire [3:0]   HPS_SD_DATA;
output wire        HPS_SPIM_CLK;
input wire         HPS_SPIM_MISO;
output wire        HPS_SPIM_MOSI;
inout wire         HPS_SPIM_SS;
input wire         HPS_UART_RX;
output wire        HPS_UART_TX;
input wire         HPS_USB_CLKOUT;
inout wire [7:0]   HPS_USB_DATA;
input wire         HPS_USB_DIR;
input wire         HPS_USB_NXT;
output wire        HPS_USB_STP;

///////// IRDA /////////
input wire         IRDA_RXD;

///////// KEY /////////
input wire [3:0]   KEY;

///////// LED /////////
output wire [3:0]  LED;

///////// OSC /////////
input wire         OSC_50_B3B;
input wire         OSC_50_B4A;
input wire         OSC_50_B5B;
input wire         OSC_50_B8A;

///////// PCIE /////////
input wire         PCIE_PERST_n;
output wire        PCIE_WAKE_n;

///////// RESET /////////
input wire         RESET_n;

///////// SI5338 /////////
inout wire         SI5338_SCL;
inout wire         SI5338_SDA;

///////// SW /////////
input wire [3:0]   SW;

///////// TEMP /////////
output wire        TEMP_CS_n;
output wire        TEMP_DIN;
input wire         TEMP_DOUT;
output wire        TEMP_SCLK;

///////// VGA /////////
output wire [7:0]  VGA_B;
output wire        VGA_BLANK_n;
output wire        VGA_CLK;
output wire [7:0]  VGA_G;
output wire        VGA_HS;
output wire [7:0]  VGA_R;
output wire        VGA_SYNC_n;
output wire        VGA_VS;
        


// internal wires and registers declaration
wire [1:0]         fpga_debounced_buttons;
wire [3:0]         fpga_led_internal;
wire               hps_fpga_reset_n;
wire               fpga_reset_n;
wire [2:0]         hps_reset_req;
wire               hps_cold_reset;
wire               hps_warm_reset;
wire               hps_debug_reset;
wire [27:0]        stm_hw_events;

wire               zcnn_busy;

// connection of internal logics
assign fpga_led_internal = 0;
assign stm_hw_events    = {{12{1'b0}},SW, fpga_led_internal, fpga_debounced_buttons};

wire         reg_avl_waitrequest;
wire [31:0]  reg_avl_readdata;
wire         reg_avl_readdatavalid;
wire [0:0]   reg_avl_burstcount;
wire [31:0]  reg_avl_writedata;
wire [9:0]   reg_avl_address;
wire         reg_avl_write;
wire         reg_avl_read;
wire [3:0]   reg_avl_byteenable;
wire         reg_avl_debugaccess;

wire         mem_clk;
wire         mrx_read;
wire [25:0]  mrx_address;
wire [7:0]   mrx_burstcount; //16burst fix
wire         mrx_waitrequest;
wire         mrx_readdatavalid;
wire [127:0] mrx_readdata;
wire         mr0_read;
wire [25:0]  mr0_address;
wire [7:0]   mr0_burstcount; //16burst fix
wire         mr0_waitrequest;
wire         mr0_readdatavalid;
wire [127:0] mr0_readdata;
wire         mr1_read;
wire [25:0]  mr1_address;
wire [7:0]   mr1_burstcount; //16burst fix
wire         mr1_waitrequest;
wire         mr1_readdatavalid;
wire [127:0] mr1_readdata;
wire         mr2_read;
wire [25:0]  mr2_address;
wire [7:0]   mr2_burstcount; //16burst fix
wire         mr2_waitrequest;
wire         mr2_readdatavalid;
wire [127:0] mr2_readdata;
wire         mr3_read;
wire [25:0]  mr3_address;
wire [7:0]   mr3_burstcount; //16burst fix
wire         mr3_waitrequest;
wire         mr3_readdatavalid;
wire [127:0] mr3_readdata;
wire         mwx_write;
wire [25:0]  mwx_address;
wire [7:0]   mwx_burstcount; //16burst fix
wire         mwx_waitrequest;
wire [127:0] mwx_writedata;
wire         mw0_write;
wire [25:0]  mw0_address;
wire [7:0]   mw0_burstcount; //16burst fix
wire         mw0_waitrequest;
wire [127:0] mw0_writedata;
wire         mw1_write;
wire [25:0]  mw1_address;
wire [7:0]   mw1_burstcount; //16burst fix
wire         mw1_waitrequest;
wire [127:0] mw1_writedata;
wire         mw2_write;
wire [25:0]  mw2_address;
wire [7:0]   mw2_burstcount; //16burst fix
wire         mw2_waitrequest;
wire [127:0] mw2_writedata;
wire         mw3_write;
wire [25:0]  mw3_address;
wire [7:0]   mw3_burstcount; //16burst fix
wire         mw3_waitrequest;
wire [127:0] mw3_writedata;
wire         h2f_0_waitrequest ;
wire [127:0] h2f_0_readdata ;
wire         h2f_0_readdatavalid ;
wire [5:0]   h2f_0_burstcount ;
wire [127:0] h2f_0_writedata ;
wire [25:0]  h2f_0_address ;
wire         h2f_0_write ;
wire         h2f_0_read ;
wire [15:0]  h2f_0_byteenable ;
wire         h2f_0_debugaccess ;

wire         ddr3_init_done;

soc_system u0 (
               //HPS ddr3
               .memory_mem_a                          ( HPS_DDR3_ADDR),
               .memory_mem_ba                         ( HPS_DDR3_BA),
               .memory_mem_ck                         ( HPS_DDR3_CK_P),
               .memory_mem_ck_n                       ( HPS_DDR3_CK_N),
               .memory_mem_cke                        ( HPS_DDR3_CKE),
               .memory_mem_cs_n                       ( HPS_DDR3_CS_N),
               .memory_mem_ras_n                      ( HPS_DDR3_RAS_N),
               .memory_mem_cas_n                      ( HPS_DDR3_CAS_N),
               .memory_mem_we_n                       ( HPS_DDR3_WE_N),
               .memory_mem_reset_n                    ( HPS_DDR3_RESET_N),
               .memory_mem_dq                         ( HPS_DDR3_DQ),
               .memory_mem_dqs                        ( HPS_DDR3_DQS_P),
               .memory_mem_dqs_n                      ( HPS_DDR3_DQS_N),
               .memory_mem_odt                        ( HPS_DDR3_ODT),
               .memory_mem_dm                         ( HPS_DDR3_DM),
               .memory_oct_rzqin                      ( HPS_DDR3_RZQ),
               //hps ethernet      
               .hps_0_hps_io_hps_io_emac1_inst_TX_CLK ( HPS_ENET_GTX_CLK),
               .hps_0_hps_io_hps_io_emac1_inst_TXD0   ( HPS_ENET_TX_DATA[0] ),
               .hps_0_hps_io_hps_io_emac1_inst_TXD1   ( HPS_ENET_TX_DATA[1] ),
               .hps_0_hps_io_hps_io_emac1_inst_TXD2   ( HPS_ENET_TX_DATA[2] ),
               .hps_0_hps_io_hps_io_emac1_inst_TXD3   ( HPS_ENET_TX_DATA[3] ),
               .hps_0_hps_io_hps_io_emac1_inst_RXD0   ( HPS_ENET_RX_DATA[0] ),
               .hps_0_hps_io_hps_io_emac1_inst_MDIO   ( HPS_ENET_MDIO ),
               .hps_0_hps_io_hps_io_emac1_inst_MDC    ( HPS_ENET_MDC  ),
               .hps_0_hps_io_hps_io_emac1_inst_RX_CTL ( HPS_ENET_RX_DV),
               .hps_0_hps_io_hps_io_emac1_inst_TX_CTL ( HPS_ENET_TX_EN),
               .hps_0_hps_io_hps_io_emac1_inst_RX_CLK ( HPS_ENET_RX_CLK),
               .hps_0_hps_io_hps_io_emac1_inst_RXD1   ( HPS_ENET_RX_DATA[1] ),
               .hps_0_hps_io_hps_io_emac1_inst_RXD2   ( HPS_ENET_RX_DATA[2] ),
               .hps_0_hps_io_hps_io_emac1_inst_RXD3   ( HPS_ENET_RX_DATA[3] ),
               
               //hps flash
               .hps_0_hps_io_hps_io_qspi_inst_IO0     ( HPS_FLASH_DATA[0]    ),
               .hps_0_hps_io_hps_io_qspi_inst_IO1     ( HPS_FLASH_DATA[1]    ),
               .hps_0_hps_io_hps_io_qspi_inst_IO2     ( HPS_FLASH_DATA[2]    ),
               .hps_0_hps_io_hps_io_qspi_inst_IO3     ( HPS_FLASH_DATA[3]    ),
               .hps_0_hps_io_hps_io_qspi_inst_SS0     ( HPS_FLASH_NCSO    ),
               .hps_0_hps_io_hps_io_qspi_inst_CLK     ( HPS_FLASH_DCLK    ),
               
               //hps sd card
               .hps_0_hps_io_hps_io_sdio_inst_CMD     ( HPS_SD_CMD    ),
               .hps_0_hps_io_hps_io_sdio_inst_D0      ( HPS_SD_DATA[0]     ),
               .hps_0_hps_io_hps_io_sdio_inst_D1      ( HPS_SD_DATA[1]     ),
               .hps_0_hps_io_hps_io_sdio_inst_CLK     ( HPS_SD_CLK   ),
               .hps_0_hps_io_hps_io_sdio_inst_D2      ( HPS_SD_DATA[2]     ),
               .hps_0_hps_io_hps_io_sdio_inst_D3      ( HPS_SD_DATA[3]     ),
               
               //hps usb           
               .hps_0_hps_io_hps_io_usb1_inst_D0      ( HPS_USB_DATA[0]    ),
               .hps_0_hps_io_hps_io_usb1_inst_D1      ( HPS_USB_DATA[1]    ),
               .hps_0_hps_io_hps_io_usb1_inst_D2      ( HPS_USB_DATA[2]    ),
               .hps_0_hps_io_hps_io_usb1_inst_D3      ( HPS_USB_DATA[3]    ),
               .hps_0_hps_io_hps_io_usb1_inst_D4      ( HPS_USB_DATA[4]    ),
               .hps_0_hps_io_hps_io_usb1_inst_D5      ( HPS_USB_DATA[5]    ),
               .hps_0_hps_io_hps_io_usb1_inst_D6      ( HPS_USB_DATA[6]    ),
               .hps_0_hps_io_hps_io_usb1_inst_D7      ( HPS_USB_DATA[7]    ),
               .hps_0_hps_io_hps_io_usb1_inst_CLK     ( HPS_USB_CLKOUT    ),
               .hps_0_hps_io_hps_io_usb1_inst_STP     ( HPS_USB_STP    ),
               .hps_0_hps_io_hps_io_usb1_inst_DIR     ( HPS_USB_DIR    ),
               .hps_0_hps_io_hps_io_usb1_inst_NXT     ( HPS_USB_NXT    ),
               
               //spim0         
               .hps_0_hps_io_hps_io_spim0_inst_CLK    ( HPS_SPIM_CLK  ),
               .hps_0_hps_io_hps_io_spim0_inst_MOSI   ( HPS_SPIM_MOSI ),
               .hps_0_hps_io_hps_io_spim0_inst_MISO   ( HPS_SPIM_MISO ),
               .hps_0_hps_io_hps_io_spim0_inst_SS0    ( HPS_SPIM_SS ),
               
               //spim1
               .hps_0_hps_io_hps_io_spim1_inst_CLK    (HPS_LCM_SPIM_CLK  ),
               .hps_0_hps_io_hps_io_spim1_inst_MOSI   (HPS_LCM_SPIM_MOSI ),
               .hps_0_hps_io_hps_io_spim1_inst_MISO   (HPS_LCM_SPIM_MISO ),
               .hps_0_hps_io_hps_io_spim1_inst_SS0    (HPS_LCM_SPIM_SS),
               
               //hps uart
               .hps_0_hps_io_hps_io_uart0_inst_RX     ( HPS_UART_RX    ),
               .hps_0_hps_io_hps_io_uart0_inst_TX     ( HPS_UART_TX    ),
               
               //hps i2c1
               .hps_0_hps_io_hps_io_i2c1_inst_SDA     ( HPS_I2C_SDA),
               .hps_0_hps_io_hps_io_i2c1_inst_SCL     ( HPS_I2C_CLK),
               
               //hps gpio
               .hps_0_hps_io_hps_io_gpio_inst_GPIO00  (HPS_LTC_GPIO),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO09  (HPS_CONV_USB_n),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO35  (HPS_ENET_INT_n),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO40  (HPS_LCM_BK ),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO48  (HPS_LCM_RST_N ),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO53  (HPS_LED[0] ),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO54  (HPS_LED[1] ),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO55  (HPS_LED[2] ),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO56  (HPS_LED[3] ),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO61  (HPS_GSENSOR_INT),
               .hps_0_hps_io_hps_io_gpio_inst_GPIO62  (HPS_LCM_D_C),
               
               .hps_0_f2h_stm_hw_events_stm_hwevents  (stm_hw_events),
               //clock & reset
               .clk_clk                               (OSC_50_B3B),
               .reset_reset_n                         (hps_fpga_reset_n),
               //reg
               .reg_avl_waitrequest   (reg_avl_waitrequest   ),
               .reg_avl_readdata      (reg_avl_readdata      ),
               .reg_avl_readdatavalid (reg_avl_readdatavalid ),
               .reg_avl_burstcount    (reg_avl_burstcount    ),
               .reg_avl_writedata     (reg_avl_writedata     ),
               .reg_avl_address       (reg_avl_address       ),
               .reg_avl_write         (reg_avl_write         ),
               .reg_avl_read          (reg_avl_read          ),
               .reg_avl_byteenable    (reg_avl_byteenable    ),
               .reg_avl_debugaccess   (reg_avl_debugaccess   ),

               .h2f_0_waitrequest   (h2f_0_waitrequest   ),
               .h2f_0_readdata      (h2f_0_readdata      ),
               .h2f_0_readdatavalid (h2f_0_readdatavalid ),
               .h2f_0_burstcount    (h2f_0_burstcount    ),
               .h2f_0_writedata     (h2f_0_writedata     ),
               .h2f_0_address       (h2f_0_address       ),
               .h2f_0_write         (h2f_0_write         ),
               .h2f_0_read          (h2f_0_read          ),
               .h2f_0_byteenable    (h2f_0_byteenable    ),
               .h2f_0_debugaccess   (h2f_0_debugaccess   ),
		       .afi_clk_clk         (mem_clk),

               //reset 
               .hps_0_h2f_reset_reset_n               (hps_fpga_reset_n),
               .hps_0_f2h_warm_reset_req_reset_n      (~hps_warm_reset),
               .hps_0_f2h_debug_reset_req_reset_n     (~hps_debug_reset),
               .hps_0_f2h_cold_reset_req_reset_n      (~hps_cold_reset)
               );

assign fpga_reset_n = hps_fpga_reset_n & RESET_n;

// Debounce logic to clean out glitches within 1ms
debounce debounce_inst (
  .clk                                  (OSC_50_B3B),
  .reset_n                              (fpga_reset_n),  
  .data_in                              (KEY[3:0]),
  .data_out                             (fpga_debounced_buttons)
);
  defparam debounce_inst.WIDTH = 4;
  defparam debounce_inst.POLARITY = "LOW";
  defparam debounce_inst.TIMEOUT = 50000;               // at 50Mhz this is a debounce time of 1ms
  defparam debounce_inst.TIMEOUT_WIDTH = 16;            // ceil(log2(TIMEOUT))
  
// Source/Probe megawizard instance
hps_reset hps_reset_inst (
  .source_clk (OSC_50_B3B),
  .source     (hps_reset_req)
);

altera_edge_detector pulse_cold_reset (
  .clk       (OSC_50_B3B),
  .rst_n     (fpga_reset_n),
  .signal_in (hps_reset_req[0]),
  .pulse_out (hps_cold_reset)
);
  defparam pulse_cold_reset.PULSE_EXT = 6;
  defparam pulse_cold_reset.EDGE_TYPE = 1;
  defparam pulse_cold_reset.IGNORE_RST_WHILE_BUSY = 1;

altera_edge_detector pulse_warm_reset (
  .clk       (OSC_50_B3B),
  .rst_n     (fpga_reset_n),
  .signal_in (hps_reset_req[1]),
  .pulse_out (hps_warm_reset)
);
  defparam pulse_warm_reset.PULSE_EXT = 2;
  defparam pulse_warm_reset.EDGE_TYPE = 1;
  defparam pulse_warm_reset.IGNORE_RST_WHILE_BUSY = 1;
  
altera_edge_detector pulse_debug_reset (
  .clk       (OSC_50_B3B),
  .rst_n     (fpga_reset_n),
  .signal_in (hps_reset_req[2]),
  .pulse_out (hps_debug_reset)
);
  defparam pulse_debug_reset.PULSE_EXT = 32;
  defparam pulse_debug_reset.EDGE_TYPE = 1;
  defparam pulse_debug_reset.IGNORE_RST_WHILE_BUSY = 1;

fpga_mem u1(
            .clk_clk                                                  (OSC_50_B3B),
            .reset_reset_n                                            (fpga_reset_n),
            //memif       
            .memory_0_mem_a                                           (DDR3_A),
            .memory_0_mem_ba                                          (DDR3_BA),
            .memory_0_mem_ck                                          (DDR3_CK_p),
            .memory_0_mem_ck_n                                        (DDR3_CK_n),
            .memory_0_mem_cke                                         (DDR3_CKE),
            .memory_0_mem_cs_n                                        (DDR3_CS_n),
            .memory_0_mem_dm                                          (DDR3_DM),
            .memory_0_mem_ras_n                                       (DDR3_RAS_n),
            .memory_0_mem_cas_n                                       (DDR3_CAS_n),
            .memory_0_mem_we_n                                        (DDR3_WE_n),
            .memory_0_mem_reset_n                                     (DDR3_RESET_n),
            .memory_0_mem_dq                                          (DDR3_DQ),
            .memory_0_mem_dqs                                         (DDR3_DQS_p),
            .memory_0_mem_dqs_n                                       (DDR3_DQS_n),
            .memory_0_mem_odt                                         (DDR3_ODT),
            .oct_rzqin                                                (DDR3_RZQ),
            .mem_if_ddr3_emif_0_status_local_init_done                (ddr3_init_done),
            .mem_if_ddr3_emif_0_status_local_cal_success              (),
            .mem_if_ddr3_emif_0_status_local_cal_fail                 (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_mem_clk               (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_write_clk             (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_locked                (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_write_clk_pre_phy_clk (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_addr_cmd_clk          (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_avl_clk               (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_config_clk            (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_dr_clk                (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_dr_clk_pre_phy_clk    (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_mem_phy_clk           (),
            .mem_if_ddr3_emif_0_pll_sharing_afi_phy_clk               (),
            .mem_if_ddr3_emif_0_pll_sharing_pll_avl_phy_clk           (),
            
            .mrx_waitrequest      (mrx_waitrequest   ),
            .mrx_readdata         (mrx_readdata      ),
            .mrx_readdatavalid    (mrx_readdatavalid ),
            .mrx_burstcount       (mrx_burstcount    [5:0]),
            .mrx_writedata        (128'd0),
            .mrx_address          (mrx_address       ),
            .mrx_write            (1'b0),
            .mrx_read             (mrx_read          ),
            .mrx_byteenable       (16'hffff),
            .mrx_debugaccess      (1'b0),
            .mr0_waitrequest      (mr0_waitrequest   ),
            .mr0_readdata         (mr0_readdata      ),
            .mr0_readdatavalid    (mr0_readdatavalid ),
            .mr0_burstcount       (mr0_burstcount    [5:0]),
            .mr0_writedata        (128'd0),
            .mr0_address          (mr0_address       ),
            .mr0_write            (1'b0),
            .mr0_read             (mr0_read          ),
            .mr0_byteenable       (16'hffff),
            .mr0_debugaccess      (1'b0),
            .mr1_waitrequest      (mr1_waitrequest   ),
            .mr1_readdata         (mr1_readdata      ),
            .mr1_readdatavalid    (mr1_readdatavalid ),
            .mr1_burstcount       (mr1_burstcount    [5:0]),
            .mr1_writedata        (128'd0),
            .mr1_address          (mr1_address       ),
            .mr1_write            (1'b0),
            .mr1_read             (mr1_read          ),
            .mr1_byteenable       (16'hffff),
            .mr1_debugaccess      (1'b0),
            .mr2_waitrequest      (mr2_waitrequest   ),
            .mr2_readdata         (mr2_readdata      ),
            .mr2_readdatavalid    (mr2_readdatavalid ),
            .mr2_burstcount       (mr2_burstcount    [5:0]),
            .mr2_writedata        (128'd0),
            .mr2_address          (mr2_address       ),
            .mr2_write            (1'b0),
            .mr2_read             (mr2_read          ),
            .mr2_byteenable       (16'hffff),
            .mr2_debugaccess      (1'b0),
            .mr3_waitrequest      (mr3_waitrequest   ),
            .mr3_readdata         (mr3_readdata      ),
            .mr3_readdatavalid    (mr3_readdatavalid ),
            .mr3_burstcount       (mr3_burstcount    [5:0]),
            .mr3_writedata        (128'd0),
            .mr3_address          (mr3_address       ),
            .mr3_write            (1'b0),
            .mr3_read             (mr3_read          ),
            .mr3_byteenable       (16'hffff),
            .mr3_debugaccess      (1'b0),
            
            .mwx_waitrequest      (mwx_waitrequest   ),
            .mwx_readdata         (),
            .mwx_readdatavalid    (),
            .mwx_burstcount       (mwx_burstcount    [5:0]),
            .mwx_writedata        (mwx_writedata     ),
            .mwx_address          (mwx_address       ),
            .mwx_write            (mwx_write         ),
            .mwx_read             (1'b0),
            .mwx_byteenable       (16'hffff),
            .mwx_debugaccess      (1'b0),
            .mw0_waitrequest      (mw0_waitrequest   ),
            .mw0_readdata         (),
            .mw0_readdatavalid    (),
            .mw0_burstcount       (mw0_burstcount    [5:0]),
            .mw0_writedata        (mw0_writedata     ),
            .mw0_address          (mw0_address       ),
            .mw0_write            (mw0_write         ),
            .mw0_read             (1'b0),
            .mw0_byteenable       (16'hffff),
            .mw0_debugaccess      (1'b0),
            .mw1_waitrequest      (mw1_waitrequest   ),
            .mw1_readdata         (),
            .mw1_readdatavalid    (),
            .mw1_burstcount       (mw1_burstcount    [5:0]),
            .mw1_writedata        (mw1_writedata     ),
            .mw1_address          (mw1_address       ),
            .mw1_write            (mw1_write         ),
            .mw1_read             (1'b0),
            .mw1_byteenable       (16'hffff),
            .mw1_debugaccess      (1'b0),
            .mw2_waitrequest      (mw2_waitrequest   ),
            .mw2_readdata         (),
            .mw2_readdatavalid    (),
            .mw2_burstcount       (mw2_burstcount    [5:0]),
            .mw2_writedata        (mw2_writedata     ),
            .mw2_address          (mw2_address       ),
            .mw2_write            (mw2_write         ),
            .mw2_read             (1'b0),
            .mw2_byteenable       (16'hffff),
            .mw2_debugaccess      (1'b0),
            .mw3_waitrequest      (mw3_waitrequest   ),
            .mw3_readdata         (),
            .mw3_readdatavalid    (),
            .mw3_burstcount       (mw3_burstcount    [5:0]),
            .mw3_writedata        (mw3_writedata     ),
            .mw3_address          (mw3_address       ),
            .mw3_write            (mw3_write         ),
            .mw3_read             (1'b0),
            .mw3_byteenable       (16'hffff),
            .mw3_debugaccess      (1'b0),
            
            .hps_waitrequest      (h2f_0_waitrequest   ),
            .hps_readdata         (h2f_0_readdata      ),
            .hps_readdatavalid    (h2f_0_readdatavalid ),
            .hps_burstcount       (h2f_0_burstcount    ),
            .hps_writedata        (h2f_0_writedata     ),
            .hps_address          (h2f_0_address       ),
            .hps_write            (h2f_0_write         ),
            .hps_read             (h2f_0_read          ),
            .hps_byteenable       (h2f_0_byteenable    ),
            .hps_debugaccess      (h2f_0_debugaccess   ),

            .afi_clk_clk          (mem_clk)
            );

wire clks; 
wire clk80; 
wire clk100; 
wire clk120; 
wire clk150; 
pll c_pll(
          .refclk   (OSC_50_B3B),
          .rst      (~hps_fpga_reset_n),
          .outclk_0 (clk80),
          .outclk_1 (clk100),
          .outclk_2 (clk120),
          .outclk_3 (clk150),
          .locked   () 
          );
//assign clks = (SW==0) ? OSC_50_B3B :
//              (SW==1) ? clk80  :
//              (SW==2) ? clk100 :
//              (SW==3) ? clk120 :
//              (SW==4) ? clk150 : OSC_50_B3B ;
//assign clks = OSC_50_B3B ;
assign clks = clk80;

/*zcnn_core AUTO_TEMPLATE(
 .avl_write           (reg_avl_write),
 .avl_read            (reg_avl_read),
 .avl_address         (reg_avl_address[]),
 .avl_writedata       (reg_avl_writedata[]),
 .avl_byteenable      (reg_avl_byteenable[]),
 .avl_waitrequest     (reg_avl_waitrequest),
 .avl_readdata        (reg_avl_readdata[]),
 .avl_readdatavalid   (reg_avl_readdatavalid),
 .avl_clk             (OSC_50_B3B),
 .clk                 (clks),
 .resb                (fpga_reset_n),
 );
 */
zcnn_core c_zcnn
(/*AUTOINST*/
 // Outputs
 .avl_waitrequest                       (reg_avl_waitrequest),   // Templated
 .avl_readdata                          (reg_avl_readdata[31:0]), // Templated
 .avl_readdatavalid                     (reg_avl_readdatavalid), // Templated
 .mrx_read                              (mrx_read),
 .mrx_address                           (mrx_address[25:0]),
 .mrx_burstcount                        (mrx_burstcount[7:0]),
 .mr0_read                              (mr0_read),
 .mr0_address                           (mr0_address[25:0]),
 .mr0_burstcount                        (mr0_burstcount[7:0]),
 .mr1_read                              (mr1_read),
 .mr1_address                           (mr1_address[25:0]),
 .mr1_burstcount                        (mr1_burstcount[7:0]),
 .mr2_read                              (mr2_read),
 .mr2_address                           (mr2_address[25:0]),
 .mr2_burstcount                        (mr2_burstcount[7:0]),
 .mr3_read                              (mr3_read),
 .mr3_address                           (mr3_address[25:0]),
 .mr3_burstcount                        (mr3_burstcount[7:0]),
 .mwx_write                             (mwx_write),
 .mwx_address                           (mwx_address[25:0]),
 .mwx_burstcount                        (mwx_burstcount[7:0]),
 .mwx_writedata                         (mwx_writedata[127:0]),
 .mw0_write                             (mw0_write),
 .mw0_address                           (mw0_address[25:0]),
 .mw0_burstcount                        (mw0_burstcount[7:0]),
 .mw0_writedata                         (mw0_writedata[127:0]),
 .mw1_write                             (mw1_write),
 .mw1_address                           (mw1_address[25:0]),
 .mw1_burstcount                        (mw1_burstcount[7:0]),
 .mw1_writedata                         (mw1_writedata[127:0]),
 .mw2_write                             (mw2_write),
 .mw2_address                           (mw2_address[25:0]),
 .mw2_burstcount                        (mw2_burstcount[7:0]),
 .mw2_writedata                         (mw2_writedata[127:0]),
 .mw3_write                             (mw3_write),
 .mw3_address                           (mw3_address[25:0]),
 .mw3_burstcount                        (mw3_burstcount[7:0]),
 .mw3_writedata                         (mw3_writedata[127:0]),
 .zcnn_busy                             (zcnn_busy),
 // Inputs
 .resb                                  (fpga_reset_n),          // Templated
 .avl_clk                               (OSC_50_B3B),            // Templated
 .avl_write                             (reg_avl_write),         // Templated
 .avl_read                              (reg_avl_read),          // Templated
 .avl_address                           (reg_avl_address[9:0]),  // Templated
 .avl_writedata                         (reg_avl_writedata[31:0]), // Templated
 .avl_byteenable                        (reg_avl_byteenable[3:0]), // Templated
 .clk                                   (clks),                  // Templated
 .mem_clk                               (mem_clk),
 .mrx_waitrequest                       (mrx_waitrequest),
 .mrx_readdatavalid                     (mrx_readdatavalid),
 .mrx_readdata                          (mrx_readdata[127:0]),
 .mr0_waitrequest                       (mr0_waitrequest),
 .mr0_readdatavalid                     (mr0_readdatavalid),
 .mr0_readdata                          (mr0_readdata[127:0]),
 .mr1_waitrequest                       (mr1_waitrequest),
 .mr1_readdatavalid                     (mr1_readdatavalid),
 .mr1_readdata                          (mr1_readdata[127:0]),
 .mr2_waitrequest                       (mr2_waitrequest),
 .mr2_readdatavalid                     (mr2_readdatavalid),
 .mr2_readdata                          (mr2_readdata[127:0]),
 .mr3_waitrequest                       (mr3_waitrequest),
 .mr3_readdatavalid                     (mr3_readdatavalid),
 .mr3_readdata                          (mr3_readdata[127:0]),
 .mwx_waitrequest                       (mwx_waitrequest),
 .mw0_waitrequest                       (mw0_waitrequest),
 .mw1_waitrequest                       (mw1_waitrequest),
 .mw2_waitrequest                       (mw2_waitrequest),
 .mw3_waitrequest                       (mw3_waitrequest));

assign LED[0] = zcnn_busy;

endmodule // top

//synopsys translate_off
`default_nettype wire
//synopsys translate_on
