// (C) 2001-2013 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       soc_system_hps_0_hps_io_border_hps_io
// role:width:direction:                              hps_io_emac1_inst_TX_CLK:1:output,hps_io_emac1_inst_TXD0:1:output,hps_io_emac1_inst_TXD1:1:output,hps_io_emac1_inst_TXD2:1:output,hps_io_emac1_inst_TXD3:1:output,hps_io_emac1_inst_RXD0:1:input,hps_io_emac1_inst_MDIO:1:bidir,hps_io_emac1_inst_MDC:1:output,hps_io_emac1_inst_RX_CTL:1:input,hps_io_emac1_inst_TX_CTL:1:output,hps_io_emac1_inst_RX_CLK:1:input,hps_io_emac1_inst_RXD1:1:input,hps_io_emac1_inst_RXD2:1:input,hps_io_emac1_inst_RXD3:1:input,hps_io_qspi_inst_IO0:1:bidir,hps_io_qspi_inst_IO1:1:bidir,hps_io_qspi_inst_IO2:1:bidir,hps_io_qspi_inst_IO3:1:bidir,hps_io_qspi_inst_SS0:1:output,hps_io_qspi_inst_CLK:1:output,hps_io_sdio_inst_CMD:1:bidir,hps_io_sdio_inst_D0:1:bidir,hps_io_sdio_inst_D1:1:bidir,hps_io_sdio_inst_CLK:1:output,hps_io_sdio_inst_D2:1:bidir,hps_io_sdio_inst_D3:1:bidir,hps_io_usb1_inst_D0:1:bidir,hps_io_usb1_inst_D1:1:bidir,hps_io_usb1_inst_D2:1:bidir,hps_io_usb1_inst_D3:1:bidir,hps_io_usb1_inst_D4:1:bidir,hps_io_usb1_inst_D5:1:bidir,hps_io_usb1_inst_D6:1:bidir,hps_io_usb1_inst_D7:1:bidir,hps_io_usb1_inst_CLK:1:input,hps_io_usb1_inst_STP:1:output,hps_io_usb1_inst_DIR:1:input,hps_io_usb1_inst_NXT:1:input,hps_io_spim0_inst_CLK:1:output,hps_io_spim0_inst_MOSI:1:output,hps_io_spim0_inst_MISO:1:input,hps_io_spim0_inst_SS0:1:output,hps_io_spim1_inst_CLK:1:output,hps_io_spim1_inst_MOSI:1:output,hps_io_spim1_inst_MISO:1:input,hps_io_spim1_inst_SS0:1:output,hps_io_uart0_inst_RX:1:input,hps_io_uart0_inst_TX:1:output,hps_io_i2c1_inst_SDA:1:bidir,hps_io_i2c1_inst_SCL:1:bidir,hps_io_gpio_inst_GPIO00:1:bidir,hps_io_gpio_inst_GPIO09:1:bidir,hps_io_gpio_inst_GPIO35:1:bidir,hps_io_gpio_inst_GPIO40:1:bidir,hps_io_gpio_inst_GPIO48:1:bidir,hps_io_gpio_inst_GPIO53:1:bidir,hps_io_gpio_inst_GPIO54:1:bidir,hps_io_gpio_inst_GPIO55:1:bidir,hps_io_gpio_inst_GPIO56:1:bidir,hps_io_gpio_inst_GPIO61:1:bidir,hps_io_gpio_inst_GPIO62:1:bidir
// 0
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ns

module soc_system_hps_0_hps_io_border_hps_io
(
   sig_hps_io_emac1_inst_TX_CLK,
   sig_hps_io_emac1_inst_TXD0,
   sig_hps_io_emac1_inst_TXD1,
   sig_hps_io_emac1_inst_TXD2,
   sig_hps_io_emac1_inst_TXD3,
   sig_hps_io_emac1_inst_RXD0,
   sig_hps_io_emac1_inst_MDIO,
   sig_hps_io_emac1_inst_MDC,
   sig_hps_io_emac1_inst_RX_CTL,
   sig_hps_io_emac1_inst_TX_CTL,
   sig_hps_io_emac1_inst_RX_CLK,
   sig_hps_io_emac1_inst_RXD1,
   sig_hps_io_emac1_inst_RXD2,
   sig_hps_io_emac1_inst_RXD3,
   sig_hps_io_qspi_inst_IO0,
   sig_hps_io_qspi_inst_IO1,
   sig_hps_io_qspi_inst_IO2,
   sig_hps_io_qspi_inst_IO3,
   sig_hps_io_qspi_inst_SS0,
   sig_hps_io_qspi_inst_CLK,
   sig_hps_io_sdio_inst_CMD,
   sig_hps_io_sdio_inst_D0,
   sig_hps_io_sdio_inst_D1,
   sig_hps_io_sdio_inst_CLK,
   sig_hps_io_sdio_inst_D2,
   sig_hps_io_sdio_inst_D3,
   sig_hps_io_usb1_inst_D0,
   sig_hps_io_usb1_inst_D1,
   sig_hps_io_usb1_inst_D2,
   sig_hps_io_usb1_inst_D3,
   sig_hps_io_usb1_inst_D4,
   sig_hps_io_usb1_inst_D5,
   sig_hps_io_usb1_inst_D6,
   sig_hps_io_usb1_inst_D7,
   sig_hps_io_usb1_inst_CLK,
   sig_hps_io_usb1_inst_STP,
   sig_hps_io_usb1_inst_DIR,
   sig_hps_io_usb1_inst_NXT,
   sig_hps_io_spim0_inst_CLK,
   sig_hps_io_spim0_inst_MOSI,
   sig_hps_io_spim0_inst_MISO,
   sig_hps_io_spim0_inst_SS0,
   sig_hps_io_spim1_inst_CLK,
   sig_hps_io_spim1_inst_MOSI,
   sig_hps_io_spim1_inst_MISO,
   sig_hps_io_spim1_inst_SS0,
   sig_hps_io_uart0_inst_RX,
   sig_hps_io_uart0_inst_TX,
   sig_hps_io_i2c1_inst_SDA,
   sig_hps_io_i2c1_inst_SCL,
   sig_hps_io_gpio_inst_GPIO00,
   sig_hps_io_gpio_inst_GPIO09,
   sig_hps_io_gpio_inst_GPIO35,
   sig_hps_io_gpio_inst_GPIO40,
   sig_hps_io_gpio_inst_GPIO48,
   sig_hps_io_gpio_inst_GPIO53,
   sig_hps_io_gpio_inst_GPIO54,
   sig_hps_io_gpio_inst_GPIO55,
   sig_hps_io_gpio_inst_GPIO56,
   sig_hps_io_gpio_inst_GPIO61,
   sig_hps_io_gpio_inst_GPIO62
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   output sig_hps_io_emac1_inst_TX_CLK;
   output sig_hps_io_emac1_inst_TXD0;
   output sig_hps_io_emac1_inst_TXD1;
   output sig_hps_io_emac1_inst_TXD2;
   output sig_hps_io_emac1_inst_TXD3;
   input sig_hps_io_emac1_inst_RXD0;
   inout wire sig_hps_io_emac1_inst_MDIO;
   output sig_hps_io_emac1_inst_MDC;
   input sig_hps_io_emac1_inst_RX_CTL;
   output sig_hps_io_emac1_inst_TX_CTL;
   input sig_hps_io_emac1_inst_RX_CLK;
   input sig_hps_io_emac1_inst_RXD1;
   input sig_hps_io_emac1_inst_RXD2;
   input sig_hps_io_emac1_inst_RXD3;
   inout wire sig_hps_io_qspi_inst_IO0;
   inout wire sig_hps_io_qspi_inst_IO1;
   inout wire sig_hps_io_qspi_inst_IO2;
   inout wire sig_hps_io_qspi_inst_IO3;
   output sig_hps_io_qspi_inst_SS0;
   output sig_hps_io_qspi_inst_CLK;
   inout wire sig_hps_io_sdio_inst_CMD;
   inout wire sig_hps_io_sdio_inst_D0;
   inout wire sig_hps_io_sdio_inst_D1;
   output sig_hps_io_sdio_inst_CLK;
   inout wire sig_hps_io_sdio_inst_D2;
   inout wire sig_hps_io_sdio_inst_D3;
   inout wire sig_hps_io_usb1_inst_D0;
   inout wire sig_hps_io_usb1_inst_D1;
   inout wire sig_hps_io_usb1_inst_D2;
   inout wire sig_hps_io_usb1_inst_D3;
   inout wire sig_hps_io_usb1_inst_D4;
   inout wire sig_hps_io_usb1_inst_D5;
   inout wire sig_hps_io_usb1_inst_D6;
   inout wire sig_hps_io_usb1_inst_D7;
   input sig_hps_io_usb1_inst_CLK;
   output sig_hps_io_usb1_inst_STP;
   input sig_hps_io_usb1_inst_DIR;
   input sig_hps_io_usb1_inst_NXT;
   output sig_hps_io_spim0_inst_CLK;
   output sig_hps_io_spim0_inst_MOSI;
   input sig_hps_io_spim0_inst_MISO;
   output sig_hps_io_spim0_inst_SS0;
   output sig_hps_io_spim1_inst_CLK;
   output sig_hps_io_spim1_inst_MOSI;
   input sig_hps_io_spim1_inst_MISO;
   output sig_hps_io_spim1_inst_SS0;
   input sig_hps_io_uart0_inst_RX;
   output sig_hps_io_uart0_inst_TX;
   inout wire sig_hps_io_i2c1_inst_SDA;
   inout wire sig_hps_io_i2c1_inst_SCL;
   inout wire sig_hps_io_gpio_inst_GPIO00;
   inout wire sig_hps_io_gpio_inst_GPIO09;
   inout wire sig_hps_io_gpio_inst_GPIO35;
   inout wire sig_hps_io_gpio_inst_GPIO40;
   inout wire sig_hps_io_gpio_inst_GPIO48;
   inout wire sig_hps_io_gpio_inst_GPIO53;
   inout wire sig_hps_io_gpio_inst_GPIO54;
   inout wire sig_hps_io_gpio_inst_GPIO55;
   inout wire sig_hps_io_gpio_inst_GPIO56;
   inout wire sig_hps_io_gpio_inst_GPIO61;
   inout wire sig_hps_io_gpio_inst_GPIO62;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_hps_io_emac1_inst_TX_CLK_t;
   typedef logic ROLE_hps_io_emac1_inst_TXD0_t;
   typedef logic ROLE_hps_io_emac1_inst_TXD1_t;
   typedef logic ROLE_hps_io_emac1_inst_TXD2_t;
   typedef logic ROLE_hps_io_emac1_inst_TXD3_t;
   typedef logic ROLE_hps_io_emac1_inst_RXD0_t;
   typedef logic ROLE_hps_io_emac1_inst_MDIO_t;
   typedef logic ROLE_hps_io_emac1_inst_MDC_t;
   typedef logic ROLE_hps_io_emac1_inst_RX_CTL_t;
   typedef logic ROLE_hps_io_emac1_inst_TX_CTL_t;
   typedef logic ROLE_hps_io_emac1_inst_RX_CLK_t;
   typedef logic ROLE_hps_io_emac1_inst_RXD1_t;
   typedef logic ROLE_hps_io_emac1_inst_RXD2_t;
   typedef logic ROLE_hps_io_emac1_inst_RXD3_t;
   typedef logic ROLE_hps_io_qspi_inst_IO0_t;
   typedef logic ROLE_hps_io_qspi_inst_IO1_t;
   typedef logic ROLE_hps_io_qspi_inst_IO2_t;
   typedef logic ROLE_hps_io_qspi_inst_IO3_t;
   typedef logic ROLE_hps_io_qspi_inst_SS0_t;
   typedef logic ROLE_hps_io_qspi_inst_CLK_t;
   typedef logic ROLE_hps_io_sdio_inst_CMD_t;
   typedef logic ROLE_hps_io_sdio_inst_D0_t;
   typedef logic ROLE_hps_io_sdio_inst_D1_t;
   typedef logic ROLE_hps_io_sdio_inst_CLK_t;
   typedef logic ROLE_hps_io_sdio_inst_D2_t;
   typedef logic ROLE_hps_io_sdio_inst_D3_t;
   typedef logic ROLE_hps_io_usb1_inst_D0_t;
   typedef logic ROLE_hps_io_usb1_inst_D1_t;
   typedef logic ROLE_hps_io_usb1_inst_D2_t;
   typedef logic ROLE_hps_io_usb1_inst_D3_t;
   typedef logic ROLE_hps_io_usb1_inst_D4_t;
   typedef logic ROLE_hps_io_usb1_inst_D5_t;
   typedef logic ROLE_hps_io_usb1_inst_D6_t;
   typedef logic ROLE_hps_io_usb1_inst_D7_t;
   typedef logic ROLE_hps_io_usb1_inst_CLK_t;
   typedef logic ROLE_hps_io_usb1_inst_STP_t;
   typedef logic ROLE_hps_io_usb1_inst_DIR_t;
   typedef logic ROLE_hps_io_usb1_inst_NXT_t;
   typedef logic ROLE_hps_io_spim0_inst_CLK_t;
   typedef logic ROLE_hps_io_spim0_inst_MOSI_t;
   typedef logic ROLE_hps_io_spim0_inst_MISO_t;
   typedef logic ROLE_hps_io_spim0_inst_SS0_t;
   typedef logic ROLE_hps_io_spim1_inst_CLK_t;
   typedef logic ROLE_hps_io_spim1_inst_MOSI_t;
   typedef logic ROLE_hps_io_spim1_inst_MISO_t;
   typedef logic ROLE_hps_io_spim1_inst_SS0_t;
   typedef logic ROLE_hps_io_uart0_inst_RX_t;
   typedef logic ROLE_hps_io_uart0_inst_TX_t;
   typedef logic ROLE_hps_io_i2c1_inst_SDA_t;
   typedef logic ROLE_hps_io_i2c1_inst_SCL_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO00_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO09_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO35_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO40_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO48_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO53_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO54_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO55_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO56_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO61_t;
   typedef logic ROLE_hps_io_gpio_inst_GPIO62_t;

   reg hps_io_emac1_inst_TX_CLK_temp;
   reg hps_io_emac1_inst_TX_CLK_out;
   reg hps_io_emac1_inst_TXD0_temp;
   reg hps_io_emac1_inst_TXD0_out;
   reg hps_io_emac1_inst_TXD1_temp;
   reg hps_io_emac1_inst_TXD1_out;
   reg hps_io_emac1_inst_TXD2_temp;
   reg hps_io_emac1_inst_TXD2_out;
   reg hps_io_emac1_inst_TXD3_temp;
   reg hps_io_emac1_inst_TXD3_out;
   logic [0 : 0] hps_io_emac1_inst_RXD0_in;
   logic [0 : 0] hps_io_emac1_inst_RXD0_local;
   logic hps_io_emac1_inst_MDIO_oe;
   logic hps_io_emac1_inst_MDIO_oe_temp = 0;
   reg hps_io_emac1_inst_MDIO_temp;
   reg hps_io_emac1_inst_MDIO_out;
   logic [0 : 0] hps_io_emac1_inst_MDIO_in;
   logic [0 : 0] hps_io_emac1_inst_MDIO_local;
   reg hps_io_emac1_inst_MDC_temp;
   reg hps_io_emac1_inst_MDC_out;
   logic [0 : 0] hps_io_emac1_inst_RX_CTL_in;
   logic [0 : 0] hps_io_emac1_inst_RX_CTL_local;
   reg hps_io_emac1_inst_TX_CTL_temp;
   reg hps_io_emac1_inst_TX_CTL_out;
   logic [0 : 0] hps_io_emac1_inst_RX_CLK_in;
   logic [0 : 0] hps_io_emac1_inst_RX_CLK_local;
   logic [0 : 0] hps_io_emac1_inst_RXD1_in;
   logic [0 : 0] hps_io_emac1_inst_RXD1_local;
   logic [0 : 0] hps_io_emac1_inst_RXD2_in;
   logic [0 : 0] hps_io_emac1_inst_RXD2_local;
   logic [0 : 0] hps_io_emac1_inst_RXD3_in;
   logic [0 : 0] hps_io_emac1_inst_RXD3_local;
   logic hps_io_qspi_inst_IO0_oe;
   logic hps_io_qspi_inst_IO0_oe_temp = 0;
   reg hps_io_qspi_inst_IO0_temp;
   reg hps_io_qspi_inst_IO0_out;
   logic [0 : 0] hps_io_qspi_inst_IO0_in;
   logic [0 : 0] hps_io_qspi_inst_IO0_local;
   logic hps_io_qspi_inst_IO1_oe;
   logic hps_io_qspi_inst_IO1_oe_temp = 0;
   reg hps_io_qspi_inst_IO1_temp;
   reg hps_io_qspi_inst_IO1_out;
   logic [0 : 0] hps_io_qspi_inst_IO1_in;
   logic [0 : 0] hps_io_qspi_inst_IO1_local;
   logic hps_io_qspi_inst_IO2_oe;
   logic hps_io_qspi_inst_IO2_oe_temp = 0;
   reg hps_io_qspi_inst_IO2_temp;
   reg hps_io_qspi_inst_IO2_out;
   logic [0 : 0] hps_io_qspi_inst_IO2_in;
   logic [0 : 0] hps_io_qspi_inst_IO2_local;
   logic hps_io_qspi_inst_IO3_oe;
   logic hps_io_qspi_inst_IO3_oe_temp = 0;
   reg hps_io_qspi_inst_IO3_temp;
   reg hps_io_qspi_inst_IO3_out;
   logic [0 : 0] hps_io_qspi_inst_IO3_in;
   logic [0 : 0] hps_io_qspi_inst_IO3_local;
   reg hps_io_qspi_inst_SS0_temp;
   reg hps_io_qspi_inst_SS0_out;
   reg hps_io_qspi_inst_CLK_temp;
   reg hps_io_qspi_inst_CLK_out;
   logic hps_io_sdio_inst_CMD_oe;
   logic hps_io_sdio_inst_CMD_oe_temp = 0;
   reg hps_io_sdio_inst_CMD_temp;
   reg hps_io_sdio_inst_CMD_out;
   logic [0 : 0] hps_io_sdio_inst_CMD_in;
   logic [0 : 0] hps_io_sdio_inst_CMD_local;
   logic hps_io_sdio_inst_D0_oe;
   logic hps_io_sdio_inst_D0_oe_temp = 0;
   reg hps_io_sdio_inst_D0_temp;
   reg hps_io_sdio_inst_D0_out;
   logic [0 : 0] hps_io_sdio_inst_D0_in;
   logic [0 : 0] hps_io_sdio_inst_D0_local;
   logic hps_io_sdio_inst_D1_oe;
   logic hps_io_sdio_inst_D1_oe_temp = 0;
   reg hps_io_sdio_inst_D1_temp;
   reg hps_io_sdio_inst_D1_out;
   logic [0 : 0] hps_io_sdio_inst_D1_in;
   logic [0 : 0] hps_io_sdio_inst_D1_local;
   reg hps_io_sdio_inst_CLK_temp;
   reg hps_io_sdio_inst_CLK_out;
   logic hps_io_sdio_inst_D2_oe;
   logic hps_io_sdio_inst_D2_oe_temp = 0;
   reg hps_io_sdio_inst_D2_temp;
   reg hps_io_sdio_inst_D2_out;
   logic [0 : 0] hps_io_sdio_inst_D2_in;
   logic [0 : 0] hps_io_sdio_inst_D2_local;
   logic hps_io_sdio_inst_D3_oe;
   logic hps_io_sdio_inst_D3_oe_temp = 0;
   reg hps_io_sdio_inst_D3_temp;
   reg hps_io_sdio_inst_D3_out;
   logic [0 : 0] hps_io_sdio_inst_D3_in;
   logic [0 : 0] hps_io_sdio_inst_D3_local;
   logic hps_io_usb1_inst_D0_oe;
   logic hps_io_usb1_inst_D0_oe_temp = 0;
   reg hps_io_usb1_inst_D0_temp;
   reg hps_io_usb1_inst_D0_out;
   logic [0 : 0] hps_io_usb1_inst_D0_in;
   logic [0 : 0] hps_io_usb1_inst_D0_local;
   logic hps_io_usb1_inst_D1_oe;
   logic hps_io_usb1_inst_D1_oe_temp = 0;
   reg hps_io_usb1_inst_D1_temp;
   reg hps_io_usb1_inst_D1_out;
   logic [0 : 0] hps_io_usb1_inst_D1_in;
   logic [0 : 0] hps_io_usb1_inst_D1_local;
   logic hps_io_usb1_inst_D2_oe;
   logic hps_io_usb1_inst_D2_oe_temp = 0;
   reg hps_io_usb1_inst_D2_temp;
   reg hps_io_usb1_inst_D2_out;
   logic [0 : 0] hps_io_usb1_inst_D2_in;
   logic [0 : 0] hps_io_usb1_inst_D2_local;
   logic hps_io_usb1_inst_D3_oe;
   logic hps_io_usb1_inst_D3_oe_temp = 0;
   reg hps_io_usb1_inst_D3_temp;
   reg hps_io_usb1_inst_D3_out;
   logic [0 : 0] hps_io_usb1_inst_D3_in;
   logic [0 : 0] hps_io_usb1_inst_D3_local;
   logic hps_io_usb1_inst_D4_oe;
   logic hps_io_usb1_inst_D4_oe_temp = 0;
   reg hps_io_usb1_inst_D4_temp;
   reg hps_io_usb1_inst_D4_out;
   logic [0 : 0] hps_io_usb1_inst_D4_in;
   logic [0 : 0] hps_io_usb1_inst_D4_local;
   logic hps_io_usb1_inst_D5_oe;
   logic hps_io_usb1_inst_D5_oe_temp = 0;
   reg hps_io_usb1_inst_D5_temp;
   reg hps_io_usb1_inst_D5_out;
   logic [0 : 0] hps_io_usb1_inst_D5_in;
   logic [0 : 0] hps_io_usb1_inst_D5_local;
   logic hps_io_usb1_inst_D6_oe;
   logic hps_io_usb1_inst_D6_oe_temp = 0;
   reg hps_io_usb1_inst_D6_temp;
   reg hps_io_usb1_inst_D6_out;
   logic [0 : 0] hps_io_usb1_inst_D6_in;
   logic [0 : 0] hps_io_usb1_inst_D6_local;
   logic hps_io_usb1_inst_D7_oe;
   logic hps_io_usb1_inst_D7_oe_temp = 0;
   reg hps_io_usb1_inst_D7_temp;
   reg hps_io_usb1_inst_D7_out;
   logic [0 : 0] hps_io_usb1_inst_D7_in;
   logic [0 : 0] hps_io_usb1_inst_D7_local;
   logic [0 : 0] hps_io_usb1_inst_CLK_in;
   logic [0 : 0] hps_io_usb1_inst_CLK_local;
   reg hps_io_usb1_inst_STP_temp;
   reg hps_io_usb1_inst_STP_out;
   logic [0 : 0] hps_io_usb1_inst_DIR_in;
   logic [0 : 0] hps_io_usb1_inst_DIR_local;
   logic [0 : 0] hps_io_usb1_inst_NXT_in;
   logic [0 : 0] hps_io_usb1_inst_NXT_local;
   reg hps_io_spim0_inst_CLK_temp;
   reg hps_io_spim0_inst_CLK_out;
   reg hps_io_spim0_inst_MOSI_temp;
   reg hps_io_spim0_inst_MOSI_out;
   logic [0 : 0] hps_io_spim0_inst_MISO_in;
   logic [0 : 0] hps_io_spim0_inst_MISO_local;
   reg hps_io_spim0_inst_SS0_temp;
   reg hps_io_spim0_inst_SS0_out;
   reg hps_io_spim1_inst_CLK_temp;
   reg hps_io_spim1_inst_CLK_out;
   reg hps_io_spim1_inst_MOSI_temp;
   reg hps_io_spim1_inst_MOSI_out;
   logic [0 : 0] hps_io_spim1_inst_MISO_in;
   logic [0 : 0] hps_io_spim1_inst_MISO_local;
   reg hps_io_spim1_inst_SS0_temp;
   reg hps_io_spim1_inst_SS0_out;
   logic [0 : 0] hps_io_uart0_inst_RX_in;
   logic [0 : 0] hps_io_uart0_inst_RX_local;
   reg hps_io_uart0_inst_TX_temp;
   reg hps_io_uart0_inst_TX_out;
   logic hps_io_i2c1_inst_SDA_oe;
   logic hps_io_i2c1_inst_SDA_oe_temp = 0;
   reg hps_io_i2c1_inst_SDA_temp;
   reg hps_io_i2c1_inst_SDA_out;
   logic [0 : 0] hps_io_i2c1_inst_SDA_in;
   logic [0 : 0] hps_io_i2c1_inst_SDA_local;
   logic hps_io_i2c1_inst_SCL_oe;
   logic hps_io_i2c1_inst_SCL_oe_temp = 0;
   reg hps_io_i2c1_inst_SCL_temp;
   reg hps_io_i2c1_inst_SCL_out;
   logic [0 : 0] hps_io_i2c1_inst_SCL_in;
   logic [0 : 0] hps_io_i2c1_inst_SCL_local;
   logic hps_io_gpio_inst_GPIO00_oe;
   logic hps_io_gpio_inst_GPIO00_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO00_temp;
   reg hps_io_gpio_inst_GPIO00_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO00_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO00_local;
   logic hps_io_gpio_inst_GPIO09_oe;
   logic hps_io_gpio_inst_GPIO09_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO09_temp;
   reg hps_io_gpio_inst_GPIO09_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO09_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO09_local;
   logic hps_io_gpio_inst_GPIO35_oe;
   logic hps_io_gpio_inst_GPIO35_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO35_temp;
   reg hps_io_gpio_inst_GPIO35_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO35_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO35_local;
   logic hps_io_gpio_inst_GPIO40_oe;
   logic hps_io_gpio_inst_GPIO40_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO40_temp;
   reg hps_io_gpio_inst_GPIO40_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO40_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO40_local;
   logic hps_io_gpio_inst_GPIO48_oe;
   logic hps_io_gpio_inst_GPIO48_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO48_temp;
   reg hps_io_gpio_inst_GPIO48_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO48_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO48_local;
   logic hps_io_gpio_inst_GPIO53_oe;
   logic hps_io_gpio_inst_GPIO53_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO53_temp;
   reg hps_io_gpio_inst_GPIO53_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO53_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO53_local;
   logic hps_io_gpio_inst_GPIO54_oe;
   logic hps_io_gpio_inst_GPIO54_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO54_temp;
   reg hps_io_gpio_inst_GPIO54_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO54_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO54_local;
   logic hps_io_gpio_inst_GPIO55_oe;
   logic hps_io_gpio_inst_GPIO55_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO55_temp;
   reg hps_io_gpio_inst_GPIO55_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO55_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO55_local;
   logic hps_io_gpio_inst_GPIO56_oe;
   logic hps_io_gpio_inst_GPIO56_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO56_temp;
   reg hps_io_gpio_inst_GPIO56_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO56_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO56_local;
   logic hps_io_gpio_inst_GPIO61_oe;
   logic hps_io_gpio_inst_GPIO61_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO61_temp;
   reg hps_io_gpio_inst_GPIO61_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO61_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO61_local;
   logic hps_io_gpio_inst_GPIO62_oe;
   logic hps_io_gpio_inst_GPIO62_oe_temp = 0;
   reg hps_io_gpio_inst_GPIO62_temp;
   reg hps_io_gpio_inst_GPIO62_out;
   logic [0 : 0] hps_io_gpio_inst_GPIO62_in;
   logic [0 : 0] hps_io_gpio_inst_GPIO62_local;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_input_hps_io_emac1_inst_RXD0_change;
   event signal_input_hps_io_emac1_inst_MDIO_change;
   event signal_input_hps_io_emac1_inst_RX_CTL_change;
   event signal_input_hps_io_emac1_inst_RX_CLK_change;
   event signal_input_hps_io_emac1_inst_RXD1_change;
   event signal_input_hps_io_emac1_inst_RXD2_change;
   event signal_input_hps_io_emac1_inst_RXD3_change;
   event signal_input_hps_io_qspi_inst_IO0_change;
   event signal_input_hps_io_qspi_inst_IO1_change;
   event signal_input_hps_io_qspi_inst_IO2_change;
   event signal_input_hps_io_qspi_inst_IO3_change;
   event signal_input_hps_io_sdio_inst_CMD_change;
   event signal_input_hps_io_sdio_inst_D0_change;
   event signal_input_hps_io_sdio_inst_D1_change;
   event signal_input_hps_io_sdio_inst_D2_change;
   event signal_input_hps_io_sdio_inst_D3_change;
   event signal_input_hps_io_usb1_inst_D0_change;
   event signal_input_hps_io_usb1_inst_D1_change;
   event signal_input_hps_io_usb1_inst_D2_change;
   event signal_input_hps_io_usb1_inst_D3_change;
   event signal_input_hps_io_usb1_inst_D4_change;
   event signal_input_hps_io_usb1_inst_D5_change;
   event signal_input_hps_io_usb1_inst_D6_change;
   event signal_input_hps_io_usb1_inst_D7_change;
   event signal_input_hps_io_usb1_inst_CLK_change;
   event signal_input_hps_io_usb1_inst_DIR_change;
   event signal_input_hps_io_usb1_inst_NXT_change;
   event signal_input_hps_io_spim0_inst_MISO_change;
   event signal_input_hps_io_spim1_inst_MISO_change;
   event signal_input_hps_io_uart0_inst_RX_change;
   event signal_input_hps_io_i2c1_inst_SDA_change;
   event signal_input_hps_io_i2c1_inst_SCL_change;
   event signal_input_hps_io_gpio_inst_GPIO00_change;
   event signal_input_hps_io_gpio_inst_GPIO09_change;
   event signal_input_hps_io_gpio_inst_GPIO35_change;
   event signal_input_hps_io_gpio_inst_GPIO40_change;
   event signal_input_hps_io_gpio_inst_GPIO48_change;
   event signal_input_hps_io_gpio_inst_GPIO53_change;
   event signal_input_hps_io_gpio_inst_GPIO54_change;
   event signal_input_hps_io_gpio_inst_GPIO55_change;
   event signal_input_hps_io_gpio_inst_GPIO56_change;
   event signal_input_hps_io_gpio_inst_GPIO61_change;
   event signal_input_hps_io_gpio_inst_GPIO62_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "13.1";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_TX_CLK
   // -------------------------------------------------------

   function automatic void set_hps_io_emac1_inst_TX_CLK (
      ROLE_hps_io_emac1_inst_TX_CLK_t new_value
   );
      // Drive the new value to hps_io_emac1_inst_TX_CLK.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_emac1_inst_TX_CLK_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_TXD0
   // -------------------------------------------------------

   function automatic void set_hps_io_emac1_inst_TXD0 (
      ROLE_hps_io_emac1_inst_TXD0_t new_value
   );
      // Drive the new value to hps_io_emac1_inst_TXD0.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_emac1_inst_TXD0_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_TXD1
   // -------------------------------------------------------

   function automatic void set_hps_io_emac1_inst_TXD1 (
      ROLE_hps_io_emac1_inst_TXD1_t new_value
   );
      // Drive the new value to hps_io_emac1_inst_TXD1.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_emac1_inst_TXD1_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_TXD2
   // -------------------------------------------------------

   function automatic void set_hps_io_emac1_inst_TXD2 (
      ROLE_hps_io_emac1_inst_TXD2_t new_value
   );
      // Drive the new value to hps_io_emac1_inst_TXD2.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_emac1_inst_TXD2_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_TXD3
   // -------------------------------------------------------

   function automatic void set_hps_io_emac1_inst_TXD3 (
      ROLE_hps_io_emac1_inst_TXD3_t new_value
   );
      // Drive the new value to hps_io_emac1_inst_TXD3.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_emac1_inst_TXD3_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_RXD0
   // -------------------------------------------------------
   function automatic ROLE_hps_io_emac1_inst_RXD0_t get_hps_io_emac1_inst_RXD0();
   
      // Gets the hps_io_emac1_inst_RXD0 input value.
      $sformat(message, "%m: called get_hps_io_emac1_inst_RXD0");
      print(VERBOSITY_DEBUG, message);
      return hps_io_emac1_inst_RXD0_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_MDIO
   // -------------------------------------------------------
   function automatic ROLE_hps_io_emac1_inst_MDIO_t get_hps_io_emac1_inst_MDIO();
   
      // Gets the hps_io_emac1_inst_MDIO input value.
      $sformat(message, "%m: called get_hps_io_emac1_inst_MDIO");
      print(VERBOSITY_DEBUG, message);
      return hps_io_emac1_inst_MDIO_in;
      
   endfunction

   function automatic void set_hps_io_emac1_inst_MDIO (
      ROLE_hps_io_emac1_inst_MDIO_t new_value
   );
      // Drive the new value to hps_io_emac1_inst_MDIO.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_emac1_inst_MDIO_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_emac1_inst_MDIO_oe (
      bit enable
   );
      // bidir port hps_io_emac1_inst_MDIO will work as output port when set to 1.
      // bidir port hps_io_emac1_inst_MDIO will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_emac1_inst_MDIO_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_MDC
   // -------------------------------------------------------

   function automatic void set_hps_io_emac1_inst_MDC (
      ROLE_hps_io_emac1_inst_MDC_t new_value
   );
      // Drive the new value to hps_io_emac1_inst_MDC.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_emac1_inst_MDC_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_RX_CTL
   // -------------------------------------------------------
   function automatic ROLE_hps_io_emac1_inst_RX_CTL_t get_hps_io_emac1_inst_RX_CTL();
   
      // Gets the hps_io_emac1_inst_RX_CTL input value.
      $sformat(message, "%m: called get_hps_io_emac1_inst_RX_CTL");
      print(VERBOSITY_DEBUG, message);
      return hps_io_emac1_inst_RX_CTL_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_TX_CTL
   // -------------------------------------------------------

   function automatic void set_hps_io_emac1_inst_TX_CTL (
      ROLE_hps_io_emac1_inst_TX_CTL_t new_value
   );
      // Drive the new value to hps_io_emac1_inst_TX_CTL.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_emac1_inst_TX_CTL_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_RX_CLK
   // -------------------------------------------------------
   function automatic ROLE_hps_io_emac1_inst_RX_CLK_t get_hps_io_emac1_inst_RX_CLK();
   
      // Gets the hps_io_emac1_inst_RX_CLK input value.
      $sformat(message, "%m: called get_hps_io_emac1_inst_RX_CLK");
      print(VERBOSITY_DEBUG, message);
      return hps_io_emac1_inst_RX_CLK_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_RXD1
   // -------------------------------------------------------
   function automatic ROLE_hps_io_emac1_inst_RXD1_t get_hps_io_emac1_inst_RXD1();
   
      // Gets the hps_io_emac1_inst_RXD1 input value.
      $sformat(message, "%m: called get_hps_io_emac1_inst_RXD1");
      print(VERBOSITY_DEBUG, message);
      return hps_io_emac1_inst_RXD1_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_RXD2
   // -------------------------------------------------------
   function automatic ROLE_hps_io_emac1_inst_RXD2_t get_hps_io_emac1_inst_RXD2();
   
      // Gets the hps_io_emac1_inst_RXD2 input value.
      $sformat(message, "%m: called get_hps_io_emac1_inst_RXD2");
      print(VERBOSITY_DEBUG, message);
      return hps_io_emac1_inst_RXD2_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_emac1_inst_RXD3
   // -------------------------------------------------------
   function automatic ROLE_hps_io_emac1_inst_RXD3_t get_hps_io_emac1_inst_RXD3();
   
      // Gets the hps_io_emac1_inst_RXD3 input value.
      $sformat(message, "%m: called get_hps_io_emac1_inst_RXD3");
      print(VERBOSITY_DEBUG, message);
      return hps_io_emac1_inst_RXD3_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_qspi_inst_IO0
   // -------------------------------------------------------
   function automatic ROLE_hps_io_qspi_inst_IO0_t get_hps_io_qspi_inst_IO0();
   
      // Gets the hps_io_qspi_inst_IO0 input value.
      $sformat(message, "%m: called get_hps_io_qspi_inst_IO0");
      print(VERBOSITY_DEBUG, message);
      return hps_io_qspi_inst_IO0_in;
      
   endfunction

   function automatic void set_hps_io_qspi_inst_IO0 (
      ROLE_hps_io_qspi_inst_IO0_t new_value
   );
      // Drive the new value to hps_io_qspi_inst_IO0.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_IO0_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_qspi_inst_IO0_oe (
      bit enable
   );
      // bidir port hps_io_qspi_inst_IO0 will work as output port when set to 1.
      // bidir port hps_io_qspi_inst_IO0 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_IO0_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_qspi_inst_IO1
   // -------------------------------------------------------
   function automatic ROLE_hps_io_qspi_inst_IO1_t get_hps_io_qspi_inst_IO1();
   
      // Gets the hps_io_qspi_inst_IO1 input value.
      $sformat(message, "%m: called get_hps_io_qspi_inst_IO1");
      print(VERBOSITY_DEBUG, message);
      return hps_io_qspi_inst_IO1_in;
      
   endfunction

   function automatic void set_hps_io_qspi_inst_IO1 (
      ROLE_hps_io_qspi_inst_IO1_t new_value
   );
      // Drive the new value to hps_io_qspi_inst_IO1.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_IO1_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_qspi_inst_IO1_oe (
      bit enable
   );
      // bidir port hps_io_qspi_inst_IO1 will work as output port when set to 1.
      // bidir port hps_io_qspi_inst_IO1 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_IO1_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_qspi_inst_IO2
   // -------------------------------------------------------
   function automatic ROLE_hps_io_qspi_inst_IO2_t get_hps_io_qspi_inst_IO2();
   
      // Gets the hps_io_qspi_inst_IO2 input value.
      $sformat(message, "%m: called get_hps_io_qspi_inst_IO2");
      print(VERBOSITY_DEBUG, message);
      return hps_io_qspi_inst_IO2_in;
      
   endfunction

   function automatic void set_hps_io_qspi_inst_IO2 (
      ROLE_hps_io_qspi_inst_IO2_t new_value
   );
      // Drive the new value to hps_io_qspi_inst_IO2.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_IO2_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_qspi_inst_IO2_oe (
      bit enable
   );
      // bidir port hps_io_qspi_inst_IO2 will work as output port when set to 1.
      // bidir port hps_io_qspi_inst_IO2 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_IO2_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_qspi_inst_IO3
   // -------------------------------------------------------
   function automatic ROLE_hps_io_qspi_inst_IO3_t get_hps_io_qspi_inst_IO3();
   
      // Gets the hps_io_qspi_inst_IO3 input value.
      $sformat(message, "%m: called get_hps_io_qspi_inst_IO3");
      print(VERBOSITY_DEBUG, message);
      return hps_io_qspi_inst_IO3_in;
      
   endfunction

   function automatic void set_hps_io_qspi_inst_IO3 (
      ROLE_hps_io_qspi_inst_IO3_t new_value
   );
      // Drive the new value to hps_io_qspi_inst_IO3.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_IO3_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_qspi_inst_IO3_oe (
      bit enable
   );
      // bidir port hps_io_qspi_inst_IO3 will work as output port when set to 1.
      // bidir port hps_io_qspi_inst_IO3 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_IO3_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_qspi_inst_SS0
   // -------------------------------------------------------

   function automatic void set_hps_io_qspi_inst_SS0 (
      ROLE_hps_io_qspi_inst_SS0_t new_value
   );
      // Drive the new value to hps_io_qspi_inst_SS0.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_SS0_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_qspi_inst_CLK
   // -------------------------------------------------------

   function automatic void set_hps_io_qspi_inst_CLK (
      ROLE_hps_io_qspi_inst_CLK_t new_value
   );
      // Drive the new value to hps_io_qspi_inst_CLK.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_qspi_inst_CLK_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_sdio_inst_CMD
   // -------------------------------------------------------
   function automatic ROLE_hps_io_sdio_inst_CMD_t get_hps_io_sdio_inst_CMD();
   
      // Gets the hps_io_sdio_inst_CMD input value.
      $sformat(message, "%m: called get_hps_io_sdio_inst_CMD");
      print(VERBOSITY_DEBUG, message);
      return hps_io_sdio_inst_CMD_in;
      
   endfunction

   function automatic void set_hps_io_sdio_inst_CMD (
      ROLE_hps_io_sdio_inst_CMD_t new_value
   );
      // Drive the new value to hps_io_sdio_inst_CMD.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_CMD_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_sdio_inst_CMD_oe (
      bit enable
   );
      // bidir port hps_io_sdio_inst_CMD will work as output port when set to 1.
      // bidir port hps_io_sdio_inst_CMD will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_CMD_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_sdio_inst_D0
   // -------------------------------------------------------
   function automatic ROLE_hps_io_sdio_inst_D0_t get_hps_io_sdio_inst_D0();
   
      // Gets the hps_io_sdio_inst_D0 input value.
      $sformat(message, "%m: called get_hps_io_sdio_inst_D0");
      print(VERBOSITY_DEBUG, message);
      return hps_io_sdio_inst_D0_in;
      
   endfunction

   function automatic void set_hps_io_sdio_inst_D0 (
      ROLE_hps_io_sdio_inst_D0_t new_value
   );
      // Drive the new value to hps_io_sdio_inst_D0.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_D0_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_sdio_inst_D0_oe (
      bit enable
   );
      // bidir port hps_io_sdio_inst_D0 will work as output port when set to 1.
      // bidir port hps_io_sdio_inst_D0 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_D0_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_sdio_inst_D1
   // -------------------------------------------------------
   function automatic ROLE_hps_io_sdio_inst_D1_t get_hps_io_sdio_inst_D1();
   
      // Gets the hps_io_sdio_inst_D1 input value.
      $sformat(message, "%m: called get_hps_io_sdio_inst_D1");
      print(VERBOSITY_DEBUG, message);
      return hps_io_sdio_inst_D1_in;
      
   endfunction

   function automatic void set_hps_io_sdio_inst_D1 (
      ROLE_hps_io_sdio_inst_D1_t new_value
   );
      // Drive the new value to hps_io_sdio_inst_D1.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_D1_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_sdio_inst_D1_oe (
      bit enable
   );
      // bidir port hps_io_sdio_inst_D1 will work as output port when set to 1.
      // bidir port hps_io_sdio_inst_D1 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_D1_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_sdio_inst_CLK
   // -------------------------------------------------------

   function automatic void set_hps_io_sdio_inst_CLK (
      ROLE_hps_io_sdio_inst_CLK_t new_value
   );
      // Drive the new value to hps_io_sdio_inst_CLK.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_CLK_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_sdio_inst_D2
   // -------------------------------------------------------
   function automatic ROLE_hps_io_sdio_inst_D2_t get_hps_io_sdio_inst_D2();
   
      // Gets the hps_io_sdio_inst_D2 input value.
      $sformat(message, "%m: called get_hps_io_sdio_inst_D2");
      print(VERBOSITY_DEBUG, message);
      return hps_io_sdio_inst_D2_in;
      
   endfunction

   function automatic void set_hps_io_sdio_inst_D2 (
      ROLE_hps_io_sdio_inst_D2_t new_value
   );
      // Drive the new value to hps_io_sdio_inst_D2.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_D2_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_sdio_inst_D2_oe (
      bit enable
   );
      // bidir port hps_io_sdio_inst_D2 will work as output port when set to 1.
      // bidir port hps_io_sdio_inst_D2 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_D2_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_sdio_inst_D3
   // -------------------------------------------------------
   function automatic ROLE_hps_io_sdio_inst_D3_t get_hps_io_sdio_inst_D3();
   
      // Gets the hps_io_sdio_inst_D3 input value.
      $sformat(message, "%m: called get_hps_io_sdio_inst_D3");
      print(VERBOSITY_DEBUG, message);
      return hps_io_sdio_inst_D3_in;
      
   endfunction

   function automatic void set_hps_io_sdio_inst_D3 (
      ROLE_hps_io_sdio_inst_D3_t new_value
   );
      // Drive the new value to hps_io_sdio_inst_D3.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_D3_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_sdio_inst_D3_oe (
      bit enable
   );
      // bidir port hps_io_sdio_inst_D3 will work as output port when set to 1.
      // bidir port hps_io_sdio_inst_D3 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_sdio_inst_D3_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_D0
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_D0_t get_hps_io_usb1_inst_D0();
   
      // Gets the hps_io_usb1_inst_D0 input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_D0");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_D0_in;
      
   endfunction

   function automatic void set_hps_io_usb1_inst_D0 (
      ROLE_hps_io_usb1_inst_D0_t new_value
   );
      // Drive the new value to hps_io_usb1_inst_D0.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D0_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_usb1_inst_D0_oe (
      bit enable
   );
      // bidir port hps_io_usb1_inst_D0 will work as output port when set to 1.
      // bidir port hps_io_usb1_inst_D0 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D0_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_D1
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_D1_t get_hps_io_usb1_inst_D1();
   
      // Gets the hps_io_usb1_inst_D1 input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_D1");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_D1_in;
      
   endfunction

   function automatic void set_hps_io_usb1_inst_D1 (
      ROLE_hps_io_usb1_inst_D1_t new_value
   );
      // Drive the new value to hps_io_usb1_inst_D1.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D1_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_usb1_inst_D1_oe (
      bit enable
   );
      // bidir port hps_io_usb1_inst_D1 will work as output port when set to 1.
      // bidir port hps_io_usb1_inst_D1 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D1_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_D2
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_D2_t get_hps_io_usb1_inst_D2();
   
      // Gets the hps_io_usb1_inst_D2 input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_D2");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_D2_in;
      
   endfunction

   function automatic void set_hps_io_usb1_inst_D2 (
      ROLE_hps_io_usb1_inst_D2_t new_value
   );
      // Drive the new value to hps_io_usb1_inst_D2.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D2_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_usb1_inst_D2_oe (
      bit enable
   );
      // bidir port hps_io_usb1_inst_D2 will work as output port when set to 1.
      // bidir port hps_io_usb1_inst_D2 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D2_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_D3
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_D3_t get_hps_io_usb1_inst_D3();
   
      // Gets the hps_io_usb1_inst_D3 input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_D3");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_D3_in;
      
   endfunction

   function automatic void set_hps_io_usb1_inst_D3 (
      ROLE_hps_io_usb1_inst_D3_t new_value
   );
      // Drive the new value to hps_io_usb1_inst_D3.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D3_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_usb1_inst_D3_oe (
      bit enable
   );
      // bidir port hps_io_usb1_inst_D3 will work as output port when set to 1.
      // bidir port hps_io_usb1_inst_D3 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D3_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_D4
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_D4_t get_hps_io_usb1_inst_D4();
   
      // Gets the hps_io_usb1_inst_D4 input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_D4");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_D4_in;
      
   endfunction

   function automatic void set_hps_io_usb1_inst_D4 (
      ROLE_hps_io_usb1_inst_D4_t new_value
   );
      // Drive the new value to hps_io_usb1_inst_D4.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D4_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_usb1_inst_D4_oe (
      bit enable
   );
      // bidir port hps_io_usb1_inst_D4 will work as output port when set to 1.
      // bidir port hps_io_usb1_inst_D4 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D4_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_D5
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_D5_t get_hps_io_usb1_inst_D5();
   
      // Gets the hps_io_usb1_inst_D5 input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_D5");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_D5_in;
      
   endfunction

   function automatic void set_hps_io_usb1_inst_D5 (
      ROLE_hps_io_usb1_inst_D5_t new_value
   );
      // Drive the new value to hps_io_usb1_inst_D5.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D5_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_usb1_inst_D5_oe (
      bit enable
   );
      // bidir port hps_io_usb1_inst_D5 will work as output port when set to 1.
      // bidir port hps_io_usb1_inst_D5 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D5_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_D6
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_D6_t get_hps_io_usb1_inst_D6();
   
      // Gets the hps_io_usb1_inst_D6 input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_D6");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_D6_in;
      
   endfunction

   function automatic void set_hps_io_usb1_inst_D6 (
      ROLE_hps_io_usb1_inst_D6_t new_value
   );
      // Drive the new value to hps_io_usb1_inst_D6.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D6_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_usb1_inst_D6_oe (
      bit enable
   );
      // bidir port hps_io_usb1_inst_D6 will work as output port when set to 1.
      // bidir port hps_io_usb1_inst_D6 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D6_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_D7
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_D7_t get_hps_io_usb1_inst_D7();
   
      // Gets the hps_io_usb1_inst_D7 input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_D7");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_D7_in;
      
   endfunction

   function automatic void set_hps_io_usb1_inst_D7 (
      ROLE_hps_io_usb1_inst_D7_t new_value
   );
      // Drive the new value to hps_io_usb1_inst_D7.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D7_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_usb1_inst_D7_oe (
      bit enable
   );
      // bidir port hps_io_usb1_inst_D7 will work as output port when set to 1.
      // bidir port hps_io_usb1_inst_D7 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_D7_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_CLK
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_CLK_t get_hps_io_usb1_inst_CLK();
   
      // Gets the hps_io_usb1_inst_CLK input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_CLK");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_CLK_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_STP
   // -------------------------------------------------------

   function automatic void set_hps_io_usb1_inst_STP (
      ROLE_hps_io_usb1_inst_STP_t new_value
   );
      // Drive the new value to hps_io_usb1_inst_STP.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_usb1_inst_STP_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_DIR
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_DIR_t get_hps_io_usb1_inst_DIR();
   
      // Gets the hps_io_usb1_inst_DIR input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_DIR");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_DIR_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_usb1_inst_NXT
   // -------------------------------------------------------
   function automatic ROLE_hps_io_usb1_inst_NXT_t get_hps_io_usb1_inst_NXT();
   
      // Gets the hps_io_usb1_inst_NXT input value.
      $sformat(message, "%m: called get_hps_io_usb1_inst_NXT");
      print(VERBOSITY_DEBUG, message);
      return hps_io_usb1_inst_NXT_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_spim0_inst_CLK
   // -------------------------------------------------------

   function automatic void set_hps_io_spim0_inst_CLK (
      ROLE_hps_io_spim0_inst_CLK_t new_value
   );
      // Drive the new value to hps_io_spim0_inst_CLK.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_spim0_inst_CLK_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_spim0_inst_MOSI
   // -------------------------------------------------------

   function automatic void set_hps_io_spim0_inst_MOSI (
      ROLE_hps_io_spim0_inst_MOSI_t new_value
   );
      // Drive the new value to hps_io_spim0_inst_MOSI.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_spim0_inst_MOSI_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_spim0_inst_MISO
   // -------------------------------------------------------
   function automatic ROLE_hps_io_spim0_inst_MISO_t get_hps_io_spim0_inst_MISO();
   
      // Gets the hps_io_spim0_inst_MISO input value.
      $sformat(message, "%m: called get_hps_io_spim0_inst_MISO");
      print(VERBOSITY_DEBUG, message);
      return hps_io_spim0_inst_MISO_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_spim0_inst_SS0
   // -------------------------------------------------------

   function automatic void set_hps_io_spim0_inst_SS0 (
      ROLE_hps_io_spim0_inst_SS0_t new_value
   );
      // Drive the new value to hps_io_spim0_inst_SS0.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_spim0_inst_SS0_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_spim1_inst_CLK
   // -------------------------------------------------------

   function automatic void set_hps_io_spim1_inst_CLK (
      ROLE_hps_io_spim1_inst_CLK_t new_value
   );
      // Drive the new value to hps_io_spim1_inst_CLK.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_spim1_inst_CLK_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_spim1_inst_MOSI
   // -------------------------------------------------------

   function automatic void set_hps_io_spim1_inst_MOSI (
      ROLE_hps_io_spim1_inst_MOSI_t new_value
   );
      // Drive the new value to hps_io_spim1_inst_MOSI.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_spim1_inst_MOSI_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_spim1_inst_MISO
   // -------------------------------------------------------
   function automatic ROLE_hps_io_spim1_inst_MISO_t get_hps_io_spim1_inst_MISO();
   
      // Gets the hps_io_spim1_inst_MISO input value.
      $sformat(message, "%m: called get_hps_io_spim1_inst_MISO");
      print(VERBOSITY_DEBUG, message);
      return hps_io_spim1_inst_MISO_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_spim1_inst_SS0
   // -------------------------------------------------------

   function automatic void set_hps_io_spim1_inst_SS0 (
      ROLE_hps_io_spim1_inst_SS0_t new_value
   );
      // Drive the new value to hps_io_spim1_inst_SS0.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_spim1_inst_SS0_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_uart0_inst_RX
   // -------------------------------------------------------
   function automatic ROLE_hps_io_uart0_inst_RX_t get_hps_io_uart0_inst_RX();
   
      // Gets the hps_io_uart0_inst_RX input value.
      $sformat(message, "%m: called get_hps_io_uart0_inst_RX");
      print(VERBOSITY_DEBUG, message);
      return hps_io_uart0_inst_RX_in;
      
   endfunction

   // -------------------------------------------------------
   // hps_io_uart0_inst_TX
   // -------------------------------------------------------

   function automatic void set_hps_io_uart0_inst_TX (
      ROLE_hps_io_uart0_inst_TX_t new_value
   );
      // Drive the new value to hps_io_uart0_inst_TX.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_uart0_inst_TX_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // hps_io_i2c1_inst_SDA
   // -------------------------------------------------------
   function automatic ROLE_hps_io_i2c1_inst_SDA_t get_hps_io_i2c1_inst_SDA();
   
      // Gets the hps_io_i2c1_inst_SDA input value.
      $sformat(message, "%m: called get_hps_io_i2c1_inst_SDA");
      print(VERBOSITY_DEBUG, message);
      return hps_io_i2c1_inst_SDA_in;
      
   endfunction

   function automatic void set_hps_io_i2c1_inst_SDA (
      ROLE_hps_io_i2c1_inst_SDA_t new_value
   );
      // Drive the new value to hps_io_i2c1_inst_SDA.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_i2c1_inst_SDA_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_i2c1_inst_SDA_oe (
      bit enable
   );
      // bidir port hps_io_i2c1_inst_SDA will work as output port when set to 1.
      // bidir port hps_io_i2c1_inst_SDA will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_i2c1_inst_SDA_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_i2c1_inst_SCL
   // -------------------------------------------------------
   function automatic ROLE_hps_io_i2c1_inst_SCL_t get_hps_io_i2c1_inst_SCL();
   
      // Gets the hps_io_i2c1_inst_SCL input value.
      $sformat(message, "%m: called get_hps_io_i2c1_inst_SCL");
      print(VERBOSITY_DEBUG, message);
      return hps_io_i2c1_inst_SCL_in;
      
   endfunction

   function automatic void set_hps_io_i2c1_inst_SCL (
      ROLE_hps_io_i2c1_inst_SCL_t new_value
   );
      // Drive the new value to hps_io_i2c1_inst_SCL.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_i2c1_inst_SCL_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_i2c1_inst_SCL_oe (
      bit enable
   );
      // bidir port hps_io_i2c1_inst_SCL will work as output port when set to 1.
      // bidir port hps_io_i2c1_inst_SCL will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_i2c1_inst_SCL_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO00
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO00_t get_hps_io_gpio_inst_GPIO00();
   
      // Gets the hps_io_gpio_inst_GPIO00 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO00");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO00_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO00 (
      ROLE_hps_io_gpio_inst_GPIO00_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO00.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO00_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO00_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO00 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO00 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO00_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO09
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO09_t get_hps_io_gpio_inst_GPIO09();
   
      // Gets the hps_io_gpio_inst_GPIO09 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO09");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO09_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO09 (
      ROLE_hps_io_gpio_inst_GPIO09_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO09.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO09_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO09_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO09 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO09 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO09_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO35
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO35_t get_hps_io_gpio_inst_GPIO35();
   
      // Gets the hps_io_gpio_inst_GPIO35 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO35");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO35_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO35 (
      ROLE_hps_io_gpio_inst_GPIO35_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO35.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO35_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO35_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO35 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO35 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO35_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO40
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO40_t get_hps_io_gpio_inst_GPIO40();
   
      // Gets the hps_io_gpio_inst_GPIO40 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO40");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO40_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO40 (
      ROLE_hps_io_gpio_inst_GPIO40_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO40.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO40_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO40_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO40 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO40 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO40_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO48
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO48_t get_hps_io_gpio_inst_GPIO48();
   
      // Gets the hps_io_gpio_inst_GPIO48 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO48");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO48_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO48 (
      ROLE_hps_io_gpio_inst_GPIO48_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO48.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO48_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO48_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO48 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO48 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO48_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO53
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO53_t get_hps_io_gpio_inst_GPIO53();
   
      // Gets the hps_io_gpio_inst_GPIO53 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO53");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO53_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO53 (
      ROLE_hps_io_gpio_inst_GPIO53_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO53.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO53_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO53_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO53 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO53 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO53_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO54
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO54_t get_hps_io_gpio_inst_GPIO54();
   
      // Gets the hps_io_gpio_inst_GPIO54 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO54");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO54_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO54 (
      ROLE_hps_io_gpio_inst_GPIO54_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO54.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO54_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO54_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO54 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO54 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO54_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO55
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO55_t get_hps_io_gpio_inst_GPIO55();
   
      // Gets the hps_io_gpio_inst_GPIO55 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO55");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO55_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO55 (
      ROLE_hps_io_gpio_inst_GPIO55_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO55.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO55_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO55_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO55 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO55 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO55_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO56
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO56_t get_hps_io_gpio_inst_GPIO56();
   
      // Gets the hps_io_gpio_inst_GPIO56 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO56");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO56_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO56 (
      ROLE_hps_io_gpio_inst_GPIO56_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO56.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO56_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO56_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO56 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO56 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO56_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO61
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO61_t get_hps_io_gpio_inst_GPIO61();
   
      // Gets the hps_io_gpio_inst_GPIO61 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO61");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO61_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO61 (
      ROLE_hps_io_gpio_inst_GPIO61_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO61.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO61_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO61_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO61 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO61 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO61_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // hps_io_gpio_inst_GPIO62
   // -------------------------------------------------------
   function automatic ROLE_hps_io_gpio_inst_GPIO62_t get_hps_io_gpio_inst_GPIO62();
   
      // Gets the hps_io_gpio_inst_GPIO62 input value.
      $sformat(message, "%m: called get_hps_io_gpio_inst_GPIO62");
      print(VERBOSITY_DEBUG, message);
      return hps_io_gpio_inst_GPIO62_in;
      
   endfunction

   function automatic void set_hps_io_gpio_inst_GPIO62 (
      ROLE_hps_io_gpio_inst_GPIO62_t new_value
   );
      // Drive the new value to hps_io_gpio_inst_GPIO62.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO62_temp = new_value;
   endfunction
   
   function automatic void set_hps_io_gpio_inst_GPIO62_oe (
      bit enable
   );
      // bidir port hps_io_gpio_inst_GPIO62 will work as output port when set to 1.
      // bidir port hps_io_gpio_inst_GPIO62 will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      hps_io_gpio_inst_GPIO62_oe_temp = enable;
   endfunction

   assign sig_hps_io_emac1_inst_TX_CLK = hps_io_emac1_inst_TX_CLK_temp;
   assign sig_hps_io_emac1_inst_TXD0 = hps_io_emac1_inst_TXD0_temp;
   assign sig_hps_io_emac1_inst_TXD1 = hps_io_emac1_inst_TXD1_temp;
   assign sig_hps_io_emac1_inst_TXD2 = hps_io_emac1_inst_TXD2_temp;
   assign sig_hps_io_emac1_inst_TXD3 = hps_io_emac1_inst_TXD3_temp;
   assign hps_io_emac1_inst_RXD0_in = sig_hps_io_emac1_inst_RXD0;
   assign hps_io_emac1_inst_MDIO_oe = hps_io_emac1_inst_MDIO_oe_temp;
   assign sig_hps_io_emac1_inst_MDIO = (hps_io_emac1_inst_MDIO_oe == 1)? hps_io_emac1_inst_MDIO_temp:'z;
   assign hps_io_emac1_inst_MDIO_in = (hps_io_emac1_inst_MDIO_oe == 0)? sig_hps_io_emac1_inst_MDIO:'z;
   assign sig_hps_io_emac1_inst_MDC = hps_io_emac1_inst_MDC_temp;
   assign hps_io_emac1_inst_RX_CTL_in = sig_hps_io_emac1_inst_RX_CTL;
   assign sig_hps_io_emac1_inst_TX_CTL = hps_io_emac1_inst_TX_CTL_temp;
   assign hps_io_emac1_inst_RX_CLK_in = sig_hps_io_emac1_inst_RX_CLK;
   assign hps_io_emac1_inst_RXD1_in = sig_hps_io_emac1_inst_RXD1;
   assign hps_io_emac1_inst_RXD2_in = sig_hps_io_emac1_inst_RXD2;
   assign hps_io_emac1_inst_RXD3_in = sig_hps_io_emac1_inst_RXD3;
   assign hps_io_qspi_inst_IO0_oe = hps_io_qspi_inst_IO0_oe_temp;
   assign sig_hps_io_qspi_inst_IO0 = (hps_io_qspi_inst_IO0_oe == 1)? hps_io_qspi_inst_IO0_temp:'z;
   assign hps_io_qspi_inst_IO0_in = (hps_io_qspi_inst_IO0_oe == 0)? sig_hps_io_qspi_inst_IO0:'z;
   assign hps_io_qspi_inst_IO1_oe = hps_io_qspi_inst_IO1_oe_temp;
   assign sig_hps_io_qspi_inst_IO1 = (hps_io_qspi_inst_IO1_oe == 1)? hps_io_qspi_inst_IO1_temp:'z;
   assign hps_io_qspi_inst_IO1_in = (hps_io_qspi_inst_IO1_oe == 0)? sig_hps_io_qspi_inst_IO1:'z;
   assign hps_io_qspi_inst_IO2_oe = hps_io_qspi_inst_IO2_oe_temp;
   assign sig_hps_io_qspi_inst_IO2 = (hps_io_qspi_inst_IO2_oe == 1)? hps_io_qspi_inst_IO2_temp:'z;
   assign hps_io_qspi_inst_IO2_in = (hps_io_qspi_inst_IO2_oe == 0)? sig_hps_io_qspi_inst_IO2:'z;
   assign hps_io_qspi_inst_IO3_oe = hps_io_qspi_inst_IO3_oe_temp;
   assign sig_hps_io_qspi_inst_IO3 = (hps_io_qspi_inst_IO3_oe == 1)? hps_io_qspi_inst_IO3_temp:'z;
   assign hps_io_qspi_inst_IO3_in = (hps_io_qspi_inst_IO3_oe == 0)? sig_hps_io_qspi_inst_IO3:'z;
   assign sig_hps_io_qspi_inst_SS0 = hps_io_qspi_inst_SS0_temp;
   assign sig_hps_io_qspi_inst_CLK = hps_io_qspi_inst_CLK_temp;
   assign hps_io_sdio_inst_CMD_oe = hps_io_sdio_inst_CMD_oe_temp;
   assign sig_hps_io_sdio_inst_CMD = (hps_io_sdio_inst_CMD_oe == 1)? hps_io_sdio_inst_CMD_temp:'z;
   assign hps_io_sdio_inst_CMD_in = (hps_io_sdio_inst_CMD_oe == 0)? sig_hps_io_sdio_inst_CMD:'z;
   assign hps_io_sdio_inst_D0_oe = hps_io_sdio_inst_D0_oe_temp;
   assign sig_hps_io_sdio_inst_D0 = (hps_io_sdio_inst_D0_oe == 1)? hps_io_sdio_inst_D0_temp:'z;
   assign hps_io_sdio_inst_D0_in = (hps_io_sdio_inst_D0_oe == 0)? sig_hps_io_sdio_inst_D0:'z;
   assign hps_io_sdio_inst_D1_oe = hps_io_sdio_inst_D1_oe_temp;
   assign sig_hps_io_sdio_inst_D1 = (hps_io_sdio_inst_D1_oe == 1)? hps_io_sdio_inst_D1_temp:'z;
   assign hps_io_sdio_inst_D1_in = (hps_io_sdio_inst_D1_oe == 0)? sig_hps_io_sdio_inst_D1:'z;
   assign sig_hps_io_sdio_inst_CLK = hps_io_sdio_inst_CLK_temp;
   assign hps_io_sdio_inst_D2_oe = hps_io_sdio_inst_D2_oe_temp;
   assign sig_hps_io_sdio_inst_D2 = (hps_io_sdio_inst_D2_oe == 1)? hps_io_sdio_inst_D2_temp:'z;
   assign hps_io_sdio_inst_D2_in = (hps_io_sdio_inst_D2_oe == 0)? sig_hps_io_sdio_inst_D2:'z;
   assign hps_io_sdio_inst_D3_oe = hps_io_sdio_inst_D3_oe_temp;
   assign sig_hps_io_sdio_inst_D3 = (hps_io_sdio_inst_D3_oe == 1)? hps_io_sdio_inst_D3_temp:'z;
   assign hps_io_sdio_inst_D3_in = (hps_io_sdio_inst_D3_oe == 0)? sig_hps_io_sdio_inst_D3:'z;
   assign hps_io_usb1_inst_D0_oe = hps_io_usb1_inst_D0_oe_temp;
   assign sig_hps_io_usb1_inst_D0 = (hps_io_usb1_inst_D0_oe == 1)? hps_io_usb1_inst_D0_temp:'z;
   assign hps_io_usb1_inst_D0_in = (hps_io_usb1_inst_D0_oe == 0)? sig_hps_io_usb1_inst_D0:'z;
   assign hps_io_usb1_inst_D1_oe = hps_io_usb1_inst_D1_oe_temp;
   assign sig_hps_io_usb1_inst_D1 = (hps_io_usb1_inst_D1_oe == 1)? hps_io_usb1_inst_D1_temp:'z;
   assign hps_io_usb1_inst_D1_in = (hps_io_usb1_inst_D1_oe == 0)? sig_hps_io_usb1_inst_D1:'z;
   assign hps_io_usb1_inst_D2_oe = hps_io_usb1_inst_D2_oe_temp;
   assign sig_hps_io_usb1_inst_D2 = (hps_io_usb1_inst_D2_oe == 1)? hps_io_usb1_inst_D2_temp:'z;
   assign hps_io_usb1_inst_D2_in = (hps_io_usb1_inst_D2_oe == 0)? sig_hps_io_usb1_inst_D2:'z;
   assign hps_io_usb1_inst_D3_oe = hps_io_usb1_inst_D3_oe_temp;
   assign sig_hps_io_usb1_inst_D3 = (hps_io_usb1_inst_D3_oe == 1)? hps_io_usb1_inst_D3_temp:'z;
   assign hps_io_usb1_inst_D3_in = (hps_io_usb1_inst_D3_oe == 0)? sig_hps_io_usb1_inst_D3:'z;
   assign hps_io_usb1_inst_D4_oe = hps_io_usb1_inst_D4_oe_temp;
   assign sig_hps_io_usb1_inst_D4 = (hps_io_usb1_inst_D4_oe == 1)? hps_io_usb1_inst_D4_temp:'z;
   assign hps_io_usb1_inst_D4_in = (hps_io_usb1_inst_D4_oe == 0)? sig_hps_io_usb1_inst_D4:'z;
   assign hps_io_usb1_inst_D5_oe = hps_io_usb1_inst_D5_oe_temp;
   assign sig_hps_io_usb1_inst_D5 = (hps_io_usb1_inst_D5_oe == 1)? hps_io_usb1_inst_D5_temp:'z;
   assign hps_io_usb1_inst_D5_in = (hps_io_usb1_inst_D5_oe == 0)? sig_hps_io_usb1_inst_D5:'z;
   assign hps_io_usb1_inst_D6_oe = hps_io_usb1_inst_D6_oe_temp;
   assign sig_hps_io_usb1_inst_D6 = (hps_io_usb1_inst_D6_oe == 1)? hps_io_usb1_inst_D6_temp:'z;
   assign hps_io_usb1_inst_D6_in = (hps_io_usb1_inst_D6_oe == 0)? sig_hps_io_usb1_inst_D6:'z;
   assign hps_io_usb1_inst_D7_oe = hps_io_usb1_inst_D7_oe_temp;
   assign sig_hps_io_usb1_inst_D7 = (hps_io_usb1_inst_D7_oe == 1)? hps_io_usb1_inst_D7_temp:'z;
   assign hps_io_usb1_inst_D7_in = (hps_io_usb1_inst_D7_oe == 0)? sig_hps_io_usb1_inst_D7:'z;
   assign hps_io_usb1_inst_CLK_in = sig_hps_io_usb1_inst_CLK;
   assign sig_hps_io_usb1_inst_STP = hps_io_usb1_inst_STP_temp;
   assign hps_io_usb1_inst_DIR_in = sig_hps_io_usb1_inst_DIR;
   assign hps_io_usb1_inst_NXT_in = sig_hps_io_usb1_inst_NXT;
   assign sig_hps_io_spim0_inst_CLK = hps_io_spim0_inst_CLK_temp;
   assign sig_hps_io_spim0_inst_MOSI = hps_io_spim0_inst_MOSI_temp;
   assign hps_io_spim0_inst_MISO_in = sig_hps_io_spim0_inst_MISO;
   assign sig_hps_io_spim0_inst_SS0 = hps_io_spim0_inst_SS0_temp;
   assign sig_hps_io_spim1_inst_CLK = hps_io_spim1_inst_CLK_temp;
   assign sig_hps_io_spim1_inst_MOSI = hps_io_spim1_inst_MOSI_temp;
   assign hps_io_spim1_inst_MISO_in = sig_hps_io_spim1_inst_MISO;
   assign sig_hps_io_spim1_inst_SS0 = hps_io_spim1_inst_SS0_temp;
   assign hps_io_uart0_inst_RX_in = sig_hps_io_uart0_inst_RX;
   assign sig_hps_io_uart0_inst_TX = hps_io_uart0_inst_TX_temp;
   assign hps_io_i2c1_inst_SDA_oe = hps_io_i2c1_inst_SDA_oe_temp;
   assign sig_hps_io_i2c1_inst_SDA = (hps_io_i2c1_inst_SDA_oe == 1)? hps_io_i2c1_inst_SDA_temp:'z;
   assign hps_io_i2c1_inst_SDA_in = (hps_io_i2c1_inst_SDA_oe == 0)? sig_hps_io_i2c1_inst_SDA:'z;
   assign hps_io_i2c1_inst_SCL_oe = hps_io_i2c1_inst_SCL_oe_temp;
   assign sig_hps_io_i2c1_inst_SCL = (hps_io_i2c1_inst_SCL_oe == 1)? hps_io_i2c1_inst_SCL_temp:'z;
   assign hps_io_i2c1_inst_SCL_in = (hps_io_i2c1_inst_SCL_oe == 0)? sig_hps_io_i2c1_inst_SCL:'z;
   assign hps_io_gpio_inst_GPIO00_oe = hps_io_gpio_inst_GPIO00_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO00 = (hps_io_gpio_inst_GPIO00_oe == 1)? hps_io_gpio_inst_GPIO00_temp:'z;
   assign hps_io_gpio_inst_GPIO00_in = (hps_io_gpio_inst_GPIO00_oe == 0)? sig_hps_io_gpio_inst_GPIO00:'z;
   assign hps_io_gpio_inst_GPIO09_oe = hps_io_gpio_inst_GPIO09_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO09 = (hps_io_gpio_inst_GPIO09_oe == 1)? hps_io_gpio_inst_GPIO09_temp:'z;
   assign hps_io_gpio_inst_GPIO09_in = (hps_io_gpio_inst_GPIO09_oe == 0)? sig_hps_io_gpio_inst_GPIO09:'z;
   assign hps_io_gpio_inst_GPIO35_oe = hps_io_gpio_inst_GPIO35_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO35 = (hps_io_gpio_inst_GPIO35_oe == 1)? hps_io_gpio_inst_GPIO35_temp:'z;
   assign hps_io_gpio_inst_GPIO35_in = (hps_io_gpio_inst_GPIO35_oe == 0)? sig_hps_io_gpio_inst_GPIO35:'z;
   assign hps_io_gpio_inst_GPIO40_oe = hps_io_gpio_inst_GPIO40_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO40 = (hps_io_gpio_inst_GPIO40_oe == 1)? hps_io_gpio_inst_GPIO40_temp:'z;
   assign hps_io_gpio_inst_GPIO40_in = (hps_io_gpio_inst_GPIO40_oe == 0)? sig_hps_io_gpio_inst_GPIO40:'z;
   assign hps_io_gpio_inst_GPIO48_oe = hps_io_gpio_inst_GPIO48_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO48 = (hps_io_gpio_inst_GPIO48_oe == 1)? hps_io_gpio_inst_GPIO48_temp:'z;
   assign hps_io_gpio_inst_GPIO48_in = (hps_io_gpio_inst_GPIO48_oe == 0)? sig_hps_io_gpio_inst_GPIO48:'z;
   assign hps_io_gpio_inst_GPIO53_oe = hps_io_gpio_inst_GPIO53_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO53 = (hps_io_gpio_inst_GPIO53_oe == 1)? hps_io_gpio_inst_GPIO53_temp:'z;
   assign hps_io_gpio_inst_GPIO53_in = (hps_io_gpio_inst_GPIO53_oe == 0)? sig_hps_io_gpio_inst_GPIO53:'z;
   assign hps_io_gpio_inst_GPIO54_oe = hps_io_gpio_inst_GPIO54_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO54 = (hps_io_gpio_inst_GPIO54_oe == 1)? hps_io_gpio_inst_GPIO54_temp:'z;
   assign hps_io_gpio_inst_GPIO54_in = (hps_io_gpio_inst_GPIO54_oe == 0)? sig_hps_io_gpio_inst_GPIO54:'z;
   assign hps_io_gpio_inst_GPIO55_oe = hps_io_gpio_inst_GPIO55_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO55 = (hps_io_gpio_inst_GPIO55_oe == 1)? hps_io_gpio_inst_GPIO55_temp:'z;
   assign hps_io_gpio_inst_GPIO55_in = (hps_io_gpio_inst_GPIO55_oe == 0)? sig_hps_io_gpio_inst_GPIO55:'z;
   assign hps_io_gpio_inst_GPIO56_oe = hps_io_gpio_inst_GPIO56_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO56 = (hps_io_gpio_inst_GPIO56_oe == 1)? hps_io_gpio_inst_GPIO56_temp:'z;
   assign hps_io_gpio_inst_GPIO56_in = (hps_io_gpio_inst_GPIO56_oe == 0)? sig_hps_io_gpio_inst_GPIO56:'z;
   assign hps_io_gpio_inst_GPIO61_oe = hps_io_gpio_inst_GPIO61_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO61 = (hps_io_gpio_inst_GPIO61_oe == 1)? hps_io_gpio_inst_GPIO61_temp:'z;
   assign hps_io_gpio_inst_GPIO61_in = (hps_io_gpio_inst_GPIO61_oe == 0)? sig_hps_io_gpio_inst_GPIO61:'z;
   assign hps_io_gpio_inst_GPIO62_oe = hps_io_gpio_inst_GPIO62_oe_temp;
   assign sig_hps_io_gpio_inst_GPIO62 = (hps_io_gpio_inst_GPIO62_oe == 1)? hps_io_gpio_inst_GPIO62_temp:'z;
   assign hps_io_gpio_inst_GPIO62_in = (hps_io_gpio_inst_GPIO62_oe == 0)? sig_hps_io_gpio_inst_GPIO62:'z;


   always @(hps_io_emac1_inst_RXD0_in) begin
      if (hps_io_emac1_inst_RXD0_local != hps_io_emac1_inst_RXD0_in)
         -> signal_input_hps_io_emac1_inst_RXD0_change;
      hps_io_emac1_inst_RXD0_local = hps_io_emac1_inst_RXD0_in;
   end
   
   always @(hps_io_emac1_inst_MDIO_in) begin
      if (hps_io_emac1_inst_MDIO_oe == 0) begin
         if (hps_io_emac1_inst_MDIO_local != hps_io_emac1_inst_MDIO_in)
            -> signal_input_hps_io_emac1_inst_MDIO_change;
         hps_io_emac1_inst_MDIO_local = hps_io_emac1_inst_MDIO_in;
      end
   end
   
   always @(hps_io_emac1_inst_RX_CTL_in) begin
      if (hps_io_emac1_inst_RX_CTL_local != hps_io_emac1_inst_RX_CTL_in)
         -> signal_input_hps_io_emac1_inst_RX_CTL_change;
      hps_io_emac1_inst_RX_CTL_local = hps_io_emac1_inst_RX_CTL_in;
   end
   
   always @(hps_io_emac1_inst_RX_CLK_in) begin
      if (hps_io_emac1_inst_RX_CLK_local != hps_io_emac1_inst_RX_CLK_in)
         -> signal_input_hps_io_emac1_inst_RX_CLK_change;
      hps_io_emac1_inst_RX_CLK_local = hps_io_emac1_inst_RX_CLK_in;
   end
   
   always @(hps_io_emac1_inst_RXD1_in) begin
      if (hps_io_emac1_inst_RXD1_local != hps_io_emac1_inst_RXD1_in)
         -> signal_input_hps_io_emac1_inst_RXD1_change;
      hps_io_emac1_inst_RXD1_local = hps_io_emac1_inst_RXD1_in;
   end
   
   always @(hps_io_emac1_inst_RXD2_in) begin
      if (hps_io_emac1_inst_RXD2_local != hps_io_emac1_inst_RXD2_in)
         -> signal_input_hps_io_emac1_inst_RXD2_change;
      hps_io_emac1_inst_RXD2_local = hps_io_emac1_inst_RXD2_in;
   end
   
   always @(hps_io_emac1_inst_RXD3_in) begin
      if (hps_io_emac1_inst_RXD3_local != hps_io_emac1_inst_RXD3_in)
         -> signal_input_hps_io_emac1_inst_RXD3_change;
      hps_io_emac1_inst_RXD3_local = hps_io_emac1_inst_RXD3_in;
   end
   
   always @(hps_io_qspi_inst_IO0_in) begin
      if (hps_io_qspi_inst_IO0_oe == 0) begin
         if (hps_io_qspi_inst_IO0_local != hps_io_qspi_inst_IO0_in)
            -> signal_input_hps_io_qspi_inst_IO0_change;
         hps_io_qspi_inst_IO0_local = hps_io_qspi_inst_IO0_in;
      end
   end
   
   always @(hps_io_qspi_inst_IO1_in) begin
      if (hps_io_qspi_inst_IO1_oe == 0) begin
         if (hps_io_qspi_inst_IO1_local != hps_io_qspi_inst_IO1_in)
            -> signal_input_hps_io_qspi_inst_IO1_change;
         hps_io_qspi_inst_IO1_local = hps_io_qspi_inst_IO1_in;
      end
   end
   
   always @(hps_io_qspi_inst_IO2_in) begin
      if (hps_io_qspi_inst_IO2_oe == 0) begin
         if (hps_io_qspi_inst_IO2_local != hps_io_qspi_inst_IO2_in)
            -> signal_input_hps_io_qspi_inst_IO2_change;
         hps_io_qspi_inst_IO2_local = hps_io_qspi_inst_IO2_in;
      end
   end
   
   always @(hps_io_qspi_inst_IO3_in) begin
      if (hps_io_qspi_inst_IO3_oe == 0) begin
         if (hps_io_qspi_inst_IO3_local != hps_io_qspi_inst_IO3_in)
            -> signal_input_hps_io_qspi_inst_IO3_change;
         hps_io_qspi_inst_IO3_local = hps_io_qspi_inst_IO3_in;
      end
   end
   
   always @(hps_io_sdio_inst_CMD_in) begin
      if (hps_io_sdio_inst_CMD_oe == 0) begin
         if (hps_io_sdio_inst_CMD_local != hps_io_sdio_inst_CMD_in)
            -> signal_input_hps_io_sdio_inst_CMD_change;
         hps_io_sdio_inst_CMD_local = hps_io_sdio_inst_CMD_in;
      end
   end
   
   always @(hps_io_sdio_inst_D0_in) begin
      if (hps_io_sdio_inst_D0_oe == 0) begin
         if (hps_io_sdio_inst_D0_local != hps_io_sdio_inst_D0_in)
            -> signal_input_hps_io_sdio_inst_D0_change;
         hps_io_sdio_inst_D0_local = hps_io_sdio_inst_D0_in;
      end
   end
   
   always @(hps_io_sdio_inst_D1_in) begin
      if (hps_io_sdio_inst_D1_oe == 0) begin
         if (hps_io_sdio_inst_D1_local != hps_io_sdio_inst_D1_in)
            -> signal_input_hps_io_sdio_inst_D1_change;
         hps_io_sdio_inst_D1_local = hps_io_sdio_inst_D1_in;
      end
   end
   
   always @(hps_io_sdio_inst_D2_in) begin
      if (hps_io_sdio_inst_D2_oe == 0) begin
         if (hps_io_sdio_inst_D2_local != hps_io_sdio_inst_D2_in)
            -> signal_input_hps_io_sdio_inst_D2_change;
         hps_io_sdio_inst_D2_local = hps_io_sdio_inst_D2_in;
      end
   end
   
   always @(hps_io_sdio_inst_D3_in) begin
      if (hps_io_sdio_inst_D3_oe == 0) begin
         if (hps_io_sdio_inst_D3_local != hps_io_sdio_inst_D3_in)
            -> signal_input_hps_io_sdio_inst_D3_change;
         hps_io_sdio_inst_D3_local = hps_io_sdio_inst_D3_in;
      end
   end
   
   always @(hps_io_usb1_inst_D0_in) begin
      if (hps_io_usb1_inst_D0_oe == 0) begin
         if (hps_io_usb1_inst_D0_local != hps_io_usb1_inst_D0_in)
            -> signal_input_hps_io_usb1_inst_D0_change;
         hps_io_usb1_inst_D0_local = hps_io_usb1_inst_D0_in;
      end
   end
   
   always @(hps_io_usb1_inst_D1_in) begin
      if (hps_io_usb1_inst_D1_oe == 0) begin
         if (hps_io_usb1_inst_D1_local != hps_io_usb1_inst_D1_in)
            -> signal_input_hps_io_usb1_inst_D1_change;
         hps_io_usb1_inst_D1_local = hps_io_usb1_inst_D1_in;
      end
   end
   
   always @(hps_io_usb1_inst_D2_in) begin
      if (hps_io_usb1_inst_D2_oe == 0) begin
         if (hps_io_usb1_inst_D2_local != hps_io_usb1_inst_D2_in)
            -> signal_input_hps_io_usb1_inst_D2_change;
         hps_io_usb1_inst_D2_local = hps_io_usb1_inst_D2_in;
      end
   end
   
   always @(hps_io_usb1_inst_D3_in) begin
      if (hps_io_usb1_inst_D3_oe == 0) begin
         if (hps_io_usb1_inst_D3_local != hps_io_usb1_inst_D3_in)
            -> signal_input_hps_io_usb1_inst_D3_change;
         hps_io_usb1_inst_D3_local = hps_io_usb1_inst_D3_in;
      end
   end
   
   always @(hps_io_usb1_inst_D4_in) begin
      if (hps_io_usb1_inst_D4_oe == 0) begin
         if (hps_io_usb1_inst_D4_local != hps_io_usb1_inst_D4_in)
            -> signal_input_hps_io_usb1_inst_D4_change;
         hps_io_usb1_inst_D4_local = hps_io_usb1_inst_D4_in;
      end
   end
   
   always @(hps_io_usb1_inst_D5_in) begin
      if (hps_io_usb1_inst_D5_oe == 0) begin
         if (hps_io_usb1_inst_D5_local != hps_io_usb1_inst_D5_in)
            -> signal_input_hps_io_usb1_inst_D5_change;
         hps_io_usb1_inst_D5_local = hps_io_usb1_inst_D5_in;
      end
   end
   
   always @(hps_io_usb1_inst_D6_in) begin
      if (hps_io_usb1_inst_D6_oe == 0) begin
         if (hps_io_usb1_inst_D6_local != hps_io_usb1_inst_D6_in)
            -> signal_input_hps_io_usb1_inst_D6_change;
         hps_io_usb1_inst_D6_local = hps_io_usb1_inst_D6_in;
      end
   end
   
   always @(hps_io_usb1_inst_D7_in) begin
      if (hps_io_usb1_inst_D7_oe == 0) begin
         if (hps_io_usb1_inst_D7_local != hps_io_usb1_inst_D7_in)
            -> signal_input_hps_io_usb1_inst_D7_change;
         hps_io_usb1_inst_D7_local = hps_io_usb1_inst_D7_in;
      end
   end
   
   always @(hps_io_usb1_inst_CLK_in) begin
      if (hps_io_usb1_inst_CLK_local != hps_io_usb1_inst_CLK_in)
         -> signal_input_hps_io_usb1_inst_CLK_change;
      hps_io_usb1_inst_CLK_local = hps_io_usb1_inst_CLK_in;
   end
   
   always @(hps_io_usb1_inst_DIR_in) begin
      if (hps_io_usb1_inst_DIR_local != hps_io_usb1_inst_DIR_in)
         -> signal_input_hps_io_usb1_inst_DIR_change;
      hps_io_usb1_inst_DIR_local = hps_io_usb1_inst_DIR_in;
   end
   
   always @(hps_io_usb1_inst_NXT_in) begin
      if (hps_io_usb1_inst_NXT_local != hps_io_usb1_inst_NXT_in)
         -> signal_input_hps_io_usb1_inst_NXT_change;
      hps_io_usb1_inst_NXT_local = hps_io_usb1_inst_NXT_in;
   end
   
   always @(hps_io_spim0_inst_MISO_in) begin
      if (hps_io_spim0_inst_MISO_local != hps_io_spim0_inst_MISO_in)
         -> signal_input_hps_io_spim0_inst_MISO_change;
      hps_io_spim0_inst_MISO_local = hps_io_spim0_inst_MISO_in;
   end
   
   always @(hps_io_spim1_inst_MISO_in) begin
      if (hps_io_spim1_inst_MISO_local != hps_io_spim1_inst_MISO_in)
         -> signal_input_hps_io_spim1_inst_MISO_change;
      hps_io_spim1_inst_MISO_local = hps_io_spim1_inst_MISO_in;
   end
   
   always @(hps_io_uart0_inst_RX_in) begin
      if (hps_io_uart0_inst_RX_local != hps_io_uart0_inst_RX_in)
         -> signal_input_hps_io_uart0_inst_RX_change;
      hps_io_uart0_inst_RX_local = hps_io_uart0_inst_RX_in;
   end
   
   always @(hps_io_i2c1_inst_SDA_in) begin
      if (hps_io_i2c1_inst_SDA_oe == 0) begin
         if (hps_io_i2c1_inst_SDA_local != hps_io_i2c1_inst_SDA_in)
            -> signal_input_hps_io_i2c1_inst_SDA_change;
         hps_io_i2c1_inst_SDA_local = hps_io_i2c1_inst_SDA_in;
      end
   end
   
   always @(hps_io_i2c1_inst_SCL_in) begin
      if (hps_io_i2c1_inst_SCL_oe == 0) begin
         if (hps_io_i2c1_inst_SCL_local != hps_io_i2c1_inst_SCL_in)
            -> signal_input_hps_io_i2c1_inst_SCL_change;
         hps_io_i2c1_inst_SCL_local = hps_io_i2c1_inst_SCL_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO00_in) begin
      if (hps_io_gpio_inst_GPIO00_oe == 0) begin
         if (hps_io_gpio_inst_GPIO00_local != hps_io_gpio_inst_GPIO00_in)
            -> signal_input_hps_io_gpio_inst_GPIO00_change;
         hps_io_gpio_inst_GPIO00_local = hps_io_gpio_inst_GPIO00_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO09_in) begin
      if (hps_io_gpio_inst_GPIO09_oe == 0) begin
         if (hps_io_gpio_inst_GPIO09_local != hps_io_gpio_inst_GPIO09_in)
            -> signal_input_hps_io_gpio_inst_GPIO09_change;
         hps_io_gpio_inst_GPIO09_local = hps_io_gpio_inst_GPIO09_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO35_in) begin
      if (hps_io_gpio_inst_GPIO35_oe == 0) begin
         if (hps_io_gpio_inst_GPIO35_local != hps_io_gpio_inst_GPIO35_in)
            -> signal_input_hps_io_gpio_inst_GPIO35_change;
         hps_io_gpio_inst_GPIO35_local = hps_io_gpio_inst_GPIO35_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO40_in) begin
      if (hps_io_gpio_inst_GPIO40_oe == 0) begin
         if (hps_io_gpio_inst_GPIO40_local != hps_io_gpio_inst_GPIO40_in)
            -> signal_input_hps_io_gpio_inst_GPIO40_change;
         hps_io_gpio_inst_GPIO40_local = hps_io_gpio_inst_GPIO40_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO48_in) begin
      if (hps_io_gpio_inst_GPIO48_oe == 0) begin
         if (hps_io_gpio_inst_GPIO48_local != hps_io_gpio_inst_GPIO48_in)
            -> signal_input_hps_io_gpio_inst_GPIO48_change;
         hps_io_gpio_inst_GPIO48_local = hps_io_gpio_inst_GPIO48_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO53_in) begin
      if (hps_io_gpio_inst_GPIO53_oe == 0) begin
         if (hps_io_gpio_inst_GPIO53_local != hps_io_gpio_inst_GPIO53_in)
            -> signal_input_hps_io_gpio_inst_GPIO53_change;
         hps_io_gpio_inst_GPIO53_local = hps_io_gpio_inst_GPIO53_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO54_in) begin
      if (hps_io_gpio_inst_GPIO54_oe == 0) begin
         if (hps_io_gpio_inst_GPIO54_local != hps_io_gpio_inst_GPIO54_in)
            -> signal_input_hps_io_gpio_inst_GPIO54_change;
         hps_io_gpio_inst_GPIO54_local = hps_io_gpio_inst_GPIO54_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO55_in) begin
      if (hps_io_gpio_inst_GPIO55_oe == 0) begin
         if (hps_io_gpio_inst_GPIO55_local != hps_io_gpio_inst_GPIO55_in)
            -> signal_input_hps_io_gpio_inst_GPIO55_change;
         hps_io_gpio_inst_GPIO55_local = hps_io_gpio_inst_GPIO55_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO56_in) begin
      if (hps_io_gpio_inst_GPIO56_oe == 0) begin
         if (hps_io_gpio_inst_GPIO56_local != hps_io_gpio_inst_GPIO56_in)
            -> signal_input_hps_io_gpio_inst_GPIO56_change;
         hps_io_gpio_inst_GPIO56_local = hps_io_gpio_inst_GPIO56_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO61_in) begin
      if (hps_io_gpio_inst_GPIO61_oe == 0) begin
         if (hps_io_gpio_inst_GPIO61_local != hps_io_gpio_inst_GPIO61_in)
            -> signal_input_hps_io_gpio_inst_GPIO61_change;
         hps_io_gpio_inst_GPIO61_local = hps_io_gpio_inst_GPIO61_in;
      end
   end
   
   always @(hps_io_gpio_inst_GPIO62_in) begin
      if (hps_io_gpio_inst_GPIO62_oe == 0) begin
         if (hps_io_gpio_inst_GPIO62_local != hps_io_gpio_inst_GPIO62_in)
            -> signal_input_hps_io_gpio_inst_GPIO62_change;
         hps_io_gpio_inst_GPIO62_local = hps_io_gpio_inst_GPIO62_in;
      end
   end
   


// synthesis translate_on

endmodule

