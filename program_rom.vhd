----------------------------------------------------------------------------
-- Program ROM : 16 x 12-bit, combinational read
-- Holds the Appendix B program for Set 4. Unused locations = 0x000 (NOP)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_rom is
    Port ( addr  : in  STD_LOGIC_VECTOR (3 downto 0);
           instr : out STD_LOGIC_VECTOR (11 downto 0));
end program_rom;

architecture Behavioral of program_rom is
    type rom_type is array (0 to 15) of STD_LOGIC_VECTOR (11 downto 0);
    constant ROM : rom_type := (
        0  => x"11E",   -- LDI 0x1E
        1  => x"A00",   -- STA
        2  => x"222",   -- ADD 0x22
        3  => x"460",   -- AND 0x60
        4  => x"B00",   -- LDR
        5  => x"201",   -- ADD 0x01
        6  => x"40F",   -- AND 0x0F
        7  => x"A00",   -- STA
        8  => x"100",   -- LDI 0x00
        9  => x"B00",   -- LDR
        others => x"000" -- NOP
    );
begin
    instr <= ROM(to_integer(unsigned(addr)));
end Behavioral;
