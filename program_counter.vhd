----------------------------------------------------------------------------
-- Program Counter (4-bit) : register_4bit + incrementer_4bit
-- Synchronous active-high RESET -> PC = 0, otherwise PC <- PC + 1
-- (Set 4 has no JZ, so the PC only increments)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity program_counter is
    Port (
        CLK    : in  STD_LOGIC;
        RESET  : in  STD_LOGIC;
        PC_OUT : out STD_LOGIC_VECTOR (3 downto 0)
    );
end program_counter;

architecture Structural of program_counter is

    component register_4bit
        Port (
            D     : in  STD_LOGIC_VECTOR (3 downto 0);
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component incrementer_4bit
        Port (
            A : in  STD_LOGIC_VECTOR (3 downto 0);
            Y : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal pc_q    : STD_LOGIC_VECTOR (3 downto 0);
    signal pc_next : STD_LOGIC_VECTOR (3 downto 0);

begin

    INC: incrementer_4bit port map ( A => pc_q, Y => pc_next );

    REG: register_4bit port map ( D => pc_next, CLK => CLK, RESET => RESET, Q => pc_q );

    PC_OUT <= pc_q;

end Structural;
