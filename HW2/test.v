`timescale 1ns/1ps

// tb_signed_unsigned.v
module tb_signed_unsigned;

  // 8-bit examples (easy to see wrap/overflow)
  reg  [7:0]      u_a, u_b;        // unsigned operands
  reg  signed [7:0] s_a, s_b;      // signed operands

  // helper: detect overflow
  function automatic signed_overflow_add;
    input signed [7:0] a, b, sum;
    begin
      // two's complement overflow rule:
      // if a and b have same sign, but sum has different sign
      signed_overflow_add = ((a[7] == b[7]) && (sum[7] != a[7]));
    end
  endfunction

  // pretty printers
  task show_u;
    input [7:0] a, b;
    input [7:0] res;
    input carry;
    begin
      $display("\n-- (UNSIGNED)");
      $display("a = %3d (0x%02h, %b)", a, a, a);
      $display("b = %3d (0x%02h, %b)", b, b, b);
      $display("res = %3d (0x%02h, %b)  carry=%0d  // as signed: %0d",
               res, res, res, carry, $signed(res));
    end
  endtask

  task show_s;
    input signed [7:0] a, b;
    input signed [7:0] res;
    input ovf;
    begin
      $display("\n-- (SIGNED)");
      $display("a = %4d (0x%02h, %b)", a, a, a);
      $display("b = %4d (0x%02h, %b)", b, b, b);
      $display("res = %4d (0x%02h, %b)  overflow=%0d",
               res, res, res, ovf);
    end
  endtask

  // Local variables for calculations
  reg [8:0] tmp;
  reg signed [7:0] sres;
  reg [7:0] mix_no_cast;
  reg signed [7:0] mix_signed;
  reg [7:0] mix_unsigned;
  reg signed [7:0] after;
  reg signed [7:0] before;

  initial begin
    // 1) Unsigned subtraction: 3 - 5  (wraps to 254, which is -2 if reinterpreted as signed)
    u_a = 8'd3; u_b = 8'd5;
    begin
      tmp = {1'b0,u_a} - {1'b0,u_b}; // to get borrow/carry info
      show_u(u_a, u_b, (u_a - u_b), tmp[8]); // tmp[8] is "carry" (borrow inverted)
    end

    // 2) Signed subtraction: 3 - 5 = -2 (no overflow)
    s_a = 8'sd3; s_b = 8'sd5;
    begin
      sres = s_a - s_b;
      show_s(s_a, s_b, sres, /*ovf*/ signed_overflow_add(s_a, -s_b, sres));
    end

    // 3) Positive + negative = negative: 5 + (-10) = -5 (no overflow)
    s_a = 8'sd5; s_b = -8'sd10;
    begin
      sres = s_a + s_b;
      show_s(s_a, s_b, sres, signed_overflow_add(s_a, s_b, sres));
    end

    // 4) Signed overflow: 127 + 1 -> -128 (overflow=1)
    s_a = 8'sd127; s_b = 8'sd1;
    begin
      sres = s_a + s_b;
      show_s(s_a, s_b, sres, signed_overflow_add(s_a, s_b, sres));
    end

    // 5) Unsigned overflow (carry out): 250 + 20 = 270 -> 14 with carry=1
    u_a = 8'd250; u_b = 8'd20;
    begin
      tmp = {1'b0,u_a} + {1'b0,u_b};
      show_u(u_a, u_b, (u_a + u_b), tmp[8]);
    end

    // 6) Mixed types: signed a + unsigned b
    //    Case A: s_a=-20 (0xEC), u_b=10 -> expression treated UNSIGNED unless you cast.
    s_a = -8'sd20; u_b = 8'd10;
    begin
      // Mixed without cast (unsigned dominates)
      mix_no_cast = s_a + u_b;            // unsigned add
      // With explicit casts to signed
      mix_signed = s_a + $signed(u_b);   // signed add
      // Or explicitly force both unsigned
      mix_unsigned = $unsigned(s_a) + u_b;

      $display("\n-- Mixed add: s_a(-20) + u_b(10)");
      $display("no cast (unsigned expr): res=%3d (0x%02h, %b)  as signed=%4d",
                mix_no_cast, mix_no_cast, mix_no_cast, $signed(mix_no_cast));
      $display("with $signed(u_b)     : res=%4d (0x%02h, %b)",
                mix_signed, mix_signed, mix_signed);
      $display("force $unsigned(s_a)  : res=%3d (0x%02h, %b)",
                mix_unsigned, mix_unsigned, mix_unsigned);
    end

    // 7) Casting with subtraction: show difference between
    //    $signed(u_a - u_b)  vs  $signed(u_a) - $signed(u_b)
    u_a = 8'd3; u_b = 8'd5;
    begin
      // (a) do UNSIGNED subtraction first, then reinterpret bits as signed
      after = $signed(u_a - u_b);   // yields -2 but via wrap (1110)
      // (b) cast operands to signed BEFORE subtraction (true signed math)
      before = $signed(u_a) - $signed(u_b); // -2
      $display("\n-- Casting order matters (3 - 5)");
      $display("$signed(u_a - u_b)      = %4d (0x%02h)", after,  after);
      $display("$signed(u_a)-$signed(u_b)= %4d (0x%02h)", before, before);
    end

    // 8) Compare operations (signed vs unsigned)
    s_a = -8'sd1; u_b = 8'd255; // same bit pattern 0xFF
    $display("\n-- Compare -1 (signed) vs 255 (unsigned), both 0xFF");
    $display("signed compare  (s_a < $signed(u_b))  = %0d", (s_a < $signed(u_b)));
    $display("unsigned compare ($unsigned(s_a) < u_b)= %0d", ($unsigned(s_a) < u_b));

    $display("\nAll tests done.\n");
    $finish;
  end

endmodule
