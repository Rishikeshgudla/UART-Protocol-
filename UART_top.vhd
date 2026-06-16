library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_top is
    Port (
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;

        tx_out     : out STD_LOGIC;

        rx_data    : out STD_LOGIC_VECTOR(7 downto 0);
        rx_valid   : out STD_LOGIC
    );
end UART_top;

architecture Behavioral of UART_top is

    signal uart_wire : STD_LOGIC;

begin

    TX_INST : entity work.UART_Tx
        port map(
            clk   => clk,
            reset => reset,
            tx    => uart_wire
        );

    RX_INST : entity work.UART_Rx
        port map(
            clk        => clk,
            reset      => reset,
            rx         => uart_wire,
            data_out   => rx_data,
            data_valid => rx_valid
        );

    tx_out <= uart_wire;

end Behavioral;