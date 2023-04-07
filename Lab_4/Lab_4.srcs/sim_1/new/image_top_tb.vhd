----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2023 07:40:28 PM
-- Design Name: 
-- Module Name: image_top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top_tb is
--  Port ( );
end image_top_tb;

architecture Behavioral of image_top_tb is
component  image_top is
  Port (
    clk           : in  std_logic;
    vga_r, vga_b  : out std_logic_vector(4 downto 0);
    vga_g         : out std_logic_vector(5 downto 0);
    vga_hs, vga_vs: out std_logic
  );
end component;
signal t_clk : std_logic;
signal t_vga_r, t_vga_b  : std_logic_vector(4 downto 0);
signal t_vga_g         : std_logic_vector(5 downto 0);
signal t_vga_hs,t_vga_vs: std_logic;
begin
    -- clock process @125 MHz
    process begin
        t_clk <= '0';
        wait for 4 ns;
        t_clk <= '1';
        wait for 4 ns;
    end process;
    topsim : image_top 
        port map(
        clk    => t_clk,
        vga_r  => t_vga_r,
        vga_b  => t_vga_b,
        vga_g  => t_vga_g,
        vga_hs => t_vga_hs,
        vga_vs => t_vga_vs
        );

end Behavioral;
