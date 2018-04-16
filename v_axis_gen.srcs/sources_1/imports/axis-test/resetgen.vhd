library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity resetgen is
    port (  
            clock_in    : in std_logic;
            clock_out   : out std_logic;
            resetn_out  : out std_logic

    );
end resetgen;

architecture rtl of resetgen is


    signal resetn   : std_logic := '0';
    signal counter  : integer range 0 to 1023 := 0;
    signal clock_ok : std_logic := '0';
    signal clock_local : std_logic := '0';


begin

    clock_local <= clock_in and clock_ok;
    resetn_out <= resetn;

    main: process(clock_in)
    begin
        if (clock_in='1' and clock_in'event) then  
            if (counter < 1022) then
                counter <= counter + 1;
            end if;             

            if (counter=1000) then
                resetn <= '1';
            end if;

            if (counter=1022) then
                clock_ok <= '1';
            end if;
        end if;
    end process;


BUFG_inst : BUFG
    port map (
        O => clock_out,
        I => clock_local
    );


end rtl;