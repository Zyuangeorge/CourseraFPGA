LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

architecture Behavioral of AAC2M2P1 is
    signal count : unsigned(3 downto 0) := (others => '0'); -- Internal counter signal
begin
    process (CP)
    begin
        if rising_edge(CP) then
            -- Synchronous Reset (Active LOW)
            if SR = '0' then
                count <= (others => '0');
            -- Parallel Load when PE is active (Active LOW)
            elsif PE = '0' then
                count <= unsigned(P);
            -- Counting Logic
            elsif CEP = '1' and CET = '1' then
                if count = "1111" then
                    count <= (others => '0'); -- Wrap around for modulo-16
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    -- Output Assignments
    Q <= std_logic_vector(count); -- Convert internal `unsigned` signal to `std_logic_vector`
    TC <= '1' when (count = "1111" and CEP = '1' and CET = '1') else '0';

end Behavioral;
