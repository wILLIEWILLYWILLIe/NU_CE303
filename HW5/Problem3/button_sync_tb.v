`timescale 1ns/1ps
module button_sync_tb;

    reg clk;
    reg rst_n;
    reg b_i;
    wire b_o;

    button_sync dut (
        .clk  (clk),
        .rst_n(rst_n),
        .b_i  (b_i),
        .b_o  (b_o)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;   // 5ns high, 5ns low
    end

    initial begin
        rst_n = 1'b0;
        b_i   = 1'b0;
        #20;
        rst_n = 1'b1;
        #7  b_i = 1'b1;  
        #30 b_i = 1'b0;  
        #20;
        #3  b_i = 1'b1;
        #50 b_i = 1'b0;

        #15 b_i = 1'b1;
        #10 b_i = 1'b0;

        #30;
        $finish;
    end

    integer cycle = 0;
    always @(posedge clk) begin
        cycle = cycle + 1;
        $display("T=%0t ns, cycle=%0d, b_i=%b, b_o=%b",
                 $time, cycle, b_i, b_o);
    end

endmodule
