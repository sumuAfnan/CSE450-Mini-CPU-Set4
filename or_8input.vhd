----------------------------------------------------------------------------
-- 8-input OR gate : Y = A(0) or A(1) or ... or A(7)   (7 x or_gate)
-- Y = 1 means the 8-bit value is NOT zero (used for the Z flag)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_8input is
    Port (
        A : in  STD_LOGIC_VECTOR (7 downto 0);
        Y : out STD_LOGIC
    );
end or_8input;

architecture Structural of or_8input is

    component or_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    signal o1, o2, o3, o4, o5, o6 : STD_LOGIC;

begin

    -- level 1
    OR1: or_gate port map ( A => A(0), B => A(1), Y => o1 );
    OR2: or_gate port map ( A => A(2), B => A(3), Y => o2 );
    OR3: or_gate port map ( A => A(4), B => A(5), Y => o3 );
    OR4: or_gate port map ( A => A(6), B => A(7), Y => o4 );

    -- level 2
    OR5: or_gate port map ( A => o1, B => o2, Y => o5 );
    OR6: or_gate port map ( A => o3, B => o4, Y => o6 );

    -- level 3
    OR7: or_gate port map ( A => o5, B => o6, Y => Y );

end Structural;
