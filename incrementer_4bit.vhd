----------------------------------------------------------------------------
-- 4-bit Incrementer : Y = A + 1   (chain of 4 half adders)
-- Used by the PC. Final carry is discarded (15 + 1 = 0).
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity incrementer_4bit is
    Port (
        A : in  STD_LOGIC_VECTOR (3 downto 0);
        Y : out STD_LOGIC_VECTOR (3 downto 0)
    );
end incrementer_4bit;

architecture Structural of incrementer_4bit is

    component half_adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            SUM  : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component;

    signal C0, C1, C2, C3 : STD_LOGIC;

begin

    HA0: half_adder port map ( A => A(0), B => '1', SUM => Y(0), COUT => C0 );
    HA1: half_adder port map ( A => A(1), B => C0,  SUM => Y(1), COUT => C1 );
    HA2: half_adder port map ( A => A(2), B => C1,  SUM => Y(2), COUT => C2 );
    HA3: half_adder port map ( A => A(3), B => C2,  SUM => Y(3), COUT => C3 );

end Structural;
