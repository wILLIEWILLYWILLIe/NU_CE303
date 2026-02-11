`timescale 1ns/1ps

module tb_Vredge;
    reg clk  = 0;
    reg rst_n = 0;
    reg X = 0;
    wire EDGE;
    wire [1:0] state_dbg;

    Vredge dut (
        .clk(clk),
        .rst_n(rst_n),
        .X(X),
        .EDGE(EDGE),
        .state_dbg(state_dbg)
    );

    // 10-ns clock
    always #5 clk = ~clk;

    initial begin
        repeat (2) @(posedge clk);
        rst_n <= 1'b1;

        repeat (2) @(posedge clk);
        X <= 0;

        @(negedge clk); X <= 1;   // 0->1 edge
        @(negedge clk); X <= 1;   // hold
        @(negedge clk); X <= 0;   // 1->0 edge
        @(negedge clk); X <= 0;   // hold
        @(negedge clk); X <= 1;   // 0->1 edge
        @(negedge clk); X <= 0;   // 1->0 edge (back-to-back)
        @(negedge clk); X <= 1;   // 0->1 edge (back-to-back)
        @(negedge clk); X <= 1;   // hold

        // Randomized stress test
        repeat (10) begin
            @(negedge clk);
            X <= $random;
        end

        repeat (3) @(posedge clk);
        $finish;
    end

endmodule
