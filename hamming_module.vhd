----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:13:23 04/12/2012 
-- Design Name: 
-- Module Name:    hamming_module - Behavioral 
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

entity hamming_module is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (31 downto 0);
			  data_out_encoder : out STD_LOGIC_VECTOR (37 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end hamming_module;

architecture Behavioral of hamming_module is
	signal tmp_data_out_encoder : std_logic_vector(37 downto 0) := (others => '0');
	signal e_p0, e_p1, e_p2, e_p3, e_p4, e_p5 : std_logic := '0'; --Encoder's parity bits
	signal d_p0, d_p1, d_p2, d_p3, d_p4, d_p5 : std_logic := '0'; --Decoder's parity bits
	--signal syndrome : std_logic_vector(5 downto 0) := (others => '0');
	
	--signal err_pos : integer range 0 to 255 := 0;

begin
	data_out_encoder <= tmp_data_out_encoder;

	----Hamming (38,32) Encoder--------
	---Inserting parity bits in positions
	---2^n, where n = 0...5: 1, 2, 4, 8, 16, 32.
	tmp_data_out_encoder  (2) <= data_in(0);
	tmp_data_out_encoder  (4) <= data_in(1);
	tmp_data_out_encoder  (5) <= data_in(2);
	tmp_data_out_encoder  (6) <= data_in(3);
	tmp_data_out_encoder  (8) <= data_in(4);
	tmp_data_out_encoder  (9) <= data_in(5);
	tmp_data_out_encoder  (10) <= data_in(6);
	tmp_data_out_encoder  (11) <= data_in(7);
	tmp_data_out_encoder  (12) <= data_in(8);
	tmp_data_out_encoder  (13) <= data_in(9);
	tmp_data_out_encoder  (14) <= data_in(10);
	tmp_data_out_encoder  (16) <= data_in(11);
	tmp_data_out_encoder  (17) <= data_in(12);
	tmp_data_out_encoder  (18) <= data_in(13);
	tmp_data_out_encoder  (19) <= data_in(14);
	tmp_data_out_encoder  (20) <= data_in(15);
	tmp_data_out_encoder  (21) <= data_in(16);
	tmp_data_out_encoder  (22) <= data_in(17);
	tmp_data_out_encoder  (23) <= data_in(18);
	tmp_data_out_encoder  (24) <= data_in(19);
	tmp_data_out_encoder  (25) <= data_in(20);
	tmp_data_out_encoder  (26) <= data_in(21);
	tmp_data_out_encoder  (27) <= data_in(22);
	tmp_data_out_encoder  (28) <= data_in(23);
	tmp_data_out_encoder  (29) <= data_in(24);
	tmp_data_out_encoder  (30) <= data_in(25);
	tmp_data_out_encoder  (32) <= data_in(26);
	tmp_data_out_encoder  (33) <= data_in(27);
	tmp_data_out_encoder  (34) <= data_in(28);
	tmp_data_out_encoder  (35) <= data_in(29);
	tmp_data_out_encoder  (36) <= data_in(30);
	tmp_data_out_encoder  (37) <= data_in(31);
	
	
	e_p0 <= tmp_data_out_encoder  (2) xor 
			tmp_data_out_encoder  (4) xor 
			tmp_data_out_encoder  (6) xor 
			tmp_data_out_encoder  (8) xor 
			tmp_data_out_encoder  (10) xor 
			tmp_data_out_encoder  (12) xor 
			tmp_data_out_encoder  (14) xor 
			tmp_data_out_encoder  (16) xor 
			tmp_data_out_encoder  (18) xor 
			tmp_data_out_encoder  (20) xor 
			tmp_data_out_encoder  (22) xor 
			tmp_data_out_encoder  (24) xor 
			tmp_data_out_encoder  (26) xor 
			tmp_data_out_encoder  (28) xor 
			tmp_data_out_encoder  (30) xor 
			tmp_data_out_encoder  (32) xor 
			tmp_data_out_encoder  (34) xor 
			tmp_data_out_encoder  (36);
			
	e_p1 <= tmp_data_out_encoder  (2) xor 
			tmp_data_out_encoder  (5) xor 
			tmp_data_out_encoder  (6) xor 
			tmp_data_out_encoder  (9) xor 
			tmp_data_out_encoder  (10) xor 
			tmp_data_out_encoder  (13) xor 
			tmp_data_out_encoder  (14) xor 
			tmp_data_out_encoder  (17) xor 
			tmp_data_out_encoder  (18) xor 
			tmp_data_out_encoder  (21) xor 
			tmp_data_out_encoder  (22) xor 
			tmp_data_out_encoder  (25) xor 
			tmp_data_out_encoder  (26) xor 
			tmp_data_out_encoder  (29) xor 
			tmp_data_out_encoder  (30) xor 
			tmp_data_out_encoder  (33) xor 
			tmp_data_out_encoder  (34) xor 
			tmp_data_out_encoder  (36) xor 
			tmp_data_out_encoder  (37) ;
			
	e_p2 <= tmp_data_out_encoder  (4) xor 
			tmp_data_out_encoder  (5) xor 
			tmp_data_out_encoder  (6) xor 
			tmp_data_out_encoder  (11) xor 
			tmp_data_out_encoder  (12) xor 
			tmp_data_out_encoder  (13) xor 
			tmp_data_out_encoder  (14) xor 
			tmp_data_out_encoder  (19) xor 
			tmp_data_out_encoder  (20) xor 
			tmp_data_out_encoder  (21) xor 
			tmp_data_out_encoder  (22) xor 
			tmp_data_out_encoder  (27) xor 
			tmp_data_out_encoder  (28) xor 
			tmp_data_out_encoder  (29) xor 
			tmp_data_out_encoder  (30) xor 
			tmp_data_out_encoder  (35) xor 
			tmp_data_out_encoder  (36) xor 
			tmp_data_out_encoder  (37) ;
			
	e_p3 <= tmp_data_out_encoder  (8) xor 
			tmp_data_out_encoder  (9) xor 
			tmp_data_out_encoder  (10) xor 
			tmp_data_out_encoder  (11) xor 
			tmp_data_out_encoder  (12) xor 
			tmp_data_out_encoder  (13) xor 
			tmp_data_out_encoder  (14) xor 
			tmp_data_out_encoder  (23) xor 
			tmp_data_out_encoder  (24) xor 
			tmp_data_out_encoder  (25) xor 
			tmp_data_out_encoder  (26) xor 
			tmp_data_out_encoder  (27) xor 
			tmp_data_out_encoder  (28) xor 
			tmp_data_out_encoder  (29) xor 
			tmp_data_out_encoder  (30);
			
	e_p4 <= tmp_data_out_encoder  (16) xor 
			tmp_data_out_encoder  (17) xor 
			tmp_data_out_encoder  (18) xor 
			tmp_data_out_encoder  (19) xor 
			tmp_data_out_encoder  (20) xor 
			tmp_data_out_encoder  (21) xor 
			tmp_data_out_encoder  (22) xor 
			tmp_data_out_encoder  (23) xor 
			tmp_data_out_encoder  (24) xor 
			tmp_data_out_encoder  (25) xor 
			tmp_data_out_encoder  (26) xor 
			tmp_data_out_encoder  (27) xor 
			tmp_data_out_encoder  (28) xor 
			tmp_data_out_encoder  (29) xor 
			tmp_data_out_encoder  (30);
			
	e_p5 <= tmp_data_out_encoder  (32) xor 
			tmp_data_out_encoder  (33) xor 
			tmp_data_out_encoder  (34) xor 
			tmp_data_out_encoder  (35) xor 
			tmp_data_out_encoder  (36) xor 
			tmp_data_out_encoder  (37);
			
	--Actually, inserting parity bits:
	tmp_data_out_encoder  (0) <= e_p0;
	tmp_data_out_encoder  (1) <= e_p1;
	tmp_data_out_encoder  (3) <= e_p2;
	tmp_data_out_encoder  (7) <= e_p3;
	tmp_data_out_encoder  (15) <= e_p4;
	tmp_data_out_encoder  (31) <= e_p5;

	--============================
	----Decoder------------------=
	--============================
	---Calculating parity bits----
	d_p0 <= tmp_data_out_encoder  (2) xor 
			tmp_data_out_encoder  (4) xor 
			tmp_data_out_encoder  (6) xor 
			tmp_data_out_encoder  (8) xor 
			tmp_data_out_encoder  (10) xor 
			tmp_data_out_encoder  (12) xor 
			tmp_data_out_encoder  (14) xor 
			tmp_data_out_encoder  (16) xor 
			tmp_data_out_encoder  (18) xor 
			tmp_data_out_encoder  (20) xor 
			tmp_data_out_encoder  (22) xor 
			tmp_data_out_encoder  (24) xor 
			tmp_data_out_encoder  (26) xor 
			tmp_data_out_encoder  (28) xor 
			tmp_data_out_encoder  (30) xor 
			tmp_data_out_encoder  (32) xor 
			tmp_data_out_encoder  (34) xor 
			tmp_data_out_encoder  (36);
			
	d_p1 <= tmp_data_out_encoder  (2) xor 
			tmp_data_out_encoder  (5) xor 
			tmp_data_out_encoder  (6) xor 
			tmp_data_out_encoder  (9) xor 
			tmp_data_out_encoder  (10) xor 
			tmp_data_out_encoder  (13) xor 
			tmp_data_out_encoder  (14) xor 
			tmp_data_out_encoder  (17) xor 
			tmp_data_out_encoder  (18) xor 
			tmp_data_out_encoder  (21) xor 
			tmp_data_out_encoder  (22) xor 
			tmp_data_out_encoder  (25) xor 
			tmp_data_out_encoder  (26) xor 
			tmp_data_out_encoder  (29) xor 
			tmp_data_out_encoder  (30) xor 
			tmp_data_out_encoder  (33) xor 
			tmp_data_out_encoder  (34) xor 
			tmp_data_out_encoder  (36) xor 
			tmp_data_out_encoder  (37) ;
			
	d_p2 <= tmp_data_out_encoder  (4) xor 
			tmp_data_out_encoder  (5) xor 
			tmp_data_out_encoder  (6) xor 
			tmp_data_out_encoder  (11) xor 
			tmp_data_out_encoder  (12) xor 
			tmp_data_out_encoder  (13) xor 
			tmp_data_out_encoder  (14) xor 
			tmp_data_out_encoder  (19) xor 
			tmp_data_out_encoder  (20) xor 
			tmp_data_out_encoder  (21) xor 
			tmp_data_out_encoder  (22) xor 
			tmp_data_out_encoder  (27) xor 
			tmp_data_out_encoder  (28) xor 
			tmp_data_out_encoder  (29) xor 
			tmp_data_out_encoder  (30) xor 
			tmp_data_out_encoder  (35) xor 
			tmp_data_out_encoder  (36) xor 
			tmp_data_out_encoder  (37) ;
			
	d_p3 <= tmp_data_out_encoder  (8) xor 
			tmp_data_out_encoder  (9) xor 
			tmp_data_out_encoder  (10) xor 
			tmp_data_out_encoder  (11) xor 
			tmp_data_out_encoder  (12) xor 
			tmp_data_out_encoder  (13) xor 
			tmp_data_out_encoder  (14) xor 
			tmp_data_out_encoder  (23) xor 
			tmp_data_out_encoder  (24) xor 
			tmp_data_out_encoder  (25) xor 
			tmp_data_out_encoder  (26) xor 
			tmp_data_out_encoder  (27) xor 
			tmp_data_out_encoder  (28) xor 
			tmp_data_out_encoder  (29) xor 
			tmp_data_out_encoder  (30);
			
	d_p4 <= tmp_data_out_encoder  (16) xor 
			tmp_data_out_encoder  (17) xor 
			tmp_data_out_encoder  (18) xor 
			tmp_data_out_encoder  (19) xor 
			tmp_data_out_encoder  (20) xor 
			tmp_data_out_encoder  (21) xor 
			tmp_data_out_encoder  (22) xor 
			tmp_data_out_encoder  (23) xor 
			tmp_data_out_encoder  (24) xor 
			tmp_data_out_encoder  (25) xor 
			tmp_data_out_encoder  (26) xor 
			tmp_data_out_encoder  (27) xor 
			tmp_data_out_encoder  (28) xor 
			tmp_data_out_encoder  (29) xor 
			tmp_data_out_encoder  (30);
			
	d_p5 <= tmp_data_out_encoder  (32) xor 
			tmp_data_out_encoder  (33) xor 
			tmp_data_out_encoder  (34) xor 
			tmp_data_out_encoder  (35) xor 
			tmp_data_out_encoder  (36) xor 
			tmp_data_out_encoder  (37);
			
	-----------------------
	---Calculating syndrome----
	---Syndrome is: transmitted_pariry_bit XOR new_calculated_parity_bit_from_transmitted_data
	---The sum of error positions will point to error bit----
	----------------------------------------
--	
--	syndrome(0) <= d_p0 xor tmp_data_out_encoder  (0); 
--	syndrome(1) <= d_p1 xor tmp_data_out_encoder  (1);
--	syndrome(2) <= d_p2 xor tmp_data_out_encoder  (3); 
--	syndrome(3) <= d_p3 xor tmp_data_out_encoder  (7);
--	syndrome(4) <= d_p4 xor tmp_data_out_encoder  (15); 
--	syndrome(5) <= d_p5 xor tmp_data_out_encoder  (31);
--	
--	process(syndrome)
--	begin
--	case syndrome is 
--      when "000011" =>
--         data_out(3) <= '1' when tmp_data_out_encoder  (3) = '0' else '0';
--      when "000101" =>
--         data_out(5) <= '1' when tmp_data_out_encoder  (5) = '0' else '0';
--      when "000110" =>
--         data_out(6) <= '1' when tmp_data_out_encoder  (6) = '0' else '0';
--      when "000111" =>
--         data_out(7) <= '1' when tmp_data_out_encoder  (7) = '0' else '0';
--      when "001001" =>
--         data_out(9) <= '1' when tmp_data_out_encoder  (9) = '0' else '0';
--      when "001010" =>
--         data_out(10) <= '1' when tmp_data_out_encoder  (10) = '0' else '0';
--      when "001011" =>
--         data_out(11) <= '1' when tmp_data_out_encoder  (11) = '0' else '0';
--      when "001100" =>
--         data_out(12) <= '1' when tmp_data_out_encoder  (12) = '0' else '0';
--      when "001101" =>
--         data_out(13) <= '1' when tmp_data_out_encoder  (13) = '0' else '0';
--      when "001110" =>
--         data_out(14) <= '1' when tmp_data_out_encoder  (14) = '0' else '0';
--      when "001111" =>
--         data_out(15) <= '1' when tmp_data_out_encoder  (15) = '0' else '0';
--      when "010001" =>
--         data_out(17) <= '1' when tmp_data_out(17) = '0' else '0';
--      when "010010" =>
--         data_out(18) <= '1' when tmp_data_out(18) = '0' else '0';
--      when "010011" =>
--         data_out(19) <= '1' when tmp_data_out(19) = '0' else '0';
--      when "010100" =>
--         data_out(20) <= '1' when tmp_data_out(20) = '0' else '0';
--      when "010101" =>
--         data_out(21) <= '1' when tmp_data_out(21) = '0' else '0';
--      when "010110" =>
--         data_out(22) <= '1' when tmp_data_out_encoder  (22) = '0' else '0';
--      when "010111" =>
--         data_out(23) <= '1' when tmp_data_out_encoder  (23) = '0' else '0';
--      when "011000" =>
--         data_out(24) <= '1' when tmp_data_out_encoder  (24) = '0' else '0';
--      when "011001" =>
--         data_out(25) <= '1' when tmp_data_out_encoder  (25) = '0' else '0';
--      when "011010" =>
--         data_out(26) <= '1' when tmp_data_out_encoder  (26) = '0' else '0';
--      when "011011" =>
--         data_out(27) <= '1' when tmp_data_out_encoder  (27) = '0' else '0';
--      when "011100" =>
--         data_out(28) <= '1' when tmp_data_out_encoder  (28) = '0' else '0';
--      when "011101" =>
--         data_out(29) <= '1' when tmp_data_out_encoder  (29) = '0' else '0';
--      when "011110" =>
--         data_out(30) <= '1' when tmp_data_out_encoder  (30) = '0' else '0';
--      when "011111" =>
--         data_out(31) <= '1' when tmp_data_out_encoder  (31) = '0' else '0';
--      when others =>
--			data_out(0) <= '1' when tmp_data_out_encoder  (10) = '0' else '0';
--	end case;
--	end process;
--	

	data_out(0) <= tmp_data_out_encoder  (2);
	data_out(1) <= tmp_data_out_encoder  (4);
	data_out(2) <= tmp_data_out_encoder  (5);
	data_out(3) <= tmp_data_out_encoder  (6);
	data_out(4) <= tmp_data_out_encoder  (8);
	data_out(5) <= tmp_data_out_encoder  (9);
	data_out(6) <= tmp_data_out_encoder  (10);
	data_out(7) <= tmp_data_out_encoder  (11);
	data_out(8) <= tmp_data_out_encoder  (12);
	data_out(9) <= tmp_data_out_encoder  (13);
	data_out(10) <= tmp_data_out_encoder  (14);
	data_out(11) <= tmp_data_out_encoder  (16);
	data_out(12) <= tmp_data_out_encoder  (17);
	data_out(13) <= tmp_data_out_encoder  (18);
	data_out(14) <= tmp_data_out_encoder  (19);
	data_out(15) <= tmp_data_out_encoder  (20);
	data_out(16) <= tmp_data_out_encoder  (21);
	data_out(17) <= tmp_data_out_encoder  (22);
	data_out(18) <= tmp_data_out_encoder  (23);
	data_out(19) <= tmp_data_out_encoder  (24);
	data_out(20) <= tmp_data_out_encoder  (25);
	data_out(21) <= tmp_data_out_encoder  (26);
	data_out(22) <= tmp_data_out_encoder  (27);
	data_out(23) <= tmp_data_out_encoder  (28);
	data_out(24) <= tmp_data_out_encoder  (29);
	data_out(25) <= tmp_data_out_encoder  (30);
	data_out(26) <= tmp_data_out_encoder  (32);
	data_out(27) <= tmp_data_out_encoder  (33);
	data_out(28) <= tmp_data_out_encoder  (34);
	data_out(29) <= tmp_data_out_encoder  (35);
	data_out(30) <= tmp_data_out_encoder  (36);
	data_out(31) <= tmp_data_out_encoder  (37);
	
	

end Behavioral;

