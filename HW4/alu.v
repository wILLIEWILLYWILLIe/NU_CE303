`timescale 1ns/1ps

module alu8(A, B, F, Q, Cout);
    input [7:0] A, B;
    input [2:0] F;
    output [7:0] Q;
    output Cout;
    reg [7:0] Q;
    reg Cout;
    parameter   ADD     = 3'b000, 
                SUB     = 3'b001, 
                ORR     = 3'b010,
                ANDD    = 3'b011,
                XORR    = 3'b100,
                NOTT    = 3'b101,
                SLA     = 3'b110,
                SRA     = 3'b111;
    always @ (*) begin
        Q = 8'b0;
        Cout = 1'b0;
        case(F)
            ADD:begin
                {Cout, Q} = {1'b0, A}+{1'b0, B};
            end
            SUB:begin
                Q    = A - B;      
                Cout = (A < B);
            end
            ORR:begin
                Q = A | B; 
            end
            ANDD:begin
                Q = A & B;
            end
            XORR:begin
                Q = A ^ B;
            end
            NOTT:begin
                Q = (~A);
            end
            SLA:begin
                Q = {A[6:0],1'b0};
            end
            SRA:begin
                Q = {A[7], A[7:1]};
            end
            default: begin
                Q    = 8'd0;
                Cout = 1'b0;
            end
        endcase
    end
endmodule
