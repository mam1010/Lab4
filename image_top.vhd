----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2019 07:18:05 AM
-- Design Name: 
-- Module Name: image_top - structural
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

entity image_top is
    Port ( clk : in STD_LOGIC;
           vga_hs : out STD_LOGIC;
           vga_vs : out STD_LOGIC;
           vga_r : out STD_LOGIC_VECTOR (4 downto 0);
           vga_b : out STD_LOGIC_VECTOR (4 downto 0);
           vga_g : out STD_LOGIC_VECTOR (5 downto 0));
end image_top;

architecture structural of image_top is
    component pixel_pusher port
    (
        clk : in STD_LOGIC;
        clk_en : in STD_LOGIC;
        vs : in STD_LOGIC;
        pixel : in STD_LOGIC_VECTOR (7 downto 0);
        hcount : in STD_LOGIC_VECTOR (9 downto 0);
        vid : in STD_LOGIC;
        R : out STD_LOGIC_VECTOR (4 downto 0);
        B : out STD_LOGIC_VECTOR (4 downto 0);
        G : out STD_LOGIC_VECTOR (5 downto 0);
        addr : out STD_LOGIC_VECTOR (17 downto 0)
    );
    end component;
    
    component vga_ctrl port
    (
        clk : in STD_LOGIC;
        clk_en : in STD_LOGIC;
        hcount : out STD_LOGIC_VECTOR (9 downto 0);
        vcount : out STD_LOGIC_VECTOR (9 downto 0);
        vid : out STD_LOGIC;
        hs : out STD_LOGIC;
        vs : out STD_LOGIC
    );
    end component;

    component block_memory port
    (
        clk : in STD_LOGIC;
        we : in STD_LOGIC_VECTOR(0 downto 0);
        addr : in STD_LOGIC_VECTOR (17 downto 0);
        din : in STD_LOGIC_VECTOR (7 downto 0);
        dout : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;
        
    component clk_div port
    (
        clk_in : in std_logic;
        clk_out : out std_logic
    );
    end component;
    
    signal clk_tmp : std_logic;
    signal vid_tmp : std_logic;
    signal vs_tmp : std_logic;
    signal hcount_tmp : std_logic_vector(9 downto 0);
    signal vcount_tmp : std_logic_vector(9 downto 0);
    signal addr_tmp : std_logic_vector(7 downto 0);
    signal pixel_tmp : std_logic_vector(7 downto 0);
    
begin
    u2: clk_div port map(
        clk_in => clk,
        clk_out => clk_tmp);
    
    u1: block_memory port map(
        clk => clk,
        we => vcount_tmp(8 downto 8),
        addr => addr_tmp,
        din => vcount_tmp(7 downto 0),
        dout => pixel_tmp);
    
    u3: vga_ctrl port map(
        clk => clk,
        clk_en => clk_tmp,
        hcount => hcount_tmp,
        vcount => vcount_tmp,
        vid => vid_tmp,
        hs => vga_hs,
        vs => vs_tmp);
        
    vga_vs <= vs_tmp;
    
    u4: pixel_pusher port map(
        clk => clk,
        clk_en => clk_tmp,
        vs => vs_tmp,
        pixel => pixel_tmp,
        hcount => hcount_tmp,
        vid => vid_tmp,
        R => vga_r,
        B => vga_b,
        G => vga_g,
        addr => addr_tmp);
end structural;
