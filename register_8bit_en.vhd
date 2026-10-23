----------------------------------------------------------------------------
-- 8-bit register with Enable and synchronous Reset (used for ACC and R)
-- Built from mux2_8bit + 8 x d_flip_flop_reset
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8bit_en is
    Port (
        D     : in  STD_LOGIC_VECTOR (7 downto 0);
        EN    : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR (7 downto 0)
    );
end register_8bit_en;

architecture Structural of register_8bit_en is

    component mux2_8bit
        Port (
            A : in  STD_LOGIC_VECTOR (7 downto 0);
            B : in  STD_LOGIC_VECTOR (7 downto 0);
            S : in  STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    component d_flip_flop_reset
        Port ( D : in STD_LOGIC; CLK : in STD_LOGIC; RESET : in STD_LOGIC; Q : out STD_LOGIC );
    end component;

    signal d_mux : STD_LOGIC_VECTOR (7 downto 0);
    signal q_int : STD_LOGIC_VECTOR (7 downto 0);

begin

    -- EN = 0 : keep old value,  EN = 1 : load D
    MUX: mux2_8bit port map ( A => q_int, B => D, S => EN, Y => d_mux );

    GEN_FF: for i in 0 to 7 generate
        FF: d_flip_flop_reset
            port map (
                D     => d_mux(i),
                CLK   => CLK,
                RESET => RESET,
                Q     => q_int(i)
            );
    end generate;

    Q <= q_int;

end Structural;
