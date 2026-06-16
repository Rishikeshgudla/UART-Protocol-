library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UART_Rx is
    Port (
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        rx         : in  STD_LOGIC;

        data_out   : out STD_LOGIC_VECTOR(7 downto 0);
        data_valid : out STD_LOGIC
    );
end UART_Rx;

architecture Behavioral of UART_Rx is

    constant CLK_FREQ  : integer := 100_000_000;
    constant BAUD_RATE : integer := 9600;

    constant BAUD_TICK : integer := CLK_FREQ / BAUD_RATE;
    constant HALF_BAUD : integer := BAUD_TICK / 2;

    type state_type is (
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    );

    signal state : state_type := IDLE;

    signal baud_counter : integer := 0;
    signal bit_index : integer range 0 to 7 := 0;

    signal rx_data : STD_LOGIC_VECTOR(7 downto 0)
                     := (others => '0');

begin

    data_out <= rx_data;

    process(clk, reset)
    begin
        if reset = '1' then

            state <= IDLE;
            baud_counter <= 0;
            bit_index <= 0;
            data_valid <= '0';

        elsif rising_edge(clk) then

            data_valid <= '0';

            case state is

                when IDLE =>

                    if rx = '0' then
                        baud_counter <= 0;
                        state <= START_BIT;
                    end if;

                when START_BIT =>

                    if baud_counter = HALF_BAUD then

                        if rx = '0' then
                            baud_counter <= 0;
                            bit_index <= 0;
                            state <= DATA_BITS;
                        else
                            state <= IDLE;
                        end if;

                    else
                        baud_counter <= baud_counter + 1;
                    end if;

                when DATA_BITS =>

                    if baud_counter = BAUD_TICK-1 then

                        baud_counter <= 0;

                        rx_data(bit_index) <= rx;

                        if bit_index = 7 then
                            bit_index <= 0;
                            state <= STOP_BIT;
                        else
                            bit_index <= bit_index + 1;
                        end if;

                    else
                        baud_counter <= baud_counter + 1;
                    end if;

                when STOP_BIT =>

                    if baud_counter = BAUD_TICK-1 then

                        baud_counter <= 0;

                        if rx = '1' then
                            data_valid <= '1';
                        end if;

                        state <= IDLE;

                    else
                        baud_counter <= baud_counter + 1;
                    end if;

            end case;

        end if;
    end process;

end Behavioral;