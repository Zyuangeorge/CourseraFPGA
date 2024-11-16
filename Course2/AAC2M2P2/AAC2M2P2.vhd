LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY RAM128_32 IS
    PORT (
        address : IN  STD_LOGIC_VECTOR(6 DOWNTO 0); -- 7-bit address
        clock   : IN  STD_LOGIC := '1';            -- Clock signal
        data    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Input data
        wren    : IN  STD_LOGIC;                  -- Write enable
        q       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- Output data
    );
END RAM128_32;

ARCHITECTURE rtl OF RAM128_32 IS
    -- Declare RAM as an array of 32-bit vectors
    TYPE ram IS ARRAY (0 TO 2**7 - 1) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL mem : ram;
BEGIN
    -- Process to handle write operations on the rising edge of the clock
    PROCESS(clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF (wren = '1') THEN
                -- Write data to memory at the specified address
                mem(to_integer(unsigned(address))) <= data;
            END IF;
        END IF;
    END PROCESS;

    -- Continuous assignment of data output
    q <= mem(to_integer(unsigned(address)));

END ARCHITECTURE rtl;

