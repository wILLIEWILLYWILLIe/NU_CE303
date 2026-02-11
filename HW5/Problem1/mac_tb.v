`timescale 1ns/1ps
`default_nettype none

module mac_tb;
    reg                 clk;
    reg                 rstb;
    reg  signed [3:0]   IN;
    reg  signed [3:0]   W;
    wire signed [11:0]  OUT;

    // debug usage
    wire signed [11:0]  add_result;
    wire signed [7:0]   mult_result;
    wire [3:0]          debug_cycle_cnt;

    // Instantiate DUT
    mac u_mac (
        .clk (clk),
        .rstb(rstb),
        .IN  (IN),
        .W   (W),
        .OUT (OUT),
        .add_result(add_result),
        .mult_result(mult_result),
        .debug_cycle_cnt(debug_cycle_cnt)
    );

    // 1 GHz clock: period = 1ns
    initial begin
        clk = 1'b1;
        forever #0.5 clk = ~clk;
    end

    // --------------------------------------------------------------------
    // Ideal MAC model: same 9-sample window behavior as RTL
    // OUT_ideal always shows the previous window sum
    // --------------------------------------------------------------------
    reg signed [11:0] ideal_acc;     // accumulator for current window
    reg signed [11:0] ideal_out;     // result of previous window
    reg [3:0]         ideal_cnt;     // 0..8
    reg               ideal_started; // skip the first bogus product

    wire signed [7:0]  ideal_mult;
    wire signed [11:0] ideal_mult_ext;
    wire signed [11:0] ideal_next_sum;

    // multiplier using current IN and W (no pipeline)
    assign ideal_mult     = $signed(IN) * $signed(W);
    assign ideal_mult_ext = { {4{ideal_mult[7]}}, ideal_mult };

    // same accumulation rule as RTL:
    //   first valid product of a window: overwrite
    //   remaining products: accumulate
    assign ideal_next_sum = (ideal_cnt == 4'd0) ?
                            ideal_mult_ext :
                            (ideal_acc + ideal_mult_ext);

    always @(posedge clk or negedge rstb) begin
        if (!rstb) begin
            ideal_acc     <= 12'sd0;
            ideal_out     <= 12'sd0;
            ideal_cnt     <= 4'd0;
            ideal_started <= 1'b0;
        end
        else begin
            if (!ideal_started) begin
                // skip the first product after reset to align with RTL "valid" behavior
                ideal_started <= 1'b1;
                ideal_acc     <= 12'sd0;
                ideal_out     <= 12'sd0;
                ideal_cnt     <= 4'd0;
            end
            else begin
                // update accumulator for current window
                ideal_acc <= ideal_next_sum;

                if (ideal_cnt == 4'd8) begin
                    // at the 9th product, latch the window sum
                    ideal_out <= ideal_next_sum;
                    ideal_cnt <= 4'd0;
                end
                else begin
                    ideal_cnt <= ideal_cnt + 4'd1;
                end
            end
        end
    end

    integer i;

    // Stimulus
    initial begin
        rstb = 1'b0;
        IN   = 4'sd0;
        W    = 4'sd0;

        #2.0;
        rstb = 1'b1;

        for (i = 0; i < 20; i = i + 1) begin
            @(posedge clk);
            IN <= $random + 1;  // only take the lowest 4 bits
            W  <= $random;

            // prevent all 0s   
            if (IN == 4'sd0 && W == 4'sd0) begin
                IN <= 4'sd1;
            end
        end

        repeat (5) @(posedge clk);

        $finish;
    end

    // display the result
    initial begin
        $display("time  clk rstb   IN   W    OUT_MAC  OUT_ideal  cnt_ideal add_result mult_result debug_cycle_cnt");
        $monitor("%4t   %b   %b   %4d %4d   %5d     %5d       %1d       %5d       %5d       %1d",
                 $time, clk, rstb, IN, W,
                 OUT, ideal_out, ideal_cnt,
                 add_result, mult_result, debug_cycle_cnt);
    end

endmodule

`default_nettype wire
