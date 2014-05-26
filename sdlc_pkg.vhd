--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and procedures for the SDLC transmitter 
--
-- Revision 1.1 (16 April 2010)
--
-- Includes shared variable for gating ss_tx_clk and 
-- constants for timing requirements

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package sdlc_pkg is

	shared variable ss_msg_active, ps_message_active : boolean := false;
	
	-- Constants
	CONSTANT cc   : time := (20 ns * 16); -- Board oscillator clock period (50 MHz)/16
	CONSTANT clk_mult : integer := 10; 
	CONSTANT tcc : time := 2*clk_mult*cc;   -- Assumed tx_clk period to simplify sim
	CONSTANT flag : std_logic_vector(7 downto 0) := X"7E";
	CONSTANT idle : std_logic_vector(7 downto 0) := X"FF";
	CONSTANT busy_hold : time := 1 us;
	CONSTANT busy_setup : time := 1 us;
	CONSTANT mosi_hold : time := 1 us;
	CONSTANT mosi_setup : time := 1 us;
	CONSTANT sck_hi : time := 1 us;
	CONSTANT sck_lo : time := 1 us;
 
-- Declare procedure

  procedure send_msg	(
        addr        : in integer range 0 to 31;
        control        : in std_logic_vector( 7 downto 0);
        msg_type        : in integer range 0 to 255;
		  num_data_bytes  : in integer range 0 to 15;
        stuff_err        : in boolean;
        crc_err        : in boolean;
		  signal data		: out std_logic
  );
  
  procedure send_msg2	(
        data_in        : in integer range 0 to 4294967295;
        signal data_out		: out std_logic_vector(31 downto 0)
  );

end sdlc_pkg;

package body sdlc_pkg is

-- Procedure Example
  procedure send_msg  (
        addr        : in integer range 0 to 31;
        control        : in std_logic_vector( 7 downto 0);
        msg_type        : in integer range 0 to 255;
		  num_data_bytes  : in integer range 0 to 15;
        stuff_err        : in boolean;
        crc_err        : in boolean;
		  signal data		: out std_logic
  ) is

	
	variable cnt : integer := 0;
   variable x_bit : std_logic := '0';
   variable indx_inc : integer;
	variable crc : std_logic_vector(1 to 16) := X"FFFF";
	variable dword : std_logic_vector(7 downto 0);
	subtype word is std_logic_vector(7 downto 0);
	type dout_array is array (natural range <>) of word;
	variable dout_vals : dout_array(0 to 17);
	
  begin
    
	   -- assemble message
		dout_vals(0) := conv_std_logic_vector(addr, 8);
		dout_vals(1) := control;
	   dout_vals(2) := conv_std_logic_vector(msg_type, 8);
		for i in 0 to (num_data_bytes - 1) loop
		  dout_vals(i+3) := conv_std_logic_vector(255 - i, 8);
		end loop;
		
		-- send opening flag
		for i in 0 to 7 loop
		  data <= flag(i); wait for tcc;
		end loop;

		-- send data while stuffing and computing crc
		crc := X"FFFF"; -- Initialize CRC
		cnt := 0; -- Initialize stuff counter
		for i in 0 to (num_data_bytes + 2) loop
		  dword := dout_vals(i);
		  for j in 0 to 7 loop
		    x_bit := dword(j) xor crc(16);
		    crc := x_bit & crc(1 to 4) & (x_bit xor crc(5)) & crc(6 to 11) 
			        & (x_bit xor crc(12)) & crc(13 to 15);
		    if dword(j)='1' then
		        cnt := cnt + 1;
		        data <= dword(j); wait for tcc;
		        if (cnt = 5 and (not stuff_err)) then
		            cnt := 0; data <= '0'; wait for tcc;
		        end if; -- cnt
		     else
		       cnt := 0; data <= dword(j); wait for tcc;
		     end if; -- dword
		   end loop; -- j
		 end loop; -- i
		 
		if crc_err then crc(7) := not crc(7); end if;
		
		-- send crc while stuffing
		for i in 1 downto 0 loop
		  indx_inc := i*8;
		  -- IBM doc said to invert CRC output!!!
		  dword := not crc((1 + indx_inc) to (8 + indx_inc));
		  for j in 0 to 7 loop
		    if dword(j)='1' then
		        cnt := cnt + 1;
		        data <= dword(j); wait for tcc;
		        if cnt = 5 then
		            cnt := 0; data <= '0'; wait for tcc;
		        end if; -- cnt
		     else
		       cnt := 0; data <= dword(j); wait for tcc;
		     end if; -- dword
		   end loop; -- j
		 end loop; -- i
		        
		-- send closing flag
		for i in 0 to 7 loop
		  data <= flag(i); wait for tcc;
		end loop;
  end send_msg;
  
  procedure send_msg2  (
        data_in : in integer range 0 to 4294967295;
        signal data_out	: out std_logic_vector(31 downto 0)
  ) is

  begin
      -- assemble message
		data_out <= conv_std_logic_vector(data_in, 32);
  
  end send_msg2;
 
end sdlc_pkg;