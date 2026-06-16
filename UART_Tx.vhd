library IEEE ;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UART_Tx is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        tx      : out STD_LOGIC
    );
end UART_Tx;

architecture Behavioral of UART_Tx is

    constant CLK_FREQ      : integer := 100_000_000;
    constant BAUD_RATE     : integer := 9600;

    constant BAUD_TICK     : integer := CLK_FREQ / BAUD_RATE;
    constant DELAY_1MS     : integer := CLK_FREQ / 2000;

    type state_type is (
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT,
        DELAY_STATE
    );

    signal state : state_type := IDLE;

    signal baud_counter  : integer := 0;
    signal delay_counter : integer := 0;

    signal bit_index : integer range 0 to 7 := 0;

    constant DATA_BYTE : STD_LOGIC_VECTOR(7 downto 0)
                        := "01100001";

    signal tx_reg : STD_LOGIC := '1';

begin

    tx <= tx_reg;

    process(clk, reset)
    begin
        if reset = '1' then

            state <= IDLE;
            tx_reg <= '1';
            baud_counter <= 0;
            delay_counter <= 0;
            bit_index <= 0;

        elsif rising_edge(clk) then

            case state is

                when IDLE =>
                    tx_reg <= '1';
                    baud_counter <= 0;
                    bit_index <= 0;
                    state <= START_BIT;

                when START_BIT =>

                    tx_reg <= '0';

                    if baud_counter = BAUD_TICK-1 then
                        baud_counter <= 0;
                        state <= DATA_BITS;
                    else
                        baud_counter <= baud_counter + 1;
                    end if;

                when DATA_BITS =>

                    tx_reg <= DATA_BYTE(bit_index);

                    if baud_counter = BAUD_TICK-1 then

                        baud_counter <= 0;

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

                    tx_reg <= '1';

                    if baud_counter = BAUD_TICK-1 then
                        baud_counter <= 0;
                        delay_counter <= 0;
                        state <= DELAY_STATE;
                    else
                        baud_counter <= baud_counter + 1;
                    end if;

                when DELAY_STATE =>

                    tx_reg <= '1';

                    if delay_counter = DELAY_1MS-1 then
                        delay_counter <= 0;
                        state <= START_BIT;
                    else
                        delay_counter <= delay_counter + 1;
                    end if;

            end case;

        end if;
    end process;

end Behavioral;