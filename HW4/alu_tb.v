`timescale 1ns/1ps
module tb_alu;
    reg [7:0] A, B;
    reg [2:0] F;

    wire [7:0] Q;
    wire Cout;
    alu8 dut(.A(A), .B(B), .F(F), .Q(Q), .Cout(Cout));

    task run_test(input [7:0] a, input [7:0] b, input [2:0] f);
    begin
        A = a;
        B = b;
        F = f;
        #1
        $display("Case: [%3b] => Q: %8b(%d), Cout: %b",
         F, Q, Q, Cout);        
    end
    endtask

    integer F_case;
    integer A_1 = 3;
    integer B_1 = 4;
    integer A_2 = 250;
    integer B_2 = 12;
    integer A_3 = 30;
    integer B_3 = 176;

    initial begin
        for (F_case = 0; F_case<=7; F_case=F_case+1)
            run_test(
                A_2, B_2, F_case
            );
    end
endmodule

