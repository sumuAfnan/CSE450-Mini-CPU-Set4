----------------------------------------------------------------------------
-- 2-to-1 Multiplexer (1-bit), gate level
-- Y = (A and not S) or (B and S)      S = 0 -> A,  S = 1 -> B
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_1 is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        S : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end mux2_1;

architecture Structural of mux2_1 is

    component and_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    component or_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    component not_gate
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    signal not_s : STD_LOGIC;
    signal and1  : STD_LOGIC;
    signal and2  : STD_LOGIC;

begin

    N1: not_gate port map ( A => S, Y => not_s );

    A1: and_gate port map ( A => A, B => not_s, Y => and1 );

    A2: and_gate port map ( A => B, B => S, Y => and2 );

    O1: or_gate  port map ( A => and1, B => and2, Y => Y );

end Structural;
