//==============================================================
// tb_vredge_check.v — self-checking testbench for registered EDGE
// Verifies: EDGE == (X_prev ^ X_prev2)
//==============================================================
`timescale 1ns/1ps

module tb_Vredge_check;
    reg  clk   = 0;
    reg  rst_n = 0;
    reg  X     = 0;
    wire EDGE;

    Vredge dut (.clk(clk), .rst_n(rst_n), .X(X), .EDGE(EDGE));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("Vredge_check.vcd");
        $dumpvars(0, tb_Vredge_check);
    end

    // Store last two X values
    reg X_d1, X_d2;
    integer pass_cnt = 0;
    integer fail_cnt = 0;
    integer sample_cnt = 0;

    // Judge: check one-cycle delayed relation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            X_d1 <= 0;
            X_d2 <= 0;
        end else begin
            sample_cnt = sample_cnt + 1;
            if (EDGE !== (X_d1 ^ X_d2)) begin
                fail_cnt = fail_cnt + 1;
                $display("[%0t] FAIL: X_d1=%0b X_d2=%0b expected EDGE=%0b got %0b",
                         $time, X_d1, X_d2, (X_d1 ^ X_d2), EDGE);
            end else begin
                pass_cnt = pass_cnt + 1;
            end
            // shift registers
            X_d2 <= X_d1;
            X_d1 <= X;
        end
    end

    // Reset sequence
    initial begin
        repeat (2) @(posedge clk);
        rst_n <= 1'b1;
    end

    // Drive X on negedge
    initial begin
        repeat (2) @(negedge clk); X <= 0;

        @(negedge clk); X <= 1;
        @(negedge clk); X <= 1;
        @(negedge clk); X <= 0;
        @(negedge clk); X <= 0;
        @(negedge clk); X <= 1;
        @(negedge clk); X <= 0;
        @(negedge clk); X <= 1;
        @(negedge clk); X <= 1;

        // Random stress
        repeat (40) begin
            @(negedge clk);
            X <= $urandom;
        end

        // Report summary
        repeat (3) @(posedge clk);
        $display("==== SELF-CHECK SUMMARY ====");
        $display("samples checked : %0d", sample_cnt);
        $display("pass            : %0d", pass_cnt);
        $display("fail            : %0d", fail_cnt);
        if (fail_cnt==0) $display("RESULT          : PASS");
        else             $display("RESULT          : FAIL");
        $finish;
    end
endmodule
