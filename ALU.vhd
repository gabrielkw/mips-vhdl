library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    port (
		ALU_entrada1 : in  std_logic_vector (31 downto 0);
		ALU_entrada2 : in  std_logic_vector (31 downto 0);
		ALU_ctrl	 : in  std_logic_vector (2 downto 0);
		ALU_zero	 : out std_logic;
		ALU_out		 : out std_logic_vector (31 downto 0)
	);
end ALU;

architecture Behavioral of ALU is

begin
process(ALU_ctrl,ALU_entrada1 ,ALU_entrada2)
begin

	case ALU_ctrl is
		when "000" => --Soma
			ALU_out <= ALU_entrada1 + ALU_entrada2;
			ALU_zero <= '0';	
		when "001" =>
			ALU_out<= ALU_entrada1 - ALU_entrada2; --Subtração
			ALU_zero <= '0';
		when "010" => --BEQ
			if ALU_entrada1 - ALU_entrada2 = x"00000000" then
				ALU_zero <= '1';
			else
				ALU_zero <= '0';
			end if;
		when "011" => --Bitwise AND
			ALU_out <= ALU_entrada1 AND ALU_entrada2;
			ALU_zero <= '0';
		when "100" => --Bitwise OR
			ALU_out<= ALU_entrada1 OR ALU_entrada2;
			ALU_zero <= '0';
		when "101" => --SLT set on less than (if(ALU_entrada1<ALU_entrada2){return 1;}else{return 0;})
			if ALU_entrada1<ALU_entrada2 then 
				ALU_out<=x"00000001";
				ALU_zero <= '0'; 
			else
				ALU_out<=x"00000000"; 
				ALU_zero <= '0';
			end if;
		when others =>
			ALU_out <= x"00000000";			
	end case; 

end process;
end Behavioral;