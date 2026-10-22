library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_4bit is
    Port (
        A    : in  STD_LOGIC_VECTOR (3 downto 0);
        B    : in  STD_LOGIC_VECTOR (3 downto 0);
        Cin  : in  STD_LOGIC;
        SUM  : out STD_LOGIC_VECTOR (3 downto 0);
        COUT : out STD_LOGIC
    );
end adder_4bit;

architecture Structural of adder_4bit is

    component full_adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component;

    signal C1 : STD_LOGIC;
    signal C2 : STD_LOGIC;
    signal C3 : STD_LOGIC;

begin

    FA0: full_adder
        port map (
            A    => A(0),
            B    => B(0),
            Cin  => Cin,
            SUM  => SUM(0),
            COUT => C1
        );

    FA1: full_adder
        port map (
            A    => A(1),
            B    => B(1),
            Cin  => C1,
            SUM  => SUM(1),
            COUT => C2
        );

    FA2: full_adder
        port map (
            A    => A(2),
            B    => B(2),
            Cin  => C2,
            SUM  => SUM(2),
            COUT => C3
        );

    FA3: full_adder
        port map (
            A    => A(3),
            B    => B(3),
            Cin  => C3,
            SUM  => SUM(3),
            COUT => COUT
        );

end Structural;