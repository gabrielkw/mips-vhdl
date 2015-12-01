library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
	port (
		Op 			: in  std_logic_vector(5 downto 0);
		Funct 		: in  std_logic_vector(5 downto 0);
		ALUOp 		: out std_logic_vector(2 downto 0);--operacion a realizar en la ALU //ALUOp
		RegDst 		: out std_logic;--habilita en cual registro se va a escribir //RegDst
		ALUSrc 		: out std_logic;--habilita el Rt o el Inm_extendido //alu_src_b
		MemtoReg 	: out std_logic;--habilita cual dato se enviara a escribir //MemtoReg
		RegWriteOut	: out std_logic;--habilita la escritura en un registro//RegWrite
		MemRead 	: out std_logic;--habilita la lectura en memoria //MemRead
		MemWrite 	: out std_logic;--habilita la escritura en memoria //MemWrite
		Branch 		: out std_logic
	);
end ControlUnit;

architecture Behavioral of ControlUnit is 
begin
process (Op, Funct)
begin

	case Op is
		-- Instructiones Tipo R
		when "000000" =>
			RegDst		<= '1';--seleccionamos el registro en el multiplexor
			RegWriteOut	<= '1';	--siempre habilitamos la escritura para un registro en los Tipo R
			ALUSrc 		<= '0'; --seleccionamos el dato que esta en Rt
			MemWrite	<= '0'; --no se va a escribir en memoria
			MemRead		<= '0';
			MemtoReg	<= '0'; --se toma el resultado de la ALU (0) (1 para el resultado de la Memoria)
			Branch 		<= '0'; --

			case Funct is
				when "100000"=>	ALUOp <= "000";-- add
				
				when "101010"=>	ALUOp <= "101";-- slt
				
				when others => null;
			end case;

		-- addi
		when "001000" =>
			ALUOp 		<= "010";
			RegDst		<= '0';
			RegWriteOut	<= '1';
			ALUSrc		<= '1';
			Branch 		<= '0';
			MemWrite	<= '0';
			MemRead		<= '0';
			MemtoReg	<= '0';
		-- beq
		when "000100" =>
			ALUOp 		<= "101";
			RegDst		<= '0';
			RegWriteOut	<= '0';
			ALUSrc		<= '0';
			Branch 		<= '1';
			MemWrite	<= '0';
			MemRead		<= '0';
			MemtoReg	<= '0';
		
		when others => null;
	end case;

end process;
end Behavioral;
