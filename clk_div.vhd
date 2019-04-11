----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2019 08:19:56 AM
-- Design Name: 
-- Module Name: clk_div - Behavioral
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

entity clk_div is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clk_div;

architecture Behavioral of clk_div is
signal counter : std_logic_vector(26 downto 0) := (others => '0');
begin
    process (CLK_IN)
    begin 
        if(rising_edge(CLK_IN)) then
            if (unsigned(counter) < 5) then
               counter <= std_logic_vector(unsigned(counter) + 1);
            else
               counter <= (others => '0');
            end if;
        end if;
        if (unsigned(counter) = 2) then
            CLK_OUT <= '1';            
        else
            CLK_OUT <= '0';              
        end if;
    end process;

end Behavioral;