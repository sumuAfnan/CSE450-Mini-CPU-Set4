----------------------------------------------------------------------------
-- Control Unit (gate level) for Set 4
-- Opcode decode with NOT + 4-input AND gates:
--   LDI = 0001   ADD = 0010   AND = 0100   STA = 1010   LDR = 1011
-- Any other opcode -> every output 0 -> NOP
--
-- ALU_SEL(0) = is_ADD, ALU_SEL(1) = is_AND
--     "00" -> operand (LDI), "01" -> ACC + operand, "10" -> ACC and operand
-- ACC_SRC = is_LDR  (ACC gets R instead of the ALU result)
-- ACC_WE  = LDI or ADD or AND or LDR
-- Z_WE    = ACC_WE  (Z is updated whenever ACC is written)
-- R_WE    = is_STA
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port (
        OPCODE  : in  STD_LOGIC_VECTOR (3 downto 0);
        ALU_SEL : out STD_LOGIC_VECTOR (1 downto 0);
        ACC_WE  : out STD_LOGIC;
        ACC_SRC : out STD_LOGIC;
        R_WE    : out STD_LOGIC;
        Z_WE    : out STD_LOGIC
    );
end control_unit;

architecture Structural of control_unit is

    component not_gate
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    component or_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    component and4_gate
        Port ( A, B, C, D : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    signal n0, n1, n2, n3 : STD_LOGIC;                  -- inverted opcode bits
    signal is_ldi, is_add, is_and, is_sta, is_ldr : STD_LOGIC;
    signal w1, w2, we : STD_LOGIC;

begin

    -- inverted opcode bits
    N_0: not_gate port map ( A => OPCODE(0), Y => n0 );
    N_1: not_gate port map ( A => OPCODE(1), Y => n1 );
    N_2: not_gate port map ( A => OPCODE(2), Y => n2 );
    N_3: not_gate port map ( A => OPCODE(3), Y => n3 );

    -- decoder                      bit3        bit2        bit1        bit0
    D_LDI: and4_gate port map ( A => n3,        B => n2,        C => n1,        D => OPCODE(0), Y => is_ldi ); -- 0001
    D_ADD: and4_gate port map ( A => n3,        B => n2,        C => OPCODE(1), D => n0,        Y => is_add ); -- 0010
    D_AND: and4_gate port map ( A => n3,        B => OPCODE(2), C => n1,        D => n0,        Y => is_and ); -- 0100
    D_STA: and4_gate port map ( A => OPCODE(3), B => n2,        C => OPCODE(1), D => n0,        Y => is_sta ); -- 1010
    D_LDR: and4_gate port map ( A => OPCODE(3), B => n2,        C => OPCODE(1), D => OPCODE(0), Y => is_ldr ); -- 1011

    -- ACC write enable = LDI or ADD or AND or LDR
    O1: or_gate port map ( A => is_ldi, B => is_add, Y => w1 );
    O2: or_gate port map ( A => is_and, B => is_ldr, Y => w2 );
    O3: or_gate port map ( A => w1,     B => w2,     Y => we );

    ALU_SEL(0) <= is_add;
    ALU_SEL(1) <= is_and;
    ACC_SRC    <= is_ldr;
    ACC_WE     <= we;
    Z_WE       <= we;
    R_WE       <= is_sta;

end Structural;
