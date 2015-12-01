library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxReg is
    port ( 
		muxReg_Instruction	: in  std_logic_vector (31 downto 0);
		muxReg_sel 	 		: in  std_logic;
		muxReg_out 			: out std_logic_vector (4 downto 0)
    );
end muxReg;

architecture Behavioral of muxReg is
begin
process(muxReg_sel,muxReg_Instruction)
begin
	
	case muxReg_sel is
		when '0'	=> muxReg_out <= muxReg_Instruction(20 downto 16);
		when '1'	=> muxReg_out <= muxReg_Instruction(15 downto 11);
		when others	=> muxReg_out <= (others => '0');
	end case;

end process;
end Behavioral;