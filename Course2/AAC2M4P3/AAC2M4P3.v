module FSM(
  input In1,
  input RST,
  input CLK,
  output reg Out1
);

  // State encoding using local parameters
  localparam S_A = 2'b00; // State A
  localparam S_B = 2'b01; // State B
  localparam S_C = 2'b10; // State C

  reg [1:0] current_state, next_state; // Registers for current and next state

  // Sequential logic for state transition
  always @(posedge CLK or negedge RST) begin
    if (!RST)
      current_state <= S_A; // Reset to state A
    else
      current_state <= next_state; // Transition to the next state
  end

  // Combinational logic for next state and output
  always @(*) begin
    // Default values
    next_state = current_state;
    Out1 = 0;

    case (current_state)
      S_A: begin
        Out1 = 0; // Output for state A
        if (In1 == 1'b0)
          next_state = S_A;
        else
          next_state = S_B;
      end

      S_B: begin
        Out1 = 0; // Output for state B
        if (In1 == 1'b0)
          next_state = S_C;
        else
          next_state = S_B;
      end

      S_C: begin
        Out1 = 1; // Output for state C
        if (In1 == 1'b0)
          next_state = S_C;
        else
          next_state = S_A;
      end

      default: begin
        next_state = S_A; // Default to state A in case of invalid state
        Out1 = 0;
      end
    endcase
  end

endmodule
