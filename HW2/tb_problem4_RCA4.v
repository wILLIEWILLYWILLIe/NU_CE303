`timescale 1ns/1ps
module tb_RCA4;

  reg  [3:0] A, B;
  reg        Cin;
  wire [3:0] S;
  wire       Cout;

  RCA4 dut (.A(A),.B(B),.Cin(Cin),
    .S(S),.Cout(Cout));

  integer i;
  reg [3:0] A_vec [0:3];
  reg [3:0] B_vec [0:3];

  initial begin
    A_vec[0] = 4'd1;  B_vec[0] = 4'd3;   // (a)
    A_vec[1] = 4'd11; B_vec[1] = 4'd9;   // (b)
    A_vec[2] = 4'd7;  B_vec[2] = 4'd13;  // (c)
    A_vec[3] = 4'd15; B_vec[3] = 4'd1;   // (d)

    Cin = 0; 

    $display(" time | Cin |   A     +     B    |   S     Cout ");
    $display("------------------------------------------------");

    for (i = 0; i < 4; i = i + 1) begin
      A = A_vec[i];
      B = B_vec[i];
      #1;
      $display("%4t |  %b  | %2d(%b) + %2d(%b) | %2d(%b)  %b",
               $time, Cin, A, A, B, B, S, S, Cout);
    end
  end
endmodule
