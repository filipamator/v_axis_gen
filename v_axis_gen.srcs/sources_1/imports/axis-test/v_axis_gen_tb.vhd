library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity v_axis_gen_tb is
end v_axis_gen_tb;

architecture Behavioral of v_axis_gen_tb is

component v_axis_gen is
    port (  CLK_I : in  std_logic;
            VGA_R   : out std_logic_vector(3 downto 0);
            VGA_G   : out std_logic_vector(3 downto 0);
            VGA_B   : out std_logic_vector(3 downto 0);
            VGA_HS_O  : out std_logic;
            VGA_VS_O  : out std_logic
    );
end component v_axis_gen;


    signal tb_clock     : std_logic := '0';
    signal tb_resetn    : std_logic;


begin

    tb_clock <= not tb_clock after 5 ns;

    resetgen: process
    begin
        tb_resetn <= '0';
        wait for 200 ns;
        wait until rising_edge(tb_clock);
        tb_resetn <= '1';
        wait;
    end process;

    v_axis_gen_i1 : v_axis_gen
    port map (  CLK_I  => tb_clock
    );


end Behavioral;