`timescale 1ns/1ps
module tb_decoder_2to4;

  reg  [1:0] I;
  reg        POL;
  wire [3:0] Y;

  decoder_2to4 dut (
    .I  (I),
    .POL(POL),
    .Y  (Y)
  );

  integer vec;
  initial begin
    // VCD dump for waveform
    $dumpfile("decoder_2to4_tb.vcd");
    $dumpvars(0, tb_decoder_2to4);
    // Header
    $display(" time | POL I1 I0 ||  Y3 Y2 Y1 Y0");
    $display("-----------------------------------");

    // Sweep all inputs {POL,I} = 3'b000 .. 3'b111
    for (vec = 0; vec < 8; vec = vec + 1) begin
      {POL, I} = vec[2:0];
      #1; // allow signal settle
      $display("%4t |  %0b   %0b  %0b ||   %0b  %0b  %0b  %0b",
               $time, POL, I[1], I[0], Y[3], Y[2], Y[1], Y[0]);
    end
  end
endmodule
