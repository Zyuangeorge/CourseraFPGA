library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture Behavioral of FSM is
    -- State encoding
    type state_type is (A, B, C); -- Define states
    signal current_state, next_state: state_type;
begin
    -- State transition process
    process(CLK, RST)
    begin
        if RST = '1' then
            current_state <= A; -- Reset to state A
        elsif rising_edge(CLK) then
            current_state <= next_state; -- Move to the next state
        end if;
    end process;

    -- Next state logic
    process(current_state, In1)
    begin
        case current_state is
            when A =>
                if In1 = '1' then
                    next_state <= B; -- Transition from A to B
                else
                    next_state <= A; -- Remain in A
                end if;
            when B =>
                if In1 = '1' then
                    next_state <= B; -- Remain in B
                else
                    next_state <= C; -- Transition from B to C
                end if;
            when C =>
                if In1 = '1' then
                    next_state <= A; -- Transition from C to A
                else
                    next_state <= C; -- Remain in C
                end if;
            when others =>
                next_state <= A; -- Default state
        end case;
    end process;

    -- Output logic
    process(current_state)
    begin
        case current_state is
            when A =>
                Out1 <= '0'; -- Output for state A
            when B =>
                Out1 <= '0'; -- Output for state B
            when C =>
                Out1 <= '1'; -- Output for state C
            when others =>
                Out1 <= '0'; -- Default output
        end case;
    end process;

end Behavioral;