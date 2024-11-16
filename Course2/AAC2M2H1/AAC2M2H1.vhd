LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU IS
    PORT (
        Op_code : IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3-bit opcode
        A, B    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0); -- 32-bit inputs
        Y       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- 32-bit output
    );
END ALU;

ARCHITECTURE rtl OF ALU IS
BEGIN
    PROCESS(Op_code, A, B)
    BEGIN
        CASE Op_code IS
            WHEN "000" => -- Y <= A
                Y <= A;
            WHEN "001" => -- Y <= A + B
                Y <= std_logic_vector(unsigned(A) + unsigned(B));
            WHEN "010" => -- Y <= A - B
                Y <= std_logic_vector(unsigned(A) - unsigned(B));
            WHEN "011" => -- Y <= A AND B
                Y <= A AND B;
            WHEN "100" => -- Y <= A OR B
                Y <= A OR B;
            WHEN "101" => -- Y <= A + 1
                Y <= std_logic_vector(unsigned(A) + 1);
            WHEN "110" => -- Y <= A - 1
                Y <= std_logic_vector(unsigned(A) - 1);
            WHEN "111" => -- Y <= B
                Y <= B;
            WHEN OTHERS => -- Default case
                Y <= (OTHERS => '0'); -- Set output to zero for safety
        END CASE;
    END PROCESS;
END rtl;

