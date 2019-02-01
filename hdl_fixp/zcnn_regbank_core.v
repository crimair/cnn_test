//  Last Change:    2015/06/19 21:32:04 (matsukura)
//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_regbank_core
(/*AUTOARG*/
// Outputs
avl_waitrequest, avl_readdata, avl_readdatavalid, ctrlreg0, ctrlreg1,
ctrlreg2, ctrlreg3, xsize, ysize, w00, w01, w02, w10, w11, w12, w20,
w21, w22, bias,
// Inputs
resb, avl_clk, avl_write, avl_read, avl_cs, avl_address_l_dec,
avl_writedata, avl_byteenable, busy_status, com_ctrlreg1_0_clear_tgl,
ctrlreg0_0_clear_tgl, ctrlreg1_0_clear_tgl, ctrlreg1_1_clear_tgl
);

input wire         resb ;
input wire         avl_clk ;
input wire         avl_write;
input wire         avl_read;
input wire         avl_cs;
input wire [15:0]  avl_address_l_dec;
output wire        avl_waitrequest;
output wire [31:0] avl_readdata;
output wire        avl_readdatavalid;
input wire [31:0]  avl_writedata;
input wire [3:0]   avl_byteenable;

input wire busy_status;
input wire com_ctrlreg1_0_clear_tgl;
input wire ctrlreg0_0_clear_tgl;
input wire ctrlreg1_0_clear_tgl;
input wire ctrlreg1_1_clear_tgl;

output wire [31:0] ctrlreg0;
output wire [31:0] ctrlreg1;
output wire [31:0] ctrlreg2;
output wire [31:0] ctrlreg3;
output wire [31:0] xsize;
output wire [31:0] ysize;
output wire [31:0] w00;
output wire [31:0] w01;
output wire [31:0] w02;
output wire [31:0] w10;
output wire [31:0] w11;
output wire [31:0] w12;
output wire [31:0] w20;
output wire [31:0] w21;
output wire [31:0] w22;
output wire [31:0] bias;

parameter   REGX    = 16;
wire [31:0] reginit [0:REGX-1];
reg [31:0]  regd [0:REGX-1];
wire [31:0] regx [0:REGX-1];
reg [31:0]  readdata;
reg         readdatavalid;
reg         d_busy_status;
reg [2:0]   d_ctrlreg0_0_clear_tgl;
reg [2:0]   d_ctrlreg1_0_clear_tgl;
reg [2:0]   d_ctrlreg1_1_clear_tgl;
reg [2:0]   d_com_ctrlreg1_0_clear_tgl;

//read data assign
assign
reginit[ 0] = 0       ,         regx[ 0] = {regd[ 0][31:2],d_busy_status,regd[ 0][0]} ,
reginit[ 1] = 0       ,         regx[ 1] = regd[ 1]  ,
reginit[ 2] = 0       ,         regx[ 2] = regd[ 2]  ,
reginit[ 3] = 0       ,         regx[ 3] = regd[ 3]  ,
reginit[ 4] = 0       ,         regx[ 4] = regd[ 4]  ,
reginit[ 5] = 0       ,         regx[ 5] = regd[ 5]  ,
reginit[ 6] = 0       ,         regx[ 6] = regd[ 6]  ,
reginit[ 7] = 0       ,         regx[ 7] = regd[ 7]  ,
reginit[ 8] = 0       ,         regx[ 8] = regd[ 8]  ,
reginit[ 9] = 0       ,         regx[ 9] = regd[ 9]  ,
reginit[10] = 0       ,         regx[10] = regd[10]  ,
reginit[11] = 0       ,         regx[11] = regd[11]  ,
reginit[12] = 0       ,         regx[12] = regd[12]  ,
reginit[13] = 0       ,         regx[13] = regd[13]  ,
reginit[14] = 0       ,         regx[14] = regd[14]  ,
reginit[15] = 0       ,         regx[15] = regd[15];

wire [3:0] avl_address;
assign avl_address = (avl_address_l_dec[ 0]) ?  0:
                     (avl_address_l_dec[ 1]) ?  1:
                     (avl_address_l_dec[ 2]) ?  2:
                     (avl_address_l_dec[ 3]) ?  3:
                     (avl_address_l_dec[ 4]) ?  4:
                     (avl_address_l_dec[ 5]) ?  5:
                     (avl_address_l_dec[ 6]) ?  6:
                     (avl_address_l_dec[ 7]) ?  7:
                     (avl_address_l_dec[ 8]) ?  8:
                     (avl_address_l_dec[ 9]) ?  9:
                     (avl_address_l_dec[10]) ? 10:
                     (avl_address_l_dec[11]) ? 11:
                     (avl_address_l_dec[12]) ? 12:
                     (avl_address_l_dec[13]) ? 13:
                     (avl_address_l_dec[14]) ? 14:
                     (avl_address_l_dec[15]) ? 15:
                     0;

integer   i;
always @ (posedge avl_clk or negedge resb) begin
    if (!resb) begin
        for(i=0;i<REGX;i=i+1) begin
            regd[i] <= reginit[i];
        end
        readdata               <= 0;
        readdatavalid          <= 0;
        d_busy_status          <= 0;
        d_ctrlreg0_0_clear_tgl <= 0;
        d_ctrlreg1_0_clear_tgl <= 0;
        d_ctrlreg1_1_clear_tgl <= 0;
        d_com_ctrlreg1_0_clear_tgl <= 0;
    end
    else begin
        d_busy_status          <= busy_status;
        d_ctrlreg0_0_clear_tgl <= {d_ctrlreg0_0_clear_tgl[1:0] , ctrlreg0_0_clear_tgl};
        d_ctrlreg1_0_clear_tgl <= {d_ctrlreg1_0_clear_tgl[1:0] , ctrlreg1_0_clear_tgl};
        d_ctrlreg1_1_clear_tgl <= {d_ctrlreg1_1_clear_tgl[1:0] , ctrlreg1_1_clear_tgl};
        d_com_ctrlreg1_0_clear_tgl <= {d_com_ctrlreg1_0_clear_tgl[1:0] , com_ctrlreg1_0_clear_tgl};
        if (^d_ctrlreg0_0_clear_tgl[2:1]) begin regd[0][0] <= 0; end
        if ((^d_ctrlreg1_0_clear_tgl[2:1])||(^d_com_ctrlreg1_0_clear_tgl[2:1])) begin regd[1][0] <= 0; end
        if (^d_ctrlreg1_1_clear_tgl[2:1]) begin regd[1][1] <= 0; end

        if (avl_write && avl_cs) begin
            if (avl_byteenable[0]) begin
                regd[avl_address][ 7: 0]    <= avl_writedata[ 7: 0];
            end
            if (avl_byteenable[1]) begin
                regd[avl_address][15: 8]    <= avl_writedata[15: 8];
            end
            if (avl_byteenable[2]) begin
                regd[avl_address][23:16]    <= avl_writedata[23:16];
            end
            if (avl_byteenable[3]) begin
                regd[avl_address][31:24]    <= avl_writedata[31:24];
            end
        end // if (avl_write && avl_cs)

        if (avl_read && avl_cs) begin
            readdata      <= regx[avl_address];
            readdatavalid <= 1;
        end
        else begin
            readdatavalid <= 0;
            readdata      <= 0;
        end
    end // else: !if(!resb)
end // always @ (posedge avl_clk or negedge resb)
assign  avl_readdata = readdata;
assign  avl_readdatavalid = readdatavalid;
assign  avl_waitrequest = 0;

assign ctrlreg0  = regd[ 0];
assign ctrlreg1  = regd[ 1];
assign ctrlreg2  = regd[ 2];
assign ctrlreg3  = regd[ 3];
assign xsize     = regd[ 4];
assign ysize     = regd[ 5];
assign w00       = regd[ 6];
assign w01       = regd[ 7];
assign w02       = regd[ 8];
assign w10       = regd[ 9];
assign w11       = regd[10];
assign w12       = regd[11];
assign w20       = regd[12];
assign w21       = regd[13];
assign w22       = regd[14];
assign bias      = regd[15];

endmodule // zcnn_regbank_core
//synopsys translate_off
`default_nettype wire
//synopsys translate_on
