----------------------------------------------------------------------------
-- Testbench for cpu_top (Set 4)
-- Clock period 20 ns. RESET = 1 for the first rising edge (10 ns),
-- then 10 instructions are executed and checked against Appendix B.
-- Total simulation time needed : about 230 ns (run 250 ns)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_cpu_top is
end tb_cpu_top;

architecture behavior of tb_cpu_top is

    component cpu_top
        Port ( CLK, RESET : in STD_LOGIC;
               Q  : out STD_LOGIC_VECTOR (7 downto 0);
               Z  : out STD_LOGIC;
               PC : out STD_LOGIC_VECTOR (3 downto 0);
               R  : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '1';
    signal Q     : STD_LOGIC_VECTOR (7 downto 0);
    signal Z     : STD_LOGIC;
    signal PC    : STD_LOGIC_VECTOR (3 downto 0);
    signal R     : STD_LOGIC_VECTOR (7 downto 0);

    constant CLK_PERIOD : time := 20 ns;

    -- expected values after each rising edge (cycle 1 .. 10)
    type byte_arr is array (1 to 10) of STD_LOGIC_VECTOR (7 downto 0);
    type bit_arr  is array (1 to 10) of STD_LOGIC;
    type pc_arr   is array (1 to 10) of STD_LOGIC_VECTOR (3 downto 0);

    constant EXP_ACC : byte_arr := (x"1E", x"1E", x"40", x"40", x"1E",
                                    x"1F", x"0F", x"0F", x"00", x"0F");
    constant EXP_Z   : bit_arr  := ('0','0','0','0','0','0','0','0','1','0');
    constant EXP_R   : byte_arr := (x"00", x"1E", x"1E", x"1E", x"1E",
                                    x"1E", x"1E", x"0F", x"0F", x"0F");
    constant EXP_PC  : pc_arr   := ("0001","0010","0011","0100","0101",
                                    "0110","0111","1000","1001","1010");

    signal sim_done : boolean := false;

begin

    UUT : cpu_top port map (CLK => CLK, RESET => RESET,
                            Q => Q, Z => Z, PC => PC, R => R);

    -- clock generator
    clk_process : process
    begin
        while not sim_done loop
            CLK <= '0'; wait for CLK_PERIOD/2;
            CLK <= '1'; wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;

    -- stimulus + checking
    stim_proc : process
        variable errors : integer := 0;
    begin
        RESET <= '1';
        wait until rising_edge(CLK);          -- cycle 0 : reset edge
        wait for 5 ns;
        assert (Q = x"00" and Z = '1' and R = x"00" and PC = "0000")
            report "Reset check FAILED" severity error;
        RESET <= '0';

        for i in 1 to 10 loop
            wait until rising_edge(CLK);
            wait for 5 ns;                    -- let outputs settle
            if Q /= EXP_ACC(i) or Z /= EXP_Z(i) or
               R /= EXP_R(i)   or PC /= EXP_PC(i) then
                report "Cycle " & integer'image(i) & " FAILED" severity error;
                errors := errors + 1;
            else
                report "Cycle " & integer'image(i) & " OK" severity note;
            end if;
        end loop;

        if errors = 0 then
            report "ALL 10 INSTRUCTIONS PASSED" severity note;
        else
            report "TEST FAILED, errors = " & integer'image(errors) severity error;
        end if;

        sim_done <= true;
        wait;
    end process;

end behavior;
