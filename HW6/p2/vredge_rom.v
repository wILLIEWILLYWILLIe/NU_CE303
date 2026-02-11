module Vredge_rom (
    input  wire clk,
    input  wire rst_n,
    input  wire X,
    output wire EDGE
);
    // State enc: A=2'b00, B=2'b01, C=2'b10, D=2'b11
    reg  [1:0] state, next_state;
    wire [2:0] rom_out;
    wire [2:0] addr = {state, X};

    // 8x3 ROM: {NS1, NS0, EDGE}
    // Address = {Current State, X}
    // Data    = {Next State, Output}
    reg [2:0] ROM [0:7];
    initial begin
        // State A (00): Stable 0, Output=0
        ROM[3'b000] = 3'b000; // A(00), X=0 -> Next=A(00), EDGE=0
        ROM[3'b001] = 3'b010; // A(00), X=1 -> Next=B(01), EDGE=0
        
        // State B (01): Rising Edge, Output=1. Logic: (X ? C : D)
        ROM[3'b010] = 3'b111; // B(01), X=0 -> Next=D(11), EDGE=1
        ROM[3'b011] = 3'b101; // B(01), X=1 -> Next=C(10), EDGE=1
        
        // State C (10): Stable 1, Output=0. Logic: (X ? C : D)
        ROM[3'b100] = 3'b110; // C(10), X=0 -> Next=D(11), EDGE=0
        ROM[3'b101] = 3'b100; // C(10), X=1 -> Next=C(10), EDGE=0
        
        // State D (11): Falling Edge, Output=1. Logic: (X ? B : A)
        ROM[3'b110] = 3'b001; // D(11), X=0 -> Next=A(00), EDGE=1
        ROM[3'b111] = 3'b011; // D(11), X=1 -> Next=B(01), EDGE=1
    end

    assign rom_out    = ROM[addr];
    assign EDGE       = rom_out[0];         // Moore output from present state
    assign next_state = rom_out[2:1];

    // State FFs
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) state <= 2'b00;        // start in A
        else        state <= next_state;
    end
endmodule
