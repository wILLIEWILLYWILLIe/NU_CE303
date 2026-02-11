`timescale 1ns/1ps

module tb_counter_compare;
    reg CLK = 0;
    reg CLR = 0;
    
    // Outputs from p11_6 (combinational decoder)
    wire [0:7] S_L_comb;
    
    // Outputs from p11_7 (registered decoder)
    wire [0:7] S_L_reg;
    
    // Instantiate p11_6 (combinational decoder)
    Vr3bitctrdec_comb dut_comb (
        .CLK(CLK),
        .CLR(CLR),
        .S_L(S_L_comb)
    );
    
    // Instantiate p11_7 (registered decoder)
    Vr3bitctrdec_reg dut_reg (
        .CLK(CLK),
        .CLR(CLR),
        .S_L(S_L_reg)
    );
    
    // 10-ns clock (50 MHz)
    always #5 CLK = ~CLK;
    
    // VCD dump for waveform analysis
    initial begin
        $dumpfile("counter_compare.vcd");
        $dumpvars(0, tb_counter_compare);
    end
    
    // Stimulus
    initial begin
        
        // Initial reset
        CLR = 1;
        repeat(2) @(posedge CLK);
        CLR = 0;
        
        // Run for ~40 clock cycles (3-bit counter cycles every 8 clocks)
        repeat(40) @(posedge CLK);
        
        CLR = 1;
        @(posedge CLK);
        CLR = 0;
        
        // Run a few more cycles
        repeat(10) @(posedge CLK);
        
        $finish;
    end
    
endmodule

module Vr3bitctrdec_comb ( CLK, CLR, S_L );
    input CLK, CLR;
    output reg [0:7] S_L;
    reg [2:0] Q;
    integer i;
    
    always @ (posedge CLK) // Create the counter f-f behavior
        if (CLR) Q <= 3'd0;
        else Q <= Q + 1;
    always @ (Q) begin // Decode counter states to create outputs
        S_L = 8'b11111111;
        for (i=0; i<=7; i=i+1)
        if (i == Q) S_L[i] = 0;
    end
endmodule

module Vr3bitctrdec_reg ( CLK, CLR, S_L );
    input CLK, CLR;
    output reg [0:7] S_L;
    reg [2:0] Q;
    integer i;
    
    always @ (posedge CLK) begin
        if (CLR) Q <= 3'd0; // Create the counter f-f behavior
        else Q <= Q + 1;
        S_L <= 8'b11111111; // Default for outputs is negated
        for (i=0; i<=7; i=i+1) // Decode counter states to assert
        if (i == Q) S_L[i] <= 0; // one active-low output
    end
endmodule

