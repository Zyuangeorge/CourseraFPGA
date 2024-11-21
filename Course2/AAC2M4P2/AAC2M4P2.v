module RAM128x32 
#(
  parameter Data_width = 32,  // Number of bits in a word
            Addr_width = 7    // Number of address bits (128 = 2^7)
)
(
  input wire clk,                      // Clock signal
  input wire we,                       // Write enable
  input wire [(Addr_width-1):0] address,  // Address input
  input wire [(Data_width-1):0] d,        // Data input
  output reg [(Data_width-1):0] q         // Data output (registered)
);

  // Declare the RAM as a 2D array
  reg [Data_width-1:0] memory [0:(2**Addr_width)-1];

  always @(posedge clk) begin
    if (we) begin
      // Write operation
      memory[address] <= d;
    end
    // Read operation
    q <= memory[address];
  end

endmodule

