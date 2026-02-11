`timescale 1ns/10ps
//================================================
// Conventional ALU: ADD(000), SUB(001), LSL(010), LSR(011), CMP(100), XOR(101), MUX(110), TBD(111)
// Create   Date: 11.13.2016
// Modification: 1. Based on alu_main(v3) and alu_muxGroup_v2  
//               2. ALU(w/o output mux)+ alu_muxGroup
//		 3. Add input mux
// Written by: Edison
//================================================

// Top module
module alu_conv(a0_mux, a1_mux, a_sel, b, sel, ctrl, out);	
	input  	[7:0] a0_mux;
	input  	[7:0] a1_mux;
	input         a_sel;
	input  	[7:0] b;
	input  	[2:0] ctrl;
	input  	      sel;
	output  [7:0] out;
	
	wire		[7:0] a;
	wire 		[7:0] out_add;
	wire 		[7:0] out_sub;
	wire 		[7:0] out_lsl;
	wire 		[7:0] out_lsr;
	wire 		[7:0] out_cmp;
	wire 		[7:0] out_xor;
	wire 		[7:0] out_mux;
	wire		[7:0] out_tbd;
	// Input muxGroups
	mux2_n muxGroup_input(
			.a 	 (a0_mux),
			.b	 (a1_mux),
			.sel	 (a_sel),
			.out     (a)
			);
	// ALU w/o input and output muxGroups 	
	alu_main alu(
			.a  	 (a),
			.b 	 (b),
			.out_add (out_add),
			.out_sub (out_sub),
			.out_lsl (out_lsl),
			.out_lsr (out_lsr),
			.out_cmp (out_cmp),
			.out_xor (out_xor),
			.out_mux (out_mux),
			.out_tbd (out_tbd)
			);
	// Output muxGroups
	mux8_n muxGroup_ouput(
			.a	 (out_add),
			.b	 (out_sub),
			.c	 (out_lsl),
			.d	 (out_lsr),
			.e	 (out_cmp),
			.f	 (out_xor),
			.g	 (out_mux),
			.h	 (out_tbd),
			.sel     (ctrl),
			.out     (out)
			);
endmodule 

module add(a, b, out);
	input  [7:0] a;
	input  [7:0] b;
	output [7:0] out;
	assign out = a + b;
endmodule

module sub(a, b, out);
	input  [7:0] a;
	input  [7:0] b;
	output [7:0] out;
	assign out = a - b;
endmodule

module lsl(
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out
    );
    assign out = a << b;
endmodule

module lsr(
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out
    );
    assign out = a >> b;
endmodule
module cmp(
	input  [7:0] a,	
	input  [7:0] b,
	output [7:0] out
);
	assign out = (a >= b) ? 0:1;	
endmodule

module xor_n(a, b, out);
	parameter n = 8;
	input  [n-1:0] a;
	input  [n-1:0] b;
	output [n-1:0] out;
	assign out = a ^ b;
endmodule

module mux2_n(a, b, sel, out);
	parameter n = 8;
	input  [n-1:0] a;
	input  [n-1:0] b;
	input          sel;
	output [n-1:0] out;
	assign out = (sel == 0) ? a : b;
endmodule



// ALU_main(v3)(w/o mux group)
module alu_main(a, b, out_add, out_sub, out_lsl, out_lsr, out_cmp, out_xor, out_mux, out_tbd);
	input  [7:0] a;
	input  [7:0] b;
	output [7:0] out_add;
	output [7:0] out_sub;
	output [7:0] out_lsl;
	output [7:0] out_lsr;
	output [7:0] out_cmp;
	output [7:0] out_xor;
	output [7:0] out_mux;
	output [7:0] out_tbd;

	add add_1(
			.a   (a),
			.b   (b),
			.out (out_add)
			);
	sub sub_1(
			.a   (a),
			.b   (b),
			.out (out_sub)
			);
	lsl lsl_1(
			.a   (a),
			.b   (b),
			.out (out_lsl)
			);
	lsr lsr_1(
			.a   (a),
			.b   (b),
			.out (out_lsr)
			);
	cmp cmp_1(
			.a   (a),
			.b   (b),
			.out (out_cmp)
			); 
	xor_n#(8) xor_n_1(
			.a   (a),
			.b   (b),
			.out (out_xor)
			); 
	mux2_n#(8) mux_n_1(
			.a   (a),
			.b   (b),
			.sel (sel),
			.out (out_mux)
			);	
endmodule 

// Input muxGroup


// Output muxGroup
module mux8_n(a, b, c,d ,e, f, g, h, sel, out);
	parameter n = 8;
	input  [n-1:0] a;
	input  [n-1:0] b;
	input  [n-1:0] c;
	input  [n-1:0] d;
	input  [n-1:0] e;
	input  [n-1:0] f;
	input  [n-1:0] g;
	input  [n-1:0] h;
	input  [2:0]   sel;
	output [n-1:0] out;

	wire        [7:0] mux_out_1_1;
	wire        [7:0] mux_out_1_2;
	wire        [7:0] mux_out_1_3;
	wire        [7:0] mux_out_1_4;
	wire        [7:0] mux_out_2_1;
	wire        [7:0] mux_out_2_2;
	wire        [7:0] mux_out_3_1;

	// level 1
	mux2_n mux_1_1(
	.a   (a),
	.b   (b),
	.sel (sel[0]),
	.out (mux_out_1_1)
	);

	mux2_n mux_1_2(
	.a   (c),
	.b   (d),
	.sel (sel[0]),
	.out (mux_out_1_2)
	);

	mux2_n mux_1_3(
	.a   (e),
	.b   (f),
	.sel (sel[0]),
	.out (mux_out_1_3)
	);

	mux2_n mux_1_4(
	.a   (g),
	.b   (h),
	.sel (sel[0]),
	.out (mux_out_1_4)
	);
	// level 2

	mux2_n mux_2_1(
	.a   (mux_out_1_1),
	.b   (mux_out_1_2),
	.sel (sel[1]),
	.out (mux_out_2_1)
	);

	mux2_n mux_2_2(
	.a   (mux_out_1_3),
	.b   (mux_out_1_4),
	.sel (sel[1]),
	.out (mux_out_2_2)
	);

	// level 3

	mux2_n mux_3_1(
	.a   (mux_out_2_1),
	.b   (mux_out_2_2),
	.sel (sel[2]),
	.out (out)
	);

endmodule



