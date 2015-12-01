library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS is
	port (
		clk 	: in  std_logic;
		enable 	: in  std_logic
	);
end MIPS;

architecture Behavioral of MIPS is
-- Componentes
	component PC
    port (
		PC_clk	: in  std_logic;
		PC_en	: in  std_logic;
		PC_in	: in  std_logic_vector (31 downto 0);
		PC_out	: out std_logic_vector (31 downto 0)
	);
	end component;

	component PcPlusFour
    port ( 
		PcPlusFour_PC_out		: in  std_logic_vector (31 downto 0);
		PcPlusFour_out 			: out std_logic_vector (31 downto 0)
    );
	end component;

	component  ALU
    port (
		ALU_entrada1 : in  std_logic_vector (31 downto 0);
		ALU_entrada2 : in  std_logic_vector (31 downto 0);
		ALU_ctrl	 : in  std_logic_vector (2 downto 0);
		ALU_zero	 : out std_logic;
		ALU_out		 : out std_logic_vector (31 downto 0)
	);
	end component;

	component SEU
    port (
		SEU_in	: in  std_logic_vector (15 downto 0);
		SEU_out	: out std_logic_vector (31 downto 0)
	);
	end component;

	component InstructionMemory
    port (
		Instruction_Adress	: in  std_logic_vector (31 downto 0);
		Instruction 		: out std_logic_vector (31 downto 0)
	);
	end component;

	component Reg
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
	end component;

	component ControlUnit
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
	end component;

	component muxPC
    port ( 
		muxPC_PC_out		: in  std_logic_vector (31 downto 0);
		muxPC_ALU_out		: in  std_logic_vector (31 downto 0);
		muxPC_sel 	 		: in  std_logic;
		muxPC_out 			: out std_logic_vector (31 downto 0)
    );
	end component;

	component muxALU
    port ( 
		muxALU_DL2 		: in  std_logic_vector (31 downto 0);
		muxALU_SEU_out 	: in  std_logic_vector (31 downto 0);
		muxALU_sel 		: in  std_logic;
		muxALU_out 		: out std_logic_vector (31 downto 0)
    );
	end component;

	component muxReg
    port ( 
		muxReg_Instruction	: in  std_logic_vector (31 downto 0);
		muxReg_sel 	 		: in  std_logic;
		muxReg_out 			: out std_logic_vector (4 downto 0)
    );
	end component;

	component muxMem
    port (
		muxMem_sel 		: in  std_logic;
    	muxMem_in		: in  std_logic_vector(31 downto 0);
		muxMem_out 		: out std_logic_vector(31 downto 0)
    );
	end component;

-- Sinais
signal PC_out : std_logic_vector(31 downto 0);
signal PcPlusFour_out: std_logic_vector(31 downto 0);
signal ALU_zero : std_logic;
signal ALU_out : std_logic_vector(31 downto 0);
signal SEU_out : std_logic_vector(31 downto 0);
signal Instruction : std_logic_vector(31 downto 0);
signal Reg_DL1 : std_logic_vector(31 downto 0);
signal Reg_DL2 : std_logic_vector(31 downto 0);
signal ALUOp : std_logic_vector(2 downto 0);--operacion a realizar en la ALU //ALUOp
signal RegDst : std_logic;--habilita en cual registro se va a escribir //RegDst
signal ALUSrc : std_logic;--habilita el Rt o el Inm_extendido //alu_src_b
signal MemtoReg : std_logic;--habilita cual dato se enviara a escribir //MemtoReg
signal RegWriteOut : std_logic;--habilita la escritura en un registro//RegWrite
signal MemRead : std_logic;--habilita la lectura en memoria //MemRead
signal MemWrite : std_logic;--habilita la escritura en memoria //MemWrite
signal Branch : std_logic;
signal muxPC_out : std_logic_vector(31 downto 0);
signal muxALU_out : std_logic_vector(31 downto 0);
signal muxReg_out : std_logic_vector(4 downto 0);
signal muxMem_out : std_logic_vector(31 downto 0);

begin
-- Instâncias
	Inst_PC: PC port map(
		PC_clk	=> clk,
		PC_en	=> enable,
		PC_in	=> muxPC_out
	);

	Inst_PcPlusFour: PcPlusFour port map(
		PcPlusFour_PC_out => PC_out
	);

	Inst_ALU: ALU port map(
		ALU_entrada1 => Reg_DL1,
		ALU_entrada2 => muxALU_out,
		ALU_ctrl	 => ALUOp
	);

	Inst_SEU: SEU port map(
		SEU_in	=> Instruction(15 downto 0)
	);

	Inst_InstructionMemory: InstructionMemory port map(
		Instruction_Adress	=> PC_out
	);

	Inst_Reg: Reg port map(
    	Reg_clk		=> clk,
    	RegWriteIn 	=> RegWriteOut,
    	RS			=> Instruction(25 downto 21),
    	RT			=> Instruction(20 downto 16),
    	RD			=> muxReg_out,
    	Reg_Data	=> muxMem_out
	);

	Inst_ControlUnit: ControlUnit port map(
		Op 		=> Instruction(31 downto 26),
		Funct 	=> Instruction(5 downto 0)
	);

	Inst_muxPC: muxPC port map (
		muxPC_PC_out	=> PC_out,
		muxPC_ALU_out	=> PcPlusFour_out,
		muxPC_sel 	 	=> '0'
    );

	Inst_muxALU: muxALU port map (
		muxALU_DL2 		=> Reg_DL2,
		muxALU_SEU_out 	=> SEU_out,
		muxALU_sel 		=> ALUSrc
    );

	Inst_muxReg: muxReg port map (
		muxReg_Instruction	=> Instruction,
		muxReg_sel 	 		=> RegDst
    );

	Inst_muxMem: muxMem port map(
		muxMem_sel 	=> '0',
    	muxMem_in	=> ALU_out
    );

end Behavioral;