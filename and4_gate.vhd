----------------------------------------------------------------------------
-- 4-input AND gate : Y = A and B and C and D  (3 x and_gate)
-- Used by the control unit to decode the opcode
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and4_gate is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        C : in  STD_LOGIC;
        D : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end and4_gate;

architecture Structural of and4_gate is

    component and_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    signal ab : STD_LOGIC;
    signal cd : STD_LOGIC;

begin

    A1: and_gate port map ( A => A,  B => B,  Y => ab );
    A2: and_gate port map ( A => C,  B => D,  Y => cd );
    A3: and_gate port map ( A => ab, B => cd, Y => Y  );

end Structural;
