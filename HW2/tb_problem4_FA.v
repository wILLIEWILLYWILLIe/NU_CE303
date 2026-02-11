`timescale 1ns/1ps
module tb_FA;

  // DUT I/O
  reg  A, B, Cin;
  wire S, Cout;

  FA dut (
    .A   (A),
    .B   (B),
    .Cin (Cin),
    .S   (S),
    .Cout(Cout)
  );

  integer vec;

  initial begin
    // VCD waveform output
    $dumpfile("problem4_FA_tb.vcd");
    $dumpvars(0, tb_FA);

    // Print header
    $display(" time | A B Cin || S Cout ");
    $display("--------------------------");

    // Loop through all input combinations (0–7)
    for (vec = 0; vec < 8; vec = vec + 1) begin
      {A, B, Cin} = vec[2:0];  
      #0.5;                    
      $display("%4t | %0b %0b  %0b  ||  %0b   %0b",
               $time, A, B, Cin, S, Cout);
    end

    #5 $finish;
  end

endmodule
