----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:05:02 04/09/2012 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  data_in : in  std_logic_vector(31 downto 0);
			  data_out_encoder : out  std_logic_vector(37 downto 0);
			  data_out : out  std_logic_vector(31 downto 0);
			  verif : out std_logic_vector(31 downto 0)
			 );
end top;

architecture Behavioral of top is
	
	component hamming_module is 
		Port ( clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				data_in : in  std_logic_vector(31 downto 0);
				data_out_encoder : out  std_logic_vector(37 downto 0);
				data_out : out  std_logic_vector(31 downto 0)
			);
	end component;
	
	signal tmp_data_in : std_logic_vector(31 downto 0) :=(others => '0');
	signal tmp_data_out : std_logic_vector(31 downto 0) := (others => '0');
	signal tmp_data_out_encoder : std_logic_vector(37 downto 0) := (others => '0');
begin

	hamming_block : hamming_module
		Port Map (
						clk => clk,
						rst => rst,
						data_in => tmp_data_in,
						data_out_encoder => tmp_data_out_encoder,
						data_out => tmp_data_out
					);
					
	tmp_data_in <= data_in;
	data_out <= tmp_data_out;
	data_out_encoder <= tmp_data_out_encoder;

	
	----Verification: applying XOR to block output and raw data input.--------
	verif <= data_in xor tmp_data_out;
	

end Behavioral;

