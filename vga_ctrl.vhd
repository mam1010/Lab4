----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2019 05:59:54 AM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
    Port ( 
           clk : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           hcount : out STD_LOGIC_VECTOR (9 downto 0);
           vcount : out STD_LOGIC_VECTOR (9 downto 0);
           vid : out STD_LOGIC;
           hs : out STD_LOGIC;
           vs : out STD_LOGIC);
end vga_ctrl;

architecture Behavioral of vga_ctrl is
    signal hcounter : std_logic_vector(9 downto 0) := (others => '0');
    signal vcounter : std_logic_vector(9 downto 0) := (others => '0');
begin

    process(clk)
    begin
        if(clk_en='1') then
            if(unsigned(hcounter) > 799) then
                hcounter <= "0000000000";
            end if;
            if(unsigned(vcounter) > 524) then
                vcounter <= "0000000000";
            end if;
            if(unsigned(hcounter) <= 639 and unsigned(vcounter) <= 479) then
                vid <= '1';
                --output color data
            else
                vid <= '0';
            end if;
            if(unsigned(hcounter) >= 656 and unsigned(hcounter) <= 751) then
                hs <= '0';
            else
                hs <= '1';
            end if;
            if(unsigned(vcounter) >= 490 and unsigned(vcounter) <= 491) then
                vs <= '0';
            else
                vs <= '1';
            end if; 
            hcount <= hcounter;
            vcount <= vcounter;
            hcounter <= std_logic_vector(unsigned(hcounter) + 1);
            vcounter <= std_logic_vector(unsigned(vcounter) + 1);
        end if;
    end process;

end Behavioral;
