library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PcPlusFour is
    port ( 
		PcPlusFour_PC_out		: in  std_logic_vector (31 downto 0);
		PcPlusFour_out 			: out std_logic_vector (31 downto 0)
    );
end PcPlusFour;

architecture Behavioral of PcPlusFour is
begin
process(PcPlusFour_PC_out)
begin
	
	PcPlusFour_out <= PcPlusFour_PC_out + 4;

end process;
end Behavioral;