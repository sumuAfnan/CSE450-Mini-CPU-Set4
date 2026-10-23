library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flip_flop_reset is
    Port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end d_flip_flop_reset;

architecture Behavioral of d_flip_flop_reset is

begin

    process(CLK)
    begin
        if rising_edge(CLK) then

            if RESET = '1' then
                Q <= '0';
            else
                Q <= D;
            end if;

        end if;
    end process;

end Behavioral;