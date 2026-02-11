`timescale 1ns/1ps

module Vredge (clk, rst_n, X, EDGE, state_dbg);
    input   clk;
    input   rst_n;
    input   X;     
    output reg  EDGE;    
    output [1:0] state_dbg; 

    localparam [1:0] A = 2'b00, // stable-0
                     B = 2'b01, // 0->1 edge
                     C = 2'b10, // stable-1
                     D = 2'b11; // 1->0 edge

    reg [1:0] state, next;

    // State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= A;
        else
            state <= next;
    end

    // Next-state 
    always @* begin
        case (state)
            A: next = (X ? B : A);    
            B: next = (X ? C : D);   
            C: next = (X ? C : D);    
            D: next = (X ? B : A);   
            default: next = A;
        endcase
    end

    // Registered output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            EDGE <= 1'b0;
        else
            EDGE <= (next == B) || (next == D);
    end

    assign state_dbg = state;
endmodule
