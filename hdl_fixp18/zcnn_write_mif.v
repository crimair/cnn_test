//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_write_mif
(/*AUTOARG*/
// Outputs
write_end_tgl, mem_write, mem_address, mem_writedata, mem_burstcount,
buffer_empty, buffer_full,
// Inputs
resb, clk, write_start, write_address, write_size, en_in, d_in,
mem_clk, mem_waitrequest
);

input wire          resb;
input wire          clk;
input wire          write_start;
input wire [31:0]   write_address;
input wire [31:0]   write_size;
output wire         write_end_tgl;
input wire          en_in;
input wire [17:0]   d_in;
input wire          mem_clk;
output wire         mem_write;
output wire [25:0]  mem_address;
output wire [127:0] mem_writedata;
input wire          mem_waitrequest;
output wire [7:0]   mem_burstcount;

output wire         buffer_empty;
output wire         buffer_full;

localparam PACK = 7 -1;
localparam burst_length = 16;

reg [2:0]   write_start_d;
reg [1:0]   wstat;
reg [23:0]  wcnt;
reg [3:0]   wbcnt;
reg [2:0]   wpack;
reg         wpack_en;
reg [127:0] wpack_data;
reg         wend_tgl;
reg         wbusy;

localparam IDLE     = 0;
localparam WRITE    = 1;
localparam PRE_WEND = 2;
localparam WEND     = 3;

wire [23:0] wcnt_max;
assign wcnt_max = write_size[23:0] - 1;

always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        write_start_d <= 0;
        wstat         <= IDLE;
        wcnt          <= 0;
        wbcnt         <= 0;
        wpack         <= 0;
        wpack_en      <= 0;
        wpack_data    <= 0;
        wend_tgl      <= 0;
        wbusy         <= 0;
    end // if (!resb)
    else begin
        write_start_d <= {write_start_d[1:0] , write_start};
        wbusy         <= (wstat!=IDLE);

        case (wstat)
            IDLE : begin
                if (write_start_d[2:1]==1) begin
                    wstat <= WRITE;
                    wcnt  <= 0;
                    wbcnt <= 0;
                end
                wpack      <= 0;
                wpack_en   <= 0;
                wpack_data <= 0;
            end
            WRITE : begin
                if (en_in) begin
                    if (wcnt>=wcnt_max) begin
                        if (wbcnt==burst_length-1) begin
                            wstat <= WEND;
                        end
                        else begin
                            wstat <= PRE_WEND;
                        end
                        wcnt <= 0;
                    end
                    else begin
                        wcnt <= wcnt + 1;
                    end // else: !if(wcnt>=wcnt_max)

//                    if (wpack==PACK || (wcnt>=wcnt_max)) begin
                    if (wpack==PACK) begin
                        wpack    <= 0;
                        wpack_en <= 1;
                        if (wbcnt==burst_length-1) begin
                            wbcnt <= 0;
                        end
                        else begin
                            wbcnt <= wbcnt + 1;
                        end
                    end
                    else begin
                        wpack    <= wpack + 1;
                        wpack_en <= 0;
                    end

                    case (wpack)
                        0 : wpack_data [18+18*0-1:18*0] <= d_in;
                        1 : wpack_data [18+18*1-1:18*1] <= d_in;
                        2 : wpack_data [18+18*2-1:18*2] <= d_in;
                        3 : wpack_data [18+18*3-1:18*3] <= d_in;
                        4 : wpack_data [18+18*4-1:18*4] <= d_in;
                        5 : wpack_data [18+18*5-1:18*5] <= d_in;
                        default : wpack_data [18+18*6-1:18*6] <= d_in;
                    endcase // case (wpack)

                end // if (en_in)
                else begin
                    wpack_en   <= 0;
                end // else: !if(en_in)
            end // case: WRITE
            PRE_WEND : begin
                if ((wpack==PACK) && (wbcnt==burst_length-1)) begin
                    wstat <= WEND;
                end
                else begin
                    wstat <= PRE_WEND;
                end

                if (wpack==PACK) begin
                    wpack    <= 0;
                    wpack_en <= 1;
                    if (wbcnt==burst_length-1) begin
                        wbcnt <= 0;
                    end
                    else begin
                        wbcnt <= wbcnt + 1;
                    end
                end
                else begin
                    wpack    <= wpack + 1;
                    wpack_en <= 0;
                end
            end // case: PRE_WEND
            WEND : begin
                wstat    <= IDLE;
                wcnt     <= 0;
                wbcnt    <= 0;
                wpack_en <= 0;
                wend_tgl <= ~wend_tgl ;
            end
            default : begin
                wstat      <= IDLE;
                wcnt       <= 0;
                wbcnt      <= 0;
                wpack      <= 0;
                wpack_en   <= 0;
                wpack_data <= 0;
            end
        endcase // case (wstat)
    end // else: !if(!resb)
end // always @ (posedge clk or negedge resb)
assign write_end_tgl = wend_tgl;

/*zcnn_write_mif_core AUTO_TEMPLATE(
 .fifo_wfull   (buffer_full),
 .wen          (wpack_en),
 .wdat         (wpack_data[]),
 );
 */

zcnn_write_mif_core mif_core
(/*AUTOINST*/
 // Outputs
 .fifo_wfull                            (buffer_full),           // Templated
 .mem_write                             (mem_write),
 .mem_address                           (mem_address[25:0]),
 .mem_writedata                         (mem_writedata[127:0]),
 .mem_burstcount                        (mem_burstcount[7:0]),
 .buffer_empty                          (buffer_empty),
 // Inputs
 .resb                                  (resb),
 .clk                                   (clk),
 .write_start                           (write_start),
 .write_address                         (write_address[31:0]),
 .wen                                   (wpack_en),              // Templated
 .wdat                                  (wpack_data[127:0]),     // Templated
 .mem_clk                               (mem_clk),
 .mem_waitrequest                       (mem_waitrequest));

endmodule // zcnn_write_mif
//synopsys translate_off
`default_nettype wire
//synopsys translate_on
