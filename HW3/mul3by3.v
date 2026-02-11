`timescale 1ns/1ps

module mul3by3(A, B, Cout);
    input [2:0] A, B;
    output [5:0] Cout;

    wire [2:0] p0 = A&{3{B[0]}};
    wire [2:0] p1 = A&{3{B[1]}};
    wire [2:0] p2 = A&{3{B[2]}};

    wire [5:0] p0_ext = {3'b000,          p0        }; 
    wire [5:0] p1_ext = {2'b00,  p1,     1'b0       }; 
    wire [5:0] p2_ext = {1'b0,   p2,     2'b00      }; 

    assign Cout = p0_ext + p1_ext + p2_ext;

endmodule

