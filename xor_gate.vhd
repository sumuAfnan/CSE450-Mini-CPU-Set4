library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end xor_gate;

architecture Structural of xor_gate is

    component and_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component or_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component not_gate
        Port (
            A : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal not_a : STD_LOGIC;
    signal not_b : STD_LOGIC;
    signal and1  : STD_LOGIC;
    signal and2  : STD_LOGIC;

begin

    -- NOT gates
    N1: not_gate
        port map (
            A => A,
            Y => not_a
        );

    N2: not_gate
        port map (
            A => B,
            Y => not_b
        );

    -- AND gates
    A1: and_gate
        port map (
            A => A,
            B => not_b,
            Y => and1
        );

    A2: and_gate
        port map (
            A => not_a,
            B => B,
            Y => and2
        );

    -- OR gate
    O1: or_gate
        port map (
            A => and1,
            B => and2,
            Y => Y
        );

end Structural;