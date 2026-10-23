----------------------------------------------------------------------------
-- ALU (8-bit, gate level) for Set 4
--   adder_8bit : A + B   (full adders, carry out discarded)
--   and_8bit   : A and B
--   two 8-bit 2:1 muxes choose the result
-- SEL "00" -> B (LDI),  "01" -> A + B (ADD),  "10" -> A and B (AND)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    Port (
        A      : in  STD_LOGIC_VECTOR (7 downto 0);   -- ACC
        B      : in  STD_LOGIC_VECTOR (7 downto 0);   -- operand
        SEL    : in  STD_LOGIC_VECTOR (1 downto 0);
        RESULT : out STD_LOGIC_VECTOR (7 downto 0)
    );
end alu;

architecture Structural of alu is

    component adder_8bit
        Port (
            A    : in  STD_LOGIC_VECTOR (7 downto 0);
            B    : in  STD_LOGIC_VECTOR (7 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR (7 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    component and_8bit
        Port (
            A : in  STD_LOGIC_VECTOR (7 downto 0);
            B : in  STD_LOGIC_VECTOR (7 downto 0);
            Y : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    component mux2_8bit
        Port (
            A : in  STD_LOGIC_VECTOR (7 downto 0);
            B : in  STD_LOGIC_VECTOR (7 downto 0);
            S : in  STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    signal sum_res : STD_LOGIC_VECTOR (7 downto 0);
    signal and_res : STD_LOGIC_VECTOR (7 downto 0);
    signal m1      : STD_LOGIC_VECTOR (7 downto 0);
    signal carry   : STD_LOGIC;                 -- not used (discarded)

begin

    ADD8: adder_8bit port map ( A => A, B => B, Cin => '0', SUM => sum_res, COUT => carry );

    AND8: and_8bit   port map ( A => A, B => B, Y => and_res );

    -- SEL(0) = 0 -> operand (LDI),  1 -> sum (ADD)
    MUX1: mux2_8bit  port map ( A => B,  B => sum_res, S => SEL(0), Y => m1 );

    -- SEL(1) = 0 -> m1,  1 -> AND result
    MUX2: mux2_8bit  port map ( A => m1, B => and_res, S => SEL(1), Y => RESULT );

end Structural;
