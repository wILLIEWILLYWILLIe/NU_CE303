`timescale 1ns/1ps

module FA(A, B, Cin, S, Cout);
    input A, B, Cin;
    output S, Cout;

    wire xorAB, andAB, andAC, andBC;

    assign xorAB = A ^ B;
    assign andAB = A & B;
    assign andAC = A & Cin;
    assign andBC = B & Cin;

    assign S = xorAB ^ Cin;
    assign Cout = andAB | andAC | andBC;

endmodule