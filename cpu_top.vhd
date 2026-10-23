----------------------------------------------------------------------------
-- Top level : Mini 8-bit Accumulator CPU (Set 4 : LDI, ADD, STA, LDR, AND)
-- Structural connection of PC, Program ROM, Control Unit, ALU and ACC/R/Z
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top is
    Port (
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR (7 downto 0);   -- ACC
        Z     : out STD_LOGIC;
        PC    : out STD_LOGIC_VECTOR (3 downto 0);
        R     : out STD_LOGIC_VECTOR (7 downto 0)    -- for checking
    );
end cpu_top;

architecture Structural of cpu_top is

    component program_counter
        Port (
            CLK    : in  STD_LOGIC;
            RESET  : in  STD_LOGIC;
            PC_OUT : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component program_rom
        Port (
            addr  : in  STD_LOGIC_VECTOR (3 downto 0);
            instr : out STD_LOGIC_VECTOR (11 downto 0)
        );
    end component;

    component control_unit
        Port (
            OPCODE  : in  STD_LOGIC_VECTOR (3 downto 0);
            ALU_SEL : out STD_LOGIC_VECTOR (1 downto 0);
            ACC_WE  : out STD_LOGIC;
            ACC_SRC : out STD_LOGIC;
            R_WE    : out STD_LOGIC;
            Z_WE    : out STD_LOGIC
        );
    end component;

    component alu
        Port (
            A      : in  STD_LOGIC_VECTOR (7 downto 0);
            B      : in  STD_LOGIC_VECTOR (7 downto 0);
            SEL    : in  STD_LOGIC_VECTOR (1 downto 0);
            RESULT : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    component acc_r_z
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
    end component;

    signal pc_s      : STD_LOGIC_VECTOR (3 downto 0);
    signal instr_s   : STD_LOGIC_VECTOR (11 downto 0);
    signal alu_sel_s : STD_LOGIC_VECTOR (1 downto 0);
    signal acc_we_s, acc_src_s, r_we_s, z_we_s : STD_LOGIC;
    signal alu_res_s : STD_LOGIC_VECTOR (7 downto 0);
    signal acc_s     : STD_LOGIC_VECTOR (7 downto 0);
    signal r_s       : STD_LOGIC_VECTOR (7 downto 0);
    signal z_s       : STD_LOGIC;

begin

    U_PC: program_counter
        port map ( CLK => CLK, RESET => RESET, PC_OUT => pc_s );

    U_ROM: program_rom
        port map ( addr => pc_s, instr => instr_s );

    U_CU: control_unit
        port map (
            OPCODE  => instr_s(11 downto 8),
            ALU_SEL => alu_sel_s,
            ACC_WE  => acc_we_s,
            ACC_SRC => acc_src_s,
            R_WE    => r_we_s,
            Z_WE    => z_we_s
        );

    U_ALU: alu
        port map (
            A      => acc_s,
            B      => instr_s(7 downto 0),
            SEL    => alu_sel_s,
            RESULT => alu_res_s
        );

    U_REG: acc_r_z
        port map (
            CLK        => CLK,
            RESET      => RESET,
            ALU_RESULT => alu_res_s,
            ACC_WE     => acc_we_s,
            ACC_SRC    => acc_src_s,
            R_WE       => r_we_s,
            Z_WE       => z_we_s,
            ACC_OUT    => acc_s,
            R_OUT      => r_s,
            Z_OUT      => z_s
        );

    Q  <= acc_s;
    Z  <= z_s;
    PC <= pc_s;
    R  <= r_s;

end Structural;
