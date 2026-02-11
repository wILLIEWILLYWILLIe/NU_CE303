module Vr3bitctrdec ( CLK, CLR, S_L );
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