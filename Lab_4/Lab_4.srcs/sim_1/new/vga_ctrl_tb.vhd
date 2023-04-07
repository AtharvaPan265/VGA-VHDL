 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl_tb is
--  Port ( );
end vga_ctrl_tb;

architecture Behavioral of vga_ctrl_tb is
    signal t_clk, t_en        : std_logic := '0';
    signal t_vid, t_hs, t_vs  : std_logic;
    signal t_hcount, t_vcount : std_logic_vector(9 downto 0);

    component vga_ctrl is
        Port (
            clk, en       : in  std_logic;
            hcount, vcount: out std_logic_vector(9 downto 0);
            vid, hs, vs   : out std_logic
        );
    end component;
begin
t_en <= '1';
    -- clock process @125 MHz
    process begin
        t_clk <= '0';
        wait for 4 ns;
        t_clk <= '1';
        wait for 4 ns;
    end process;

    vga_ctrl_sim: vga_ctrl 
        port map(
            clk    => t_clk   ,
            en     => t_en    ,
            hcount => t_hcount,
            vcount => t_vcount,
            vid    => t_vid   ,
            hs     => t_hs    ,
            vs     => t_vs    
        );

end Behavioral;
