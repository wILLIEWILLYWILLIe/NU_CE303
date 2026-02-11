`timescale 1ns/1ps
`default_nettype none

module mac (
    input  wire               clk,
    input  wire               rstb,      
    input  wire signed [3:0]  IN,        
    input  wire signed [3:0]  W,         
    output reg  signed [11:0] OUT,       
    // debug ports
    output wire signed [11:0] add_result,
    output wire signed [7:0]  mult_result,
    output wire [3:0]         debug_cycle_cnt
);

    reg signed [3:0] in_reg;
    reg signed [3:0] w_reg;

    reg signed [11:0] acc_reg;
    reg [3:0]         cycle_cnt;
    reg               valid;        // skip the first bogus product after reset

    wire signed [7:0]  mult_comb;
    wire signed [11:0] mult_extended;
    wire signed [11:0] next_sum;

    assign mult_comb     = in_reg * w_reg;                     
    assign mult_extended = { {4{mult_comb[7]}}, mult_comb };   

    // next_sum is the value that will be written into acc_reg
    // for the current cycle
    assign next_sum = (cycle_cnt == 4'd1) ?
                      mult_extended :                       // first product in window
                      (acc_reg + mult_extended);            // accumulate

    // debug usage
    assign mult_result   = mult_comb;                          
    assign add_result      = next_sum;       
    assign debug_cycle_cnt = cycle_cnt;      

    always @(posedge clk or negedge rstb) begin
        if (!rstb) begin
            in_reg     <= 4'sd0;
            w_reg      <= 4'sd0;
            acc_reg    <= 12'sd0;
            OUT        <= 12'sd0;
            cycle_cnt  <= 4'd0;
            valid      <= 1'b0;
        end
        else begin
            in_reg <= IN;
            w_reg  <= W;

            if (!valid) begin
                // first cycle after reset: enable MAC but DO NOT use product
                valid     <= 1'b1;
                acc_reg   <= 12'sd0;
                OUT       <= 12'sd0;
                cycle_cnt <= 4'd0;
            end
            else begin
                // main MAC operation 

                acc_reg <= next_sum;
                if (cycle_cnt == 4'd8) begin
                    // OUT       <= next_sum;
                    cycle_cnt <= 4'd0;
                end
                else if (cycle_cnt == 4'd1) begin
                    OUT       <= acc_reg;
                    cycle_cnt <= cycle_cnt + 4'd1;
                end
                else begin
                    cycle_cnt <= cycle_cnt + 4'd1;
                end
            end
        end
    end

endmodule

`default_nettype wire
