library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;library UNISIM;
use UNISIM.VComponents.all;

entity image_top is
  Port (
    clk           : in  std_logic;
    vga_r, vga_b  : out std_logic_vector(4 downto 0);
    vga_g         : out std_logic_vector(5 downto 0);
    vga_hs, vga_vs: out std_logic
  );
end image_top;

architecture Behavioral of image_top is
    signal div, tvs, tvid, ths: std_logic;
    signal taddress           : std_logic_vector(17 downto 0);
    signal tpix               : std_logic_vector(7 downto 0);
    signal thcount, tvcount   : std_logic_vector(9 downto 0) := (others => '0');
    signal tR, tB             : std_logic_vector(4 downto 0);
    signal tG                 : std_logic_vector(5 downto 0);
    
    component picture is
      Port (
        clka  : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    end component;
    component Clock_div is
        Port (
            clk             : in  std_logic;
            div             : out std_logic
        );
    end component;
    component pixel_pusher is
        Port (
            clk, en, vs, vid: in  std_logic;
            pixel           : in  std_logic_vector(7 downto 0);
            hcount          : in  std_logic_vector(9 downto 0);
            R, B            : out std_logic_vector(4 downto 0);
            G               : out std_logic_vector(5 downto 0);
            addr            : out std_logic_vector(17 downto 0)
        );
    end component;
    component vga_ctrl is
        Port (
            clk, en         : in  std_logic;
            hcount, vcount  : out std_logic_vector(9 downto 0);
            vid, hs, vs     : out std_logic
        );
    end component;
begin
    vga_r  <= tR;
    vga_g  <= tG;
    vga_b  <= tB;
    vga_hs <= ths;
    vga_vs <= tvs;
    divider: clock_div
        port map   (
            clk    => clk,
            div    => div
        );
    pixel_traffic_control: vga_ctrl
        Port map(
            clk    => clk,
            en     => div,
            hcount => thcount,
            vcount => tvcount,
            vid    => tvid,
            hs     => ths,
            vs     => tvs
        );
    brain_block: picture
        port map(
            clka   => clk,
            addra  => taddress,
            douta  => tpix
        );
    pushin_p: pixel_pusher
        Port map (
            clk    => clk,
            en     => div,
            vs     => tvs,
            vid    => tvid,
            pixel  => tpix,      
            hcount => thcount,      
            R      => tr,
            G      => tg,
            B      => tb,       
            addr   => taddress       
            );
end Behavioral;
