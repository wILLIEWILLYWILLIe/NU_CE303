`timescale 1ns/1ps
module tb_mul3by3;
    reg  [2:0] A, B;
    wire [5:0] Cout;

    mul3by3 dut(.A(A), .B(B), .Cout(Cout));

    task run_case(input [2:0] a, input [2:0] b);
    begin
        A = a; B = b; #1;
        if (Cout !== a*b) begin
            $display("FAIL  A=%0d B=%0d  C=%0d (expected %0d)", a, b, Cout, a*b);
        end else begin
            $display("PASS  A=%0d B=%0d  C=%0d", a, b, Cout);
        end
    end
    endtask

    integer i;
    initial begin
        // A = 5, B = 0..7
        for (i = 0; i < 8; i = i + 1) run_case(3'd5, i[2:0]);
        // B = 2, A = 0..7
        for (i = 0; i < 8; i = i + 1) run_case(i[2:0], 3'd2);
        $finish;
    end
endmodule
