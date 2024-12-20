module FIFO8x9(
  input clk,                // Clock signal
  input rst,                // Reset signal
  input RdPtrClr,           // Read pointer clear
  input WrPtrClr,           // Write pointer clear
  input RdInc,              // Read pointer increment
  input WrInc,              // Write pointer increment
  input [8:0] DataIn,       // 9-bit data input
  output reg [8:0] DataOut, // 9-bit data output
  input rden,               // Read enable
  input wren                // Write enable (updated name)
);

  // Signal declarations
  reg [8:0] fifo_array[7:0];  // 8x9 FIFO memory array
  reg [2:0] wrptr, rdptr;     // Write and read pointers (3 bits for 8 entries)

  // Write logic
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      wrptr <= 3'b000;          // Reset write pointer
    end else if (WrPtrClr) begin
      wrptr <= 3'b000;          // Clear write pointer
    end else if (wren && WrInc) begin
      fifo_array[wrptr] <= DataIn; // Write data to FIFO
      wrptr <= wrptr + 1;        // Increment write pointer
    end
  end

  // Read logic
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      rdptr <= 3'b000;          // Reset read pointer
    end else if (RdPtrClr) begin
      rdptr <= 3'b000;          // Clear read pointer
    end else if (rden && RdInc) begin
      DataOut <= fifo_array[rdptr]; // Read data from FIFO
      rdptr <= rdptr + 1;        // Increment read pointer
    end else if (!rden) begin
      DataOut <= 9'bZ;           // High impedance when read disabled
    end
  end

endmodule

