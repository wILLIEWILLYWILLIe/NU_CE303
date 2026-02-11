module Vr3bitctrdec ( CLK, CLR, S_L );
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