library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity v_axis_gen is
    port (  CLK_I : in  std_logic;
            VGA_R   : out std_logic_vector(3 downto 0);
            VGA_G   : out std_logic_vector(3 downto 0);
            VGA_B   : out std_logic_vector(3 downto 0);
            VGA_HS_O  : out std_logic;
            VGA_VS_O  : out std_logic
    );
end v_axis_gen;


architecture rtl of v_axis_gen is

----------------
-- Components --
----------------


component test_pattern_gen is
    generic (
        ROWS        : natural := 480;
        COLUMNS     : natural := 640
    );
    port ( 
        clock_i     : in std_logic;
        resetn_i    : in std_logic;
        enable_i    : in std_logic;

        m_axis_video_tdata  : out std_logic_vector(23 downto 0);
        m_axis_video_tvalid : out std_logic;
        m_axis_video_tready : in std_logic;
        m_axis_video_tlast  : out std_logic;
        m_axis_video_tuser  : out std_logic
    );
end component test_pattern_gen;


component v_tc_0 IS
    port (
        clk : IN STD_LOGIC;
        clken : IN STD_LOGIC;
        gen_clken : IN STD_LOGIC;
        hsync_out : OUT STD_LOGIC;
        hblank_out : OUT STD_LOGIC;
        vsync_out : OUT STD_LOGIC;
        vblank_out : OUT STD_LOGIC;
        active_video_out : OUT STD_LOGIC;
        resetn : IN STD_LOGIC;
        fsync_out : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
    );
end component v_tc_0;




component v_axi4s_vid_out_0 is
    port ( 
        aclk : in STD_LOGIC;
        aclken : in STD_LOGIC;
        aresetn : in STD_LOGIC;
        s_axis_video_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
        s_axis_video_tvalid : in STD_LOGIC;
        s_axis_video_tready : out STD_LOGIC;
        s_axis_video_tuser : in STD_LOGIC;
        s_axis_video_tlast : in STD_LOGIC;
        fid : in STD_LOGIC;
        vid_io_out_ce : in STD_LOGIC;
        vid_active_video : out STD_LOGIC;
        vid_vsync : out STD_LOGIC;
        vid_hsync : out STD_LOGIC;
        vid_vblank : out STD_LOGIC;
        vid_hblank : out STD_LOGIC;
        vid_field_id : out STD_LOGIC;
        vid_data : out STD_LOGIC_VECTOR ( 23 downto 0 );
        vtg_vsync : in STD_LOGIC;
        vtg_hsync : in STD_LOGIC;
        vtg_vblank : in STD_LOGIC;
        vtg_hblank : in STD_LOGIC;
        vtg_active_video : in STD_LOGIC;
        vtg_field_id : in STD_LOGIC;
        vtg_ce : out STD_LOGIC;
        locked : out STD_LOGIC;
        overflow : out STD_LOGIC;
        underflow : out STD_LOGIC;
        status : out STD_LOGIC_VECTOR ( 31 downto 0 )
    );
    end component v_axi4s_vid_out_0;

    component clk_wiz_0 is
    port ( 
        clk_out1 : out STD_LOGIC;
        clk_in1 : in STD_LOGIC
    );
    end component clk_wiz_0;


    component axisviout2vga is
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
    end component axisviout2vga;

    component resetgen is
    port (  
        clock_in    : in std_logic;
        clock_out   : out std_logic;
        resetn_out  : out std_logic

    );
    end component resetgen;


-------------
-- Signals --
-------------

    signal vtg_ce       : std_logic;

    signal axis_video_tdata     : STD_LOGIC_VECTOR ( 23 downto 0 );
    signal axis_video_tvalid    : STD_LOGIC;
    signal axis_video_tready    : STD_LOGIC;
    signal axis_video_tuser     : STD_LOGIC;
    signal axis_video_tlast     : STD_LOGIC;

    signal vtg_vsync : STD_LOGIC;
    signal vtg_hsync : STD_LOGIC;
    signal vtg_vblank : STD_LOGIC;
    signal vtg_hblank : STD_LOGIC;
    signal vtg_active_video : std_logic;

    signal clock_video  : std_logic;

    signal vid_active_video : std_logic;
    signal vid_vsync    : std_logic;
    signal vid_hsync    : std_logic;
    signal vid_data     : std_logic_vector(23 downto 0);

    signal enable       : std_logic;
    signal clk25M       : std_logic;
    signal resetn       : std_logic;

begin


    enable <= resetn;

    test_pattern_gen_i1 : test_pattern_gen
    generic map (
        ROWS    => 480,
        COLUMNS => 640
    )
    port map ( 
        clock_i     => clock_video,
        resetn_i    => resetn,
        enable_i    => enable,
        m_axis_video_tdata  => axis_video_tdata,
        m_axis_video_tvalid => axis_video_tvalid,
        m_axis_video_tready => axis_video_tready,
        m_axis_video_tlast  => axis_video_tlast,
        m_axis_video_tuser  => axis_video_tuser
    );


v_tc_0_i1 : v_tc_0
    port map (
        clk         => clock_video,
        clken       => '1',
        gen_clken   => vtg_ce,
        hsync_out   => vtg_hsync,
        hblank_out  => vtg_hblank,
        vsync_out   => vtg_vsync,
        vblank_out  => vtg_vblank,
        active_video_out => vtg_active_video,
        resetn => resetn,
        fsync_out => open
  );


v_axi4s_vid_out_0_i1 : v_axi4s_vid_out_0 
    port map ( 
        aclk    => clock_video,
        aclken  => '1',
        aresetn => resetn,
        s_axis_video_tdata  => axis_video_tdata,
        s_axis_video_tvalid => axis_video_tvalid,
        s_axis_video_tready => axis_video_tready,
        s_axis_video_tuser  => axis_video_tuser,
        s_axis_video_tlast  => axis_video_tlast,
        fid     => '0',
        vid_io_out_ce => '1',
        vid_active_video => vid_active_video,
        vid_vsync => vid_vsync,
        vid_hsync => vid_hsync,
        vid_vblank => open,
        vid_hblank => open,
        vid_field_id => open,
        vid_data => vid_data,
        vtg_vsync => vtg_vsync,
        vtg_hsync => vtg_hsync,
        vtg_vblank => vtg_vblank,
        vtg_hblank => vtg_hblank,
        vtg_active_video => vtg_active_video,
        vtg_field_id    => '0',
        vtg_ce  => vtg_ce,
        locked  => open,
        overflow => open,
        underflow => open,
        status => open
  );


    axisviout2vga_i1 : axisviout2vga
    port map (  
        vid_clock       => clock_video,
        vid_active_video=> vid_active_video,
        vid_vsync       => vid_vsync,
        vid_hsync       => vid_hsync,
        vid_data        => vid_data,
        vga_red         => VGA_R,
        vga_green       => VGA_G,
        vga_blue        => VGA_B,
        vga_hsync       => VGA_HS_O,
        vga_vsync       => VGA_VS_O
    );


    clk_wiz_0_i1 : clk_wiz_0
    port map ( 
        clk_out1    => clk25M,
        clk_in1     => CLK_I
    );

    resetgen_i1 : resetgen
    port map (  
        clock_in   => clk25M,
        clock_out  => clock_video,
        resetn_out => resetn

    );

end rtl;