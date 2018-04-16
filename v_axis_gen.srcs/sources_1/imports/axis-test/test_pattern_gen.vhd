library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity test_pattern_gen is
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
end test_pattern_gen;

architecture rtl of test_pattern_gen is

    signal counter_col, counter_row : integer;
    signal enable_prev : std_logic;
    signal delay        : integer;

    type state_t is (ST_IDLE, ST_RUN, ST_WAIT);
    signal ST   : state_t  := ST_IDLE;

begin

    main: process(clock_i, resetn_i)
    begin
        if (resetn_i='0') then
            counter_col <= 0;
            counter_row <= 0;
            enable_prev <= '0';
            m_axis_video_tvalid <= '0';
            m_axis_video_tdata <= (others => '0');
            m_axis_video_tlast <= '0'; 
            m_axis_video_tuser <= '0';
            delay <= 0;
            ST <= ST_IDLE;
        elsif (clock_i='1' and clock_i'event) then
            if (delay /= 0) then
                delay <= delay - 1;
            else

                case (ST) is
                    when ST_IDLE =>
                        if (enable_i='1') then
                            counter_col <= 0;
                            counter_row <= 0;
                            m_axis_video_tvalid <= '1';
                            m_axis_video_tuser <= '1';
                            m_axis_video_tdata <= x"000000";    -- first pixel
                            ST <= ST_RUN;
                        end if;

                    when ST_RUN =>
                        if (enable_i='0') then
                            m_axis_video_tvalid <= '0';
                            ST <= ST_IDLE;
                        else
                            if (m_axis_video_tready='1') then
                                m_axis_video_tuser <= '0';


                                if ((counter_row >= 0) and  (counter_row < ROWS/3)) then
                                    m_axis_video_tdata <= x"FF0000";
                                elsif ((counter_row >= ROWS/3) and  (counter_row < 2*(ROWS/3))) then
                                    m_axis_video_tdata <= x"00FF00";
                                elsif ((counter_row >= 2*(ROWS/3)) and  (counter_row < ROWS)) then
                                    m_axis_video_tdata <= x"0000FF";
                                end if;


                                if (counter_col=COLUMNS-2) then
                                    m_axis_video_tlast <= '1';
                                    counter_col <= counter_col + 1;
                                elsif (counter_col=COLUMNS-1) then
                                    counter_col <= 0;
                                    m_axis_video_tlast <= '0';
                                    if (counter_row=ROWS-1) then
                                        delay <= 0;                --- DELAY
                                        counter_row <= 0;
                                        m_axis_video_tvalid <= '0';
                                        ST <= ST_IDLE;
                                    else
                                        counter_row <= counter_row + 1;
                                    end if;
                                else
                                    counter_col <= counter_col + 1;
                                end if;
                            end if;
                        end if;

                    when ST_WAIT =>
                        ST <= ST_IDLE;

                end case;


            end if;

        end if;
    end process;


end rtl;