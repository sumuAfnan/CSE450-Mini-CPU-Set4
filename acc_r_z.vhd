----------------------------------------------------------------------------
-- ACC (8-bit), R (8-bit) and Z flag, gate level
--
-- ACC_NEXT = R when ACC_SRC = 1 (LDR), else ALU result       (mux2_8bit)
-- ACC      : register_8bit_en, loads ACC_NEXT when ACC_WE = 1
-- R        : register_8bit_en, loads ACC      when R_WE   = 1 (STA)
--
-- Z flag   : RESET must make Z = 1, but d_flip_flop_reset resets to 0.
--            So the flip-flop stores ZBAR (= "ACC is not zero"),
--            and Z = NOT ZBAR.  After RESET : ZBAR = 0 -> Z = 1.
--            ZBAR_NEXT = OR of all 8 bits of ACC_NEXT   (or_8input)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_r_z is
    Port (
        CLK        : in  STD_LOGIC;
        RESET      : in  STD_LOGIC;
        ALU_RESULT : in  STD_LOGIC_VECTOR (7 downto 0);
        ACC_WE     : in  STD_LOGIC;
        ACC_SRC    : in  STD_LOGIC;
        R_WE       : in  STD_LOGIC;
        Z_WE       : in  STD_LOGIC;
        ACC_OUT    : out STD_LOGIC_VECTOR (7 downto 0);
        R_OUT      : out STD_LOGIC_VECTOR (7 downto 0);
        Z_OUT      : out STD_LOGIC
    );
end acc_r_z;

architecture Structural of acc_r_z is

    component mux2_8bit
        Port (
            A : in  STD_LOGIC_VECTOR (7 downto 0);
            B : in  STD_LOGIC_VECTOR (7 downto 0);
            S : in  STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    component register_8bit_en
        Port (
            D     : in  STD_LOGIC_VECTOR (7 downto 0);
            EN    : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    component or_8input
        Port ( A : in STD_LOGIC_VECTOR (7 downto 0); Y : out STD_LOGIC );
    end component;

    component dff_en
        Port ( D, EN, CLK, RESET : in STD_LOGIC; Q : out STD_LOGIC );
    end component;

    component not_gate
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    signal acc_next : STD_LOGIC_VECTOR (7 downto 0);
    signal acc_q    : STD_LOGIC_VECTOR (7 downto 0);
    signal r_q      : STD_LOGIC_VECTOR (7 downto 0);
    signal nonzero  : STD_LOGIC;
    signal zbar     : STD_LOGIC;

begin

    -- select what goes into ACC
    SRC_MUX: mux2_8bit port map ( A => ALU_RESULT, B => r_q, S => ACC_SRC, Y => acc_next );

    -- accumulator
    ACC_REG: register_8bit_en
        port map ( D => acc_next, EN => ACC_WE, CLK => CLK, RESET => RESET, Q => acc_q );

    -- holding register R  (STA : R <- ACC)
    R_REG: register_8bit_en
        port map ( D => acc_q, EN => R_WE, CLK => CLK, RESET => RESET, Q => r_q );

    -- zero detection of the value being written to ACC
    NZ: or_8input port map ( A => acc_next, Y => nonzero );

    ZFF: dff_en port map ( D => nonzero, EN => Z_WE, CLK => CLK, RESET => RESET, Q => zbar );

    ZN: not_gate port map ( A => zbar, Y => Z_OUT );

    ACC_OUT <= acc_q;
    R_OUT   <= r_q;

end Structural;
