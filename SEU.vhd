library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU is
    port (
		SEU_in	: in  std_logic_vector (15 downto 0);
		SEU_out	: out std_logic_vector (31 downto 0)
	);
end SEU;

architecture Behavioral of SEU is
begin
process(SEU_in)
begin

	if SEU_in(15) = '1' then
		SEU_out <= "1111111111111111"&SEU_in;
	else if SEU_in(15) = '0' then
		SEU_out <= "0000000000000000"&SEU_in;
	end if;
	end if; 

end process;
end Behavioral;