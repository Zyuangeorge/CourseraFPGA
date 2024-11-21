module ALU (
  input [2:0] Op_code,    // 3-bit opcode
  input [31:0] A, B,      // 32-bit inputs
  output reg [31:0] Y     // 32-bit output
);

  // Combinational logic for ALU operations
  always @(*) begin
    case (Op_code)
      3'b000: Y = A;              // Pass-through A
      3'b001: Y = A + B;          // Addition
      3'b010: Y = A - B;          // Subtraction
      3'b011: Y = A & B;          // Bitwise AND
      3'b100: Y = A | B;          // Bitwise OR
      3'b101: Y = A + 1;          // Increment A
      3'b110: Y = A - 1;          // Decrement A
      3'b111: Y = B;              // Pass-through B
      default: Y = 32'b0;         // Default case for safety
    endcase
  end

endmodule

