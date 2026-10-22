library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        SUM  : out STD_LOGIC;
        COUT : out STD_LOGIC
    );
end full_adder;

architecture Structural of full_adder is

    component half_adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            SUM  : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component;

    component or_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal sum1 : STD_LOGIC;
    signal cout1 : STD_LOGIC;
    signal cout2 : STD_LOGIC;

begin

    -- First Half Adder
    HA1: half_adder
        port map (
            A    => A,
            B    => B,
            SUM  => sum1,
            COUT => cout1
        );

    -- Second Half Adder
    HA2: half_adder
        port map (
            A    => sum1,
            B    => Cin,
            SUM  => SUM,
            COUT => cout2
        );

    -- OR Gate
    OR1: or_gate
        port map (
            A => cout1,
            B => cout2,
            Y => COUT
        );

end Structural;