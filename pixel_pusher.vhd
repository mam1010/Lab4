----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2019 06:46:43 AM
-- Design Name: 
-- Module Name: pixel_pusher - Behavioral
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

entity pixel_pusher is
    Port ( clk : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           vs : in STD_LOGIC;
           pixel : in STD_LOGIC_VECTOR (7 downto 0);
           hcount : in STD_LOGIC_VECTOR (9 downto 0);
           vid : in STD_LOGIC;
           R : out STD_LOGIC_VECTOR (4 downto 0);
           B : out STD_LOGIC_VECTOR (4 downto 0);
           G : out STD_LOGIC_VECTOR (5 downto 0);
           addr : out STD_LOGIC_VECTOR (17 downto 0));
end pixel_pusher;

architecture Behavioral of pixel_pusher is
    signal tmp : std_logic_vector(17 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if(clk_en='1') then
            if(vid='1' and unsigned(hcount)<480) then
                tmp <= std_logic_vector(unsigned(tmp) + 1);
                R <= pixel(7 downto 5) & "00";
                G <= pixel(4 downto 2) & "000";
                B <= pixel(1 downto 0) & "000";
            elsif(vs='0') then
                tmp <= "000000000000000000";
                R <= "00000";
                B <= "00000";
                G <= "000000";
            end if;
            addr <= tmp;
        end if;
    end process;

end Behavioral;
