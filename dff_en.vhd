----------------------------------------------------------------------------
-- 1-bit register with Enable and synchronous Reset
-- EN = 1 -> Q takes D at the rising edge,  EN = 0 -> Q keeps its value
-- Built from mux2_1 + d_flip_flop_reset
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_en is
    Port (
        D     : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end dff_en;

architecture Structural of dff_en is

    component mux2_1
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; S : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    component d_flip_flop_reset
        Port ( D : in STD_LOGIC; CLK : in STD_LOGIC; RESET : in STD_LOGIC; Q : out STD_LOGIC );
    end component;

    signal d_mux : STD_LOGIC;
    signal q_int : STD_LOGIC;

begin

    -- EN = 0 : feed old value back,  EN = 1 : new value
    M1: mux2_1 port map ( A => q_int, B => D, S => EN, Y => d_mux );

    FF: d_flip_flop_reset port map ( D => d_mux, CLK => CLK, RESET => RESET, Q => q_int );

    Q <= q_int;

end Structural;
