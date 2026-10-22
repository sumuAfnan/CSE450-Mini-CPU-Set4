library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_8bit is
    Port (
        A    : in  STD_LOGIC_VECTOR (7 downto 0);
        B    : in  STD_LOGIC_VECTOR (7 downto 0);
        Cin  : in  STD_LOGIC;
        SUM  : out STD_LOGIC_VECTOR (7 downto 0);
        COUT : out STD_LOGIC
    );
end adder_8bit;

architecture Structural of adder_8bit is

    component adder_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR (3 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    signal C4 : STD_LOGIC;

begin

    -- Lower 4 bits
    ADD_LOW: adder_4bit
        port map (
            A    => A(3 downto 0),
            B    => B(3 downto 0),
            Cin  => Cin,
            SUM  => SUM(3 downto 0),
            COUT => C4
        );

    -- Upper 4 bits
    ADD_HIGH: adder_4bit
        port map (
            A    => A(7 downto 4),
            B    => B(7 downto 4),
            Cin  => C4,
            SUM  => SUM(7 downto 4),
            COUT => COUT
        );

end Structural;