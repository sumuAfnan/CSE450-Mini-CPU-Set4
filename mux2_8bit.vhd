----------------------------------------------------------------------------
-- 8-bit 2-to-1 Multiplexer : 8 x mux2_1
-- S = 0 -> Y = A,  S = 1 -> Y = B
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_8bit is
    Port (
        A : in  STD_LOGIC_VECTOR (7 downto 0);
        B : in  STD_LOGIC_VECTOR (7 downto 0);
        S : in  STD_LOGIC;
        Y : out STD_LOGIC_VECTOR (7 downto 0)
    );
end mux2_8bit;

architecture Structural of mux2_8bit is

    component mux2_1
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            S : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

begin

    GEN_MUX: for i in 0 to 7 generate
        M: mux2_1
            port map (
                A => A(i),
                B => B(i),
                S => S,
                Y => Y(i)
            );
    end generate;

end Structural;
