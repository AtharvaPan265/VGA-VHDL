library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Clock_div is
    Port (
        clk  : in  std_logic;
        div : out std_logic
    );
end Clock_div;
architecture Clock_div of Clock_div is
    signal counter : std_logic_vector(26 downto 0) := (others => '0');
    signal temp_clk: std_logic := '0' ;
begin
    process (clk )
    begin
        if (rising_edge(clk)) then
        counter  <= std_logic_vector(unsigned(counter) + 1);
            if (unsigned(counter) = 4) then
                temp_clk <= '1';
                counter <= (others => '0');
            else
                temp_clk <= '0';
            end if;
        end if;
    end process;
    div <= temp_clk;
end Clock_div;