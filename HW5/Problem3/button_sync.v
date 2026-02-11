`timescale 1ns/1ps
module button_sync (b_o, clk, rst_n, b_i); 
    input   clk, rst_n, b_i;
    output reg  b_o;      

    localparam S0_WAIT_PRESS   = 2'b00;
    localparam S1_PULSE        = 2'b01;
    localparam S2_WAIT_RELEASE = 2'b10;

    reg [1:0] state, next_state;
    always @(posedge clk or negedge rst_n) begin : state_reg
        if (!rst_n)
            state <= S0_WAIT_PRESS;
        else
            state <= next_state;
    end
    always @(*) begin : next_state_logic
        next_state = state;
        b_o        = 1'b0;
        case (state)
            S0_WAIT_PRESS: begin
                b_o = 1'b0;
                if (b_i == 1'b1)
                    next_state = S1_PULSE;
                else
                    next_state = S0_WAIT_PRESS;
            end
            S1_PULSE: begin
                b_o        = 1'b1;
                next_state = S2_WAIT_RELEASE;  
            end
            S2_WAIT_RELEASE: begin
                b_o = 1'b0;
                if (b_i == 1'b0)
                    next_state = S0_WAIT_PRESS;   
                else
                    next_state = S2_WAIT_RELEASE; 
            end
            default: begin
                b_o        = 1'b0;
                next_state = S0_WAIT_PRESS;
            end
        endcase
    end
endmodule
