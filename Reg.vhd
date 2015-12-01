library IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
    port (
    	Reg_clk		: in  std_logic;
    	RegWriteIn 	: in  std_logic;
    	RS			: in  std_logic_vector(4 downto 0);
    	RT			: in  std_logic_vector(4 downto 0);
    	RD			: in  std_logic_vector(4 downto 0);
    	Reg_Data	: in  std_logic_vector(31 downto 0);
    	Reg_DL1		: out std_logic_vector(31 downto 0);
    	Reg_DL2		: out std_logic_vector(31 downto 0)
	);
end Reg;

architecture Behavioral of Reg is

type rom is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
signal memory: rom := (
	x"00000000",
	x"00000001",
	x"00000002",
	x"00000003",
	x"00000004",
	x"00000005",
	x"00000006",
	x"00000007",
	x"00000008",
	x"00000009",
	x"0000000A",
	x"0000000B",
	x"0000000C",
	x"0000000D",
	x"0000000E",
	x"0000000F",
	x"0000000F",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	x"00000001",
	others=>X"00000000"
);

begin

	Reg_DL1 <= memory(conv_integer(RS));	
	Reg_DL2 <= memory(conv_integer(RT));

	process (Reg_clk)
	begin
		if (rising_edge (Reg_clk)) then 
			if RegWriteIn = '1' and RD /= "00000" then  
				memory(conv_integer(RD)) <= Reg_Data;
			end if;
		end if;
	end process;

end Behavioral;