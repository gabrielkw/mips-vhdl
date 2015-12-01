library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxMem is
    port (
		muxMem_sel 		: in  std_logic;
    	muxMem_in		: in  std_logic_vector(31 downto 0);
		muxMem_out 		: out std_logic_vector(31 downto 0)
    );
end muxMem;

architecture Behavioral of muxMem is
begin
process(muxMem_sel)
begin

	muxMem_out <= muxMem_in; --Sempre 0 pois este projeto não implementa a memória de dados

end process;
end Behavioral;