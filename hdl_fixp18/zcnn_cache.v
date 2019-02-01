//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_cache
(/*AUTOARG*/
// Outputs
rd_out, cache_end_tgl, write_end_tgl, mem_write, mem_address,
mem_writedata, mem_burstcount, buffer_empty,
// Inputs
resb, clk, wvp_in, wen_in, wd_in, rvp_in, ren_in, write_cache_on,
write_start, write_address, write_size, write_mem_size, mem_clk,
mem_waitrequest
);

input wire          resb;
input wire          clk;
input wire          wvp_in;
input wire          wen_in;
input wire [17:0]   wd_in;
input wire          rvp_in;
input wire          ren_in;
output wire [17:0]  rd_out;

input wire          write_cache_on;
input wire          write_start;
input wire [31:0]   write_address;
input wire [31:0]   write_size;
input wire [31:0]   write_mem_size;
output wire         cache_end_tgl;
output wire         write_end_tgl;

input wire          mem_clk;
output wire         mem_write;
output wire [25:0]  mem_address;
output wire [127:0] mem_writedata;
input wire          mem_waitrequest;
output wire [7:0]   mem_burstcount;

output wire         buffer_empty;

localparam CACHE_WIDTH = 14;
localparam PACK = 7 -1;

reg                    wen0;
reg                    wen1;
reg                    wen2;
reg [23:0]             wcnt;
reg [CACHE_WIDTH-1:0]  wadr;
reg [2:0]              pwcnt;
reg [125:0]            wdat;

reg                    ren0;
reg                    ren1;
reg                    ren2;
reg [CACHE_WIDTH-1:0]  radr;
reg [2:0]              prcnt;
reg [125:0]            rd_q;
wire [125:0]           q0;
wire [125:0]           q1;
wire [125:0]           q2;

reg [CACHE_WIDTH-1:0]  xadr;

reg                    men;
reg                    mend;
reg                    xen;
reg                    cache_on_d;
reg                    end_tgl;
reg [7:0]   write_start_delay;
reg [1:0]   cstat;
wire        fifo_wfull;

assign rd_out = rd_q[17:0];


wire [23:0] write_size_max = write_size[23:0] - 1;

assign cache_end_tgl = end_tgl;


wire [CACHE_WIDTH-1:0]  next_wadr;
assign next_wadr = wadr + 1;
wire [1:0] sel;
assign sel = wadr[CACHE_WIDTH-1:CACHE_WIDTH-2];

wire [CACHE_WIDTH-3:0]  wadr0;
wire [CACHE_WIDTH-3:0]  wadr1;
wire [CACHE_WIDTH-3:0]  wadr2;
assign  wadr0 = wadr[CACHE_WIDTH-3:0];
assign  wadr1 = wadr[CACHE_WIDTH-3:0];
assign  wadr2 = wadr[CACHE_WIDTH-3:0];

wire [CACHE_WIDTH-3:0]  radr0;
wire [CACHE_WIDTH-3:0]  radr1;
wire [CACHE_WIDTH-3:0]  radr2;
assign  radr0 = radr[CACHE_WIDTH-3:0];
assign  radr1 = radr[CACHE_WIDTH-3:0];
assign  radr2 = radr[CACHE_WIDTH-3:0];

always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        wen0       <= 0;
        wen1       <= 0;
        wen2       <= 0;
        wadr       <= 0;
        pwcnt      <= 0;
        wdat       <= 0;
        radr       <= 0;
        rd_q       <= 0;
        prcnt      <= 0;
        cache_on_d <= 0;
        end_tgl    <= 0;
        ren0       <= 0;
        ren1       <= 0;
        ren2       <= 0;
    end
    else begin
        cache_on_d <= write_cache_on;

        if (wvp_in) begin
            wadr  <= 0;
            pwcnt <= 0;
            wcnt  <= 0;
            wen0  <= 0;
            wen1  <= 0;
            wen2  <= 0;
        end
        else if (wen_in && cache_on_d) begin
            if (pwcnt==PACK) begin
                pwcnt <= 0;
            end
            else begin
                pwcnt <= pwcnt + 1;
            end

            if (wen0|wen1|wen2) begin
                wadr <= next_wadr;
            end

            case (pwcnt)
                0 : wdat [18+18*0-1:18*0] <= wd_in;
                1 : wdat [18+18*1-1:18*1] <= wd_in;
                2 : wdat [18+18*2-1:18*2] <= wd_in;
                3 : wdat [18+18*3-1:18*3] <= wd_in;
                4 : wdat [18+18*4-1:18*4] <= wd_in;
                5 : wdat [18+18*5-1:18*5] <= wd_in;
                default : wdat [18+18*6-1:18*6] <= wd_in;
            endcase

            if (wcnt>=write_size_max) begin
                wcnt    <= 0;
                end_tgl <= ~end_tgl;
            end
            else begin
                wcnt <= wcnt + 1;
            end

            wen0 <= (sel==0) && wen_in && ((pwcnt==PACK) || wcnt>=write_size_max);
            wen1 <= (sel==1) && wen_in && ((pwcnt==PACK) || wcnt>=write_size_max);
            wen2 <= (sel==2) && wen_in && ((pwcnt==PACK) || wcnt>=write_size_max);

        end // if (wen_in)
        else begin
            wen0 <= 0;
            wen1 <= 0;
            wen2 <= 0;

            if (wen0|wen1|wen2) begin
                wadr <= next_wadr;
            end

        end

        if (rvp_in || (cstat==0 && write_start_delay[7])) begin
            radr  <= 0;
            prcnt <= 0;
        end
        else if (ren_in) begin
            if (prcnt==PACK) begin
                prcnt <= 0;
            end
            else begin
                prcnt <= prcnt + 1;
            end

            if (prcnt==0) begin
                radr <= radr + 1;
            end
        end // if (ren_in)
        else if (cstat==1 && ~fifo_wfull) begin
            radr <= radr + 1;
        end // if (ren_in)

        if (ren_in && prcnt==0) begin
            rd_q <= (q0 & ({126{ren0}})) |
                    (q1 & ({126{ren1}})) |
                    (q2 & ({126{ren2}})) |
                    0;
        end
        else begin
            rd_q <= {18'd0,rd_q[125:18]};
        end

        ren0 <= (radr[CACHE_WIDTH-1:CACHE_WIDTH-2]==0);
        ren1 <= (radr[CACHE_WIDTH-1:CACHE_WIDTH-2]==1);
        ren2 <= (radr[CACHE_WIDTH-1:CACHE_WIDTH-2]==2);

    end
end // always @ (posedge clk or negedge resb)

cache_126x4096 c_cache0(
                        .clock     (clk),
                        .data      (wdat),
                        .rdaddress (radr0),
                        .wraddress (wadr0),
                        .wren      (wen0),
                        .q         (q0)
                        );
cache_126x4096 c_cache1(
                        .clock     (clk),
                        .data      (wdat),
                        .rdaddress (radr1),
                        .wraddress (wadr1),
                        .wren      (wen1),
                        .q         (q1)
                        );
cache_126x4096 c_cache2(
                        .clock     (clk),
                        .data      (wdat),
                        .rdaddress (radr2),
                        .wraddress (wadr2),
                        .wren      (wen2),
                        .q         (q2)
                        );

wire [31:0] write_mem_size_rem;
wire [31:0] write_mem_size_max;
reg [31:0]  write_mem_size_max_a;
reg         wend_tgl;
reg [127:0] mif_wdat;

assign write_mem_size_rem = (write_mem_size[3:0]==0) ? 0 : 16 - write_mem_size[3:0];
assign write_mem_size_max = write_mem_size - 1 + write_mem_size_rem;

always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        write_start_delay <= 0;
        wend_tgl          <= 0;
        cstat             <= 0;
        xen               <= 0;
        xadr              <= 0;
        men               <= 0;
        mend              <= 0;
        mif_wdat          <= 0;
    end
    else begin
        write_mem_size_max_a <= write_mem_size_max;
        write_start_delay    <= {write_start_delay[6:0] , write_start};
        mend                 <= xen & (~fifo_wfull);
        men                  <= mend;
        if (mend) begin
            mif_wdat <= (ren0) ? {2'd0,q0} :
                        (ren1) ? {2'd0,q1} :
                        (ren2) ? {2'd0,q2} : 0;
        end
            
        case (cstat)
            0 : begin
                if (write_start_delay[7]) begin
                    cstat <= 1;
                    xadr <= 0;
                    xen <= 1;
                end
            end
            1: begin
                if (!fifo_wfull) begin
//                    if (xadr==write_mem_size_max) begin
                    if (xadr==write_mem_size_max_a[CACHE_WIDTH-1:0]) begin
                        cstat    <= 2;
                        xen      <= 0;
                        wend_tgl <= ~wend_tgl;
                    end
                    else begin
                        xadr <= xadr + 1;
                        xen  <= 1;
                    end
                end // if (!fifo_wfull)
            end
            2: begin
                if (!write_start_delay[7]) begin
                    cstat <= 0;
                end
            end
            default: begin
                cstat <= 0;
                xen   <= 0;
                xadr  <= 0;
            end
        endcase
    end
end
assign write_end_tgl = wend_tgl;


/*zcnn_write_mif_core AUTO_TEMPLATE(
 .wen    (men),
 .wdat   (mif_wdat[]),
 );
 */
zcnn_write_mif_core mif_core
(/*AUTOINST*/
 // Outputs
 .fifo_wfull                            (fifo_wfull),
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
 .wen                                   (men),                   // Templated
 .wdat                                  (mif_wdat[127:0]),       // Templated
 .mem_clk                               (mem_clk),
 .mem_waitrequest                       (mem_waitrequest));

endmodule // zcnn_cache
//synopsys translate_off
`default_nettype wire
//synopsys translate_on
