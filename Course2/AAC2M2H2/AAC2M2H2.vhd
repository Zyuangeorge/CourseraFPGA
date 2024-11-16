library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO8x9 is
    port (
        clk, rst:       in std_logic;                 -- Clock and Reset
        RdPtrClr, WrPtrClr: in std_logic;             -- Pointer clear signals
        RdInc, WrInc:   in std_logic;                 -- Pointer increment signals
        DataIn:         in std_logic_vector(8 downto 0); -- Input data bus
        DataOut:        out std_logic_vector(8 downto 0); -- Output data bus
        rden, wren:     in std_logic                  -- Read and write enable signals
    );
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
    -- Signal declarations
    type fifo_array is array(7 downto 0) of std_logic_vector(8 downto 0);  -- FIFO memory array
    signal fifo: fifo_array := (others => (others => '0'));                -- Initialize to zeros
    signal wrptr, rdptr: unsigned(2 downto 0) := (others => '0');          -- Write and read pointers
    signal dmuxout: std_logic_vector(8 downto 0);                          -- Data multiplexer output
begin
    -- Write operation
    process(clk)
    begin
        if rising_edge(clk) then
            if wren = '1' then
                fifo(to_integer(wrptr)) <= DataIn; -- Write data to FIFO
            end if;

            if WrPtrClr = '1' then
                wrptr <= (others => '0'); -- Clear write pointer
            elsif WrInc = '1' then
                wrptr <= wrptr + 1;       -- Increment write pointer
            end if;
        end if;
    end process;

    -- Read operation
    process(clk)
    begin
        if rising_edge(clk) then
            if RdPtrClr = '1' then
                rdptr <= (others => '0'); -- Clear read pointer
            elsif RdInc = '1' then
                rdptr <= rdptr + 1;       -- Increment read pointer
            end if;
        end if;
    end process;

    -- Data output logic
    dmuxout <= fifo(to_integer(rdptr)); -- Multiplex the data from FIFO
    DataOut <= dmuxout when rden = '1' else (others => 'Z'); -- High-impedance when not enabled
end architecture RTL;

