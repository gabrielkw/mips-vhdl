library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxPC is
    port ( 
		muxPC_PC_out		: in  std_logic_vector (31 downto 0);
		muxPC_ALU_out		: in  std_logic_vector (31 downto 0);
		muxPC_sel 	 		: in  std_logic;
		muxPC_out 			: out std_logic_vector (31 downto 0)
    );
end muxPC;

architecture Behavioral of muxPC is
begin
process(muxPC_sel,muxPC_PC_out,muxPC_ALU_out)
begin
	
	case muxPC_sel is
		when '0'	=> muxPC_out <= muxPC_ALU_out;
		when '1'	=> muxPC_out <= muxPC_PC_out;
		when others	=> muxPC_out <= (others => '0');
	end case;

end process;
end Behavioral;