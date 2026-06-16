library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UART_top_tb is
end UART_top_tb;

architecture Behavioral of UART_top_tb is

    --------------------------------------------------------------------
    -- DUT Signals
    --------------------------------------------------------------------
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '1';

    signal tx_out   : std_logic;

    signal rx_data  : std_logic_vector(7 downto 0);
    signal rx_valid : std_logic;

    --------------------------------------------------------------------
    -- Clock Period
    --------------------------------------------------------------------
    constant CLK_PERIOD : time := 10 ns; -- 100 MHz

begin

    --------------------------------------------------------------------
    -- Instantiate DUT
    --------------------------------------------------------------------
    DUT : entity work.uart_top
        port map (
            clk      => clk,
            reset    => reset,
            tx_out   => tx_out,
            rx_data  => rx_data,
            rx_valid => rx_valid
        );

    --------------------------------------------------------------------
    -- Clock Generation
    --------------------------------------------------------------------
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD/2;

            clk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    --------------------------------------------------------------------
    -- Reset Generation
    --------------------------------------------------------------------
    reset_process : process
    begin
        reset <= '1';
        wait for 100 ns;

        reset <= '0';

        wait;
    end process;

    --------------------------------------------------------------------
    -- Monitor Received Data
    --------------------------------------------------------------------
    monitor_process : process(clk)
    begin
        if rising_edge(clk) then

            if rx_valid = '1' then

                report "Received Data = "
                       & integer'image(
                           to_integer(unsigned(rx_data))
                         );

                if rx_data = "01100001" then
                    report "PASS : Correct Data Received (01100001)"
                           severity note;
                else
                    report "FAIL : Incorrect Data Received"
                           severity error;
                end if;

            end if;

        end if;
    end process;

    --------------------------------------------------------------------
    -- Simulation Control
    --------------------------------------------------------------------
    sim_process : process
    begin

        -- Run long enough to see several packets
        wait for 100 ms;

        report "Simulation Finished"
               severity note;

        wait;

    end process;

end Behavioral;