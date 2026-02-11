`timescale 1ns/1ps
module tb_alu;
    reg [7:0] A, B;
    reg [2:0] F;
    wire [7:0] Q;
    wire Cout;

    alu8 dut(.A(A), .B(B), .F(F), .Q(Q), .Cout(Cout));

    integer A_1 = 3;
    integer B_1 = 4;
    integer A_2 = 250;
    integer B_2 = 12;
    integer A_3 = 30;
    integer B_3 = 176;

    integer f_case; 
    integer cfg;    
    initial begin
        for (cfg = 1; cfg <= 3; cfg = cfg + 1) begin
            case (cfg)
                1: begin A = A_1; B = B_1; end
                2: begin A = A_2; B = B_2; end
                3: begin A = A_3; B = B_3; end
            endcase
            for (f_case = 0; f_case < 8; f_case = f_case + 1) begin
                F = f_case[2:0];
                #0.5; 
                $display("Cfg %0d | F=%03b | A=%3d (0x%02h) | B=%3d (0x%02h) | Q=%3d (0x%02h) | Cout=%b",
                          cfg, F, A, A, B, B, Q, Q, Cout);
                #0.5; 
            end
        end
        #10 $finish;
    end
endmodule
