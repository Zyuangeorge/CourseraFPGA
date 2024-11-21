module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output reg [3:0] Q,   // Parallel Output 	
    output reg RCO        // Ripple Carry Output (Terminal Count)
);

    always @(posedge CLK or negedge CLR_n) begin
        if (!CLR_n) begin
            Q <= 4'b0000; // Asynchronous reset to 0
            RCO <= 1'b0; // Reset terminal count
        end else if (!LOAD_n) begin
            Q <= D; // Load parallel input when LOAD_n is low
            RCO <= 1'b0; // Reset terminal count
        end else if (ENP && ENT) begin
            Q <= Q + 1; // Increment counter
            if (Q == 4'b1111) // Detect terminal count
                RCO <= 1'b1;
            else
                RCO <= 1'b0;
        end
    end

endmodule

