`timescale 1ns/1ps

module Vrbarrel16(DIN, S, C, DOUT);
    input [15:0] DIN;       // Data inputs
    input [3:0] S;          // Shift amount, 0-15
    input [2:0] C;          // Mode control
    output [15:0] DOUT;     // Data but output
    reg [15:0] DOUT; 
    parameter   Lrotate = 3'b000, //Define the coding of
                Rrotate = 3'b001,//the different shift modes
                Llogical = 3'b010,
                Rlogical = 3'b011,
                Larith = 3'b100,
                Rarith = 3'b101;

    function [15:0] Vrol;
        input [15:0] D;
        input [3:0] S;
        integer ii, N;
        reg [15:0] TMPD;
        begin
            N = S; TMPD = D;
            for (ii=1;ii<=N; ii=ii+1) TMPD = {TMPD[14:0], TMPD[15]};
            Vrol = TMPD;
        end
    endfunction

    function [15:0] Vror;
        input [15:0] D;
        input [3:0] S;
        integer ii, N;
        reg [15:0] TMPD;
        begin
            N = S; TMPD = D;
            for (ii=1;ii<=N;ii=ii+1) TMPD = {TMPD[0], TMPD[15:1]};
            Vror = TMPD;
        end
    endfunction

    function [15:0] Vsll;
        input [15:0] D;
        input [3:0] S;
        integer ii, N;
        reg [15:0] TMPD;
        begin
            N = S; TMPD = D;
            for (ii=1;ii<=N;ii=ii+1) TMPD = {TMPD[14:0],1'd0};
            Vsll = TMPD;
        end
    endfunction

    function [15:0] Vsrl;
        input [15:0] D;
        input [3:0] S;
        integer ii, N;
        reg [15:0] TMPD;
        begin
            N = S; TMPD = D;
            for (ii=1;ii<=N;ii=ii+1) TMPD = {1'd0, TMPD[15:1]};
            Vsrl = TMPD;
        end
    endfunction

    function [15:0] Vala;
        input [15:0] D;
        input [3:0] S;
        integer ii, N;
        reg [15:0] TMPD;
        begin
            N = S; TMPD = D;
            for (ii=1;ii<=N;ii=ii+1) TMPD = {TMPD[14:0],1'd0};
            Vala = TMPD;
        end
    endfunction

    function [15:0] Vara;
        input [15:0] D;
        input [3:0] S;
        integer ii, N;
        reg [15:0] TMPD;
        begin
            N = S; TMPD = D;
            for (ii=1;ii<=N;ii=ii+1) TMPD = {TMPD[15], TMPD[15:1]};
            Vara = TMPD;
        end
    endfunction


    always @ (DIN or S or C)
        case(C)
            Lrotate : DOUT = Vrol(DIN,S);
            Rrotate : DOUT = Vror(DIN,S);
            Llogical: DOUT = Vsll(DIN,S);
            Rlogical: DOUT = Vsrl(DIN,S);
            Larith : DOUT = Vala(DIN,S);
            Rarith : DOUT = Vara(DIN,S);
            default: DOUT = DIN;
        endcase
endmodule