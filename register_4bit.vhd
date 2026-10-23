----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:41:16 10/04/2026 
-- Design Name: 
-- Module Name:    register_4bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_4bit is
    Port (
        D     : in  STD_LOGIC_VECTOR (3 downto 0);
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR (3 downto 0)
    );
end register_4bit;

architecture Structural of register_4bit is

    component d_flip_flop_reset
        Port (
            D     : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC
        );
    end component;

begin

    DFF0: d_flip_flop_reset
        port map (
            D     => D(0),
            CLK   => CLK,
            RESET => RESET,
            Q     => Q(0)
        );

    DFF1: d_flip_flop_reset
        port map (
            D     => D(1),
            CLK   => CLK,
            RESET => RESET,
            Q     => Q(1)
        );

    DFF2: d_flip_flop_reset
        port map (
            D     => D(2),
            CLK   => CLK,
            RESET => RESET,
            Q     => Q(2)
        );

    DFF3: d_flip_flop_reset
        port map (
            D     => D(3),
            CLK   => CLK,
            RESET => RESET,
            Q     => Q(3)
        );

end Structural;