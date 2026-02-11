`timescale 1ns/1ps

module tb_RCA4;

  // DUT inputs/outputs
  reg  [3:0] A, B;
  reg        Cin;
  wire [3:0] S;
  wire       Cout;

  // Instantiate RCA4
  RCA4 dut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout)
  );

  // Reference model
  reg [4:0] expected;
  integer i, j, k;
  integer errors;

  initial begin
    errors = 0;

    // Generate waveform
    $dumpfile("RCA4_tb.vcd");
    $dumpvars(0, tb_RCA4);

    // Header
    $display(" time | Cin |   A    +   B   |  S Cout | Expected | Result");
    $display("----------------------------------------------------------");

    // Test all combinations of A, B, Cin
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 2; k = k + 1) begin
          A = i; B = j; Cin = k;
          #1;
          expected = A + B + Cin;

          $display("%4t |  %b  | %2d(%b) + %2d(%b) | %2d(%b)  %b  |  %2d(%b)   | %s",
            $time, Cin, A, A, B, B, S, S, Cout,
            expected[3:0], expected[3:0],
            (S === expected[3:0] && Cout === expected[4]) ? "PASS" : "FAIL");

          if (S !== expected[3:0] || Cout !== expected[4])
            errors = errors + 1;
        end
      end
    end

    // Test result
    if (errors == 0)
      $display("✅ All tests PASSED!");
    else
      $display("❌ TEST FAILED: %0d errors found.", errors);

    $finish;
  end

endmodule
