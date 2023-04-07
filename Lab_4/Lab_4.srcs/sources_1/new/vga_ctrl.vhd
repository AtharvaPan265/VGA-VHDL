library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity vga_ctrl is
    Port (
        clk, en       : in  std_logic;
        hcount, vcount: out std_logic_vector(9 downto 0);
        vid, hs, vs   : out std_logic
    );
end vga_ctrl;

architecture Behavioral of vga_ctrl is
    signal hcounter, vcounter:  std_logic_vector(9 downto 0)  := (others => '0');
    signal bruh : std_logic;
begin
    hcount <= hcounter;
    vcount <= vcounter;
    process(clk)
    begin
        if (rising_edge(clk) and en = '1') then
            hcounter <= std_logic_vector(unsigned(hcounter) + 1);
            if (unsigned (hcounter) = 799 ) then
                hcounter <= (others => '0');
                bruh <= '1';
                  -- vcounter <= std_logic_vector(unsigned(vcounter) + 1);
            end if;
        end if;
    end process;
    process(hcounter)
    begin
      --  if (rising_edge(clk) and en = '1') then
            if (unsigned(hcounter) = 0 and bruh = '1') then
                vcounter <= std_logic_vector(unsigned(vcounter) + 1);
            end if;
            if (unsigned(vcounter) = 524) then
                vcounter <= (others => '0');
            end if;
            if (unsigned(hcounter) < 640 and unsigned(vcounter) < 480) then
                vid <= '1';
            else
                vid <= '0';
            end if;
            if (unsigned(hcounter) >= 656 and unsigned(hcounter) <= 751) then
                hs <= '0';
            else
                hs <= '1';
            end if;
            if (unsigned(vcounter) >= 490 and unsigned(vcounter) <= 491) then
                vs <= '0';
            else
                vs <= '1';
            end if;
     --   end if;
    end process;
end Behavioral;
