library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    port (
		PC_clk	: in  std_logic;
		PC_en	: in  std_logic;
		PC_in	: in  std_logic_vector (31 downto 0);
		PC_out	: out std_logic_vector (31 downto 0)
	);
end PC;

architecture Behavioral of PC is
begin
process (PC_clk)
begin

	if PC_en = '1' then
		if rising_edge(PC_clk) then
			PC_out <= PC_in;
		end if;
	end if;

end process;
end Behavioral;