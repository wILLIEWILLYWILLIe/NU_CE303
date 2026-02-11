`timescale 1ns/1ps
module RCA4(A, B, Cin, S, Cout);
    input [3:0] A, B;
    input Cin;
    output [3:0] S;
    output Cout;

    wire [3:0] C;

    FA FA0(A[0], B[0], Cin, S[0], C[0]);
    FA FA1(A[1], B[1], C[0], S[1], C[1]);
    FA FA2(A[2], B[2], C[1], S[2], C[2]);
    FA FA3(A[3], B[3], C[2], S[3], C[3]);
    assign Cout = C[3];
endmodule