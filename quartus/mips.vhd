library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MIPS is
  port(
    clk: in std_logic;
    ENDE, AUX: in std_logic_vector(31 downto 0);
    SELY: in std_logic;
    WRITE, READ: in std_logic
  );
end MIPS;

architecture estrutural of MIPS is
  signal PCo, MUX1, MUX2, MUX3, DL1, DL2, ADD1, ADD2, ROT, ALU, DADO, EXT_SIGNAL, MI, DESLO: std_logic_vector(31 downto 0);
  signal REGDEST, ALUSRC, MEMTOREG, REGWRITE, MEMREAD, MEMWRITE, BRANCH, ZERO, AND2: std_logic;
  signal ALUOp: std_logic_vector(1 downto 0);
  signal ALU_OP: std_logic_vector(2 downto 0);
  signal CONT, OPULA: std_logic_vector(5 downto 0);
  signal RS, RT, RDI, RDR, MUX0: std_logic_vector(4 downto 0);
  signal CONST: std_logic_vector(15 downto 0);
  signal TYR: std_logic_vector(31 downto 0);
  
  component ADD is
    port(
      A: in std_logic_vector(31 downto 0);
      B: in std_logic_vector(31 downto 0);
      S: out std_logic_vector(31 downto 0)
    );
  end component;
  
  component AND_2 is
    port(
      A: IN std_logic;
      B: IN std_logic;
      S: OUT std_logic
    );
  end component;
  
  component CONTROLE is
    port(
      A: in std_logic_vector(5 downto 0);
      REGDEST, ALUSRC, MEMTOREG, REGWRITE, MEMREAD, MEMWRITE, BRANCH: out std_logic;
      ALU_OP: out std_logic_vector(1 downto 0)
    );
  end component;
  
  component DECOD is
    port(
      A: in std_logic_vector(31 downto 0);
      CONT: out std_logic_vector(5 downto 0);
      RS, RT, RDI, RDR: out std_logic_vector(4 downto 0);
      CONST: out std_logic_vector(15 downto 0);
      OP_ULA: out std_logic_vector(5 downto 0)
    );
  end component;
  
  component DESLOC is
    port(
      A: in std_logic_vector(31 downto 0);
      S: out std_logic_vector(31 downto 0)
    );
  end component;
  
  component EXT_SINAL is
    port(
      A: in std_logic_vector(15 downto 0);
      S: out std_logic_vector(31 downto 0)
    );
  end component;
  
  component MEM_DADOS is
    port(
      ENDE: in std_logic_vector(31 downto 0);
      DADO: in std_logic_vector(31 downto 0);
      WRITE: in std_logic;
      READ: in std_logic;
      DADO_S: out std_logic_vector(31 downto 0)
    );
  end component;
  
  component MEM_PROG is
    port(
      ENDE, DATA: in std_logic_vector(31 downto 0);
      WRITE, READ: in std_logic;
      INST: out std_logic_vector(31 downto 0)
    );
  end component;
  
  component MUX_4 is
    port(
      A: in std_logic_vector(4 downto 0);
      B: in std_logic_vector(4 downto 0);
      SEL : in std_logic;
      S: out std_logic_vector(4 downto 0)
    );
  end component;
  
  component MUX_32 is
    port(
       A: in std_logic_vector(31 downto 0);
      B: in std_logic_vector(31 downto 0);
      SEL : in std_logic;
      S: out std_logic_vector(31 downto 0)
    );
  end component;
  
  component MUX_REG is
    port(
      I31, I30, I29, I28, I27, I26, I25, I24, I23, I22, I21, I20, I19, I18, I17: IN std_logic_vector(31 downto 0);
      I16, I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0: IN std_logic_vector(31 downto 0);
      SEL: IN std_logic_vector(4 downto 0);
      S: OUT std_logic_vector(31 downto 0)
    ); 
  end component;
  
  component OP_ULA is
    port(
      A: in std_logic_vector(1 downto 0);
      B: in std_logic_vector(5 downto 0);
      S: out std_logic_vector(2 downto 0)
    );
  end component;
  
  component PC is
    port(
      D: IN STD_LOGIC_VECTOR(31 downto 0);
      clk : IN STD_LOGIC;
      Q: OUT STD_LOGIC_VECTOR(31 downto 0)
    );
  end component;
  
  component B_R is
    port(
      clk: in std_logic;
      REG_WRITE: in std_logic;
      RS, RD, RT: in std_logic_vector(4 downto 0);
      DADO_WRITE: in std_logic_vector(31 downto 0);
      DL1, DL2: out std_logic_vector(31 downto 0)
    );
  end component;
  
  component ULA is
    port(
      A: in std_logic_vector(31 downto 0);
      B: in std_logic_vector(31 downto 0);
      SEL: in std_logic_vector(2 downto 0);
      zero: out std_logic;
      S: out std_logic_vector(31 downto 0)
    );
  end component;
  begin
    
  PC0: PC port map(TYR, clk, PCo);
  MUX49: MUX_32 port map(MUX3, AUX, SELY, TYR);
  MEMP: MEM_PROG port map(PCo, ENDE, WRITE, READ, MI);
  DECO: DECOD port map(MI, CONT, RS, RT, RDI, RDR, CONST, OPULA);
  CONTR: CONTROLE port map(CONT, REGDEST, ALUSRC, MEMTOREG, REGWRITE, MEMREAD, MEMWRITE, BRANCH, ALUOp);
  BANCO: B_R port map(clk, REGWRITE, RS, RT, MUX0, MUX2, DL1, DL2);
  MUX01: MUX_4 port map(RT, RDR, REGDEST, MUX0);
  EXT: EXT_SINAL port map(CONST, EXT_SIGNAL);
  ALUP: OP_ULA port map(ALUOp, OPULA, ALU_OP);
  MUX02: MUX_32 port map(DL2, EXT_SIGNAL, ALUSRC, MUX1);
  ULA0: ULA port map(DL1, MUX1, ALU_OP, ZERO, ALU);
  MEMD: MEM_DADOS port map(ALU, DL2, MEMWRITE, MEMREAD, DADO);
  MUX03: MUX_32 port map(ALU, DADO, MEMTOREG, MUX2);
  DELC: DESLOC port map(EXT_SIGNAL, DESLO);
  ADD0: ADD port map(ADD1, DESLO, ADD2);
  MUX04: MUX_32 port map(ADD1, ADD2, AND2, MUX3);
  ADD01: ADD port map(PCo, "00000000000000000000000000000100", ADD1);
  AND01: AND_2 port map(BRANCH, ZERO, AND2); 
end estrutural;