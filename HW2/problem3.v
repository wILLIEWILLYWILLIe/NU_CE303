`timescale 1ns/1ps

module decoder_2to4(I, POL, Y);
    input [1:0] I;     // 2-bit input
    input POL;         // polarity control
    output [3:0] Y;    // 4-bit output

    wire [1:0] inv_I;
    wire [3:0] and_out;

    assign inv_I = ~I;
    assign and_out[0] = inv_I[0] & inv_I[1] ;
    assign and_out[1] = I[0] & inv_I[1];
    assign and_out[2] = inv_I[0] & I[1];
    assign and_out[3] = I[0] & I[1];

    assign Y = and_out ^ {4{~POL}};
endmodule
