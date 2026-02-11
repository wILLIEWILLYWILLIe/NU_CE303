`timescale 1ns/10ps

module alu_conv_test;
	reg [7:0] a0_mux; 
	reg [7:0] a1_mux; 
	reg a_sel;
	reg [7:0] b; 
	reg sel; 
	reg [2:0] ctrl; 
	wire [7:0] out; 
	 
alu_conv doubile (
	a0_mux, 
	a1_mux, 
	a_sel, 
	b, 
	sel, 
	ctrl, 
	out);
// insert data
	initial 
		begin
//ctrl 000
			a0_mux=8'h08;
			a1_mux=8'h10;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b000;
			#10
			a0_mux=8'h50;
			a1_mux=8'h07;
			a_sel=1'b1;
			b=8'h07;
			sel=1'b0;
			ctrl=3'b000;
			#10
			a0_mux=8'h40;
			a1_mux=8'h08;
			a_sel=1'b1;
			b=8'h08;
			sel=1'b0;
			ctrl=3'b000;
			#10
			a0_mux=8'h33;
			a1_mux=8'h0d;
			a_sel=1'b1;
			b=8'h0d;
			sel=1'b0;
			ctrl=3'b000;
			#10

//ctrl 001
			a0_mux=8'h80;
			a1_mux=8'h41;
			a_sel=1'b1;
			b=8'h01;
			sel=1'b0;
			ctrl=3'b001;
			#10
			a0_mux=8'h55;
			a1_mux=8'h4a;
			a_sel=1'b1;
			b=8'h02;
			sel=1'b0;
			ctrl=3'b001;
			#10
//ctrl 010
			a0_mux=8'h11;
			a1_mux=8'h02;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b010;
			#10
			a0_mux=8'h15;
			a1_mux=8'h01;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b010;
			#10
//ctrl 011
			a0_mux=8'h88;
			a1_mux=8'h03;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b011;
			#10
			a0_mux=8'h89;
			a1_mux=8'h01;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b011;
			#10
//ctrl 100
			a0_mux=8'h33;
			a1_mux=8'h22;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b100;
			#10
			a0_mux=8'h11;
			a1_mux=8'h21;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b100;
			#10
//ctrl 101
			a0_mux=8'h21;
			a1_mux=8'h47;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b101;
			#10
			a0_mux=8'h88;
			a1_mux=8'h78;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b101;
			#10
//ctrl 110
			a0_mux=8'h09;
			a1_mux=8'h02;
			a_sel=1'b1;
			b=8'h01;
			sel=1'b0;
			ctrl=3'b110;
			#10
			a0_mux=8'h06;
			a1_mux=8'h31;
			a_sel=1'b1;
			b=8'h10;
			sel=1'b0;
			ctrl=3'b110;
			#10
//ctrl 111
			a0_mux=8'h02;
			a1_mux=8'h06;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b111;
			#10
			a0_mux=8'h09;
			a1_mux=8'hff;
			a_sel=1'b1;
			b=8'h00;
			sel=1'b0;
			ctrl=3'b111;

                #20 $finish;
			
	end 
endmodule
