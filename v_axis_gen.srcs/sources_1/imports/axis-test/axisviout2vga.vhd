library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity axisviout2vga is
    port (  
        
        vid_clock       : in STD_LOGIC;
        vid_active_video : in STD_LOGIC;
        vid_vsync       : in STD_LOGIC;
        vid_hsync       : in STD_LOGIC;
        vid_data        : in STD_LOGIC_VECTOR ( 23 downto 0 );

        vga_red         : out STD_LOGIC_VECTOR(3 downto 0);
        vga_green       : out STD_LOGIC_VECTOR(3 downto 0);
        vga_blue        : out STD_LOGIC_VECTOR(3 downto 0);
        vga_hsync       : out STD_LOGIC;
        vga_vsync       : out STD_LOGIC

    );
end axisviout2vga;

architecture rtl of axisviout2vga is

begin
    main: process(vid_clock)
    begin
        if (vid_clock='1' and vid_clock'event) then
            vga_hsync <= not vid_hsync;
            vga_vsync <= not vid_vsync;
            if (vid_active_video='1') then
                vga_blue <= vid_data(23 downto 20);
                vga_green <= vid_data(15 downto 12);
                vga_red <= vid_data(7 downto 4);
            else
                vga_blue <= (others => '0');
                vga_green <= (others => '0');
                vga_red <= (others => '0');                 
            end if;    
        end if;
    end process;


end rtl;