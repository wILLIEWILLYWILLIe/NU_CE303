`timescale 1ns/1ps
module tb_shifter;
    reg [15:0] Din;
    reg [3:0] S;
    reg [2:0] C;
    wire [15:0] Dout;

    Vrbarrel16 dut(.DIN(Din), .S(S), .C(C), .DOUT(Dout));

    task run_case(input [15:0] d, input [3:0] s, input [2:0] c);
    begin
        Din = d;
        S = s;
        C = c;
        #1;
        $display("Case : [%3b] Output : Dout=%16b --> %0d", 
            c, Dout, Dout);
    end
    endtask


    integer C_case;
    integer Giv_DIN = 16'b1001011101010011;
    integer Giv_S = 4'b0011;
    // integer Giv_S = 4'b0001;
    initial begin
        
        $display("Original: Din=%0b --> %0d", Giv_DIN, Giv_DIN);
        $display("----------------------------------");
        for (C_case=0; C_case<=5; C_case=C_case+1) run_case(
            Giv_DIN,Giv_S,C_case[3:0]
            );
        $finish;
    end
endmodule


