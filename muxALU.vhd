library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxALU is
    port ( 
		muxALU_DL2 		: in  std_logic_vector (31 downto 0);
		muxALU_SEU_out 	: in  std_logic_vector (31 downto 0);
		muxALU_sel 		: in  std_logic;
		muxALU_out 		: out std_logic_vector (31 downto 0)
    );
end muxALU;

architecture Behavioral of muxALU is
begin
process(muxALU_sel,muxALU_DL2,muxALU_SEU_out)
begin

	case muxALU_sel is
		when '0'	=> muxALU_out <= (muxALU_DL2);
		when '1'	=> muxALU_out <= muxALU_SEU_out;
		when others	=> muxALU_out <= (others => '0');		
	end case;

end process;
end Behavioral;