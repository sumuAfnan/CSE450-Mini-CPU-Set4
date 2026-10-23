----------------------------------------------------------------------------
-- 8-bit bitwise AND : 8 x and_gate   (used by the AND instruction)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_8bit is
    Port (
        A : in  STD_LOGIC_VECTOR (7 downto 0);
        B : in  STD_LOGIC_VECTOR (7 downto 0);
        Y : out STD_LOGIC_VECTOR (7 downto 0)
    );
end and_8bit;

architecture Structural of and_8bit is

    component and_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

begin

    GEN_AND: for i in 0 to 7 generate
        AG: and_gate
            port map (
                A => A(i),
                B => B(i),
                Y => Y(i)
            );
    end generate;

end Structural;
