# mips-vhdl
Implementação monocíclica da arquitetura MIPS usando VHDL.

## Instruções
Os seguintes são os três formatos usados para o jogo de instrução do núcleo:
Tipo -31 - formato (bits) -0

* `R opcode (6) rs (5) rt (5) rd (5) shamt (5) funct (6)`
* `I opcode (6) rs (5) rt (5) imediato (16)`
* `J opcode (6) endereço (26)`

### Notas
* Registradores de propósito geral (Geral purpose registers, GPRs) são
indicados com um cifrão (`$`).
* `CONST` denota uma constante (“imediato”).
* `OFFSET` denota uma constante usada para compensar uma distância na memória.
* Todas as seguintes instruções são instruções nativas.

## Instruções implementadas
As instruções Add (com overflow), Branch on equal, Set on less than (signed),
Add immediate (com overflow), Load word e Store word foram implementadas
segundo o Trabalho NP2: Professor Jacson Luiz Matte, Curso de Ciência da
Computação, Universidade Federal da Fronteira Sul, Campus Chapecó, disciplina
de Sistemas Digitais 2016/2.

#### Add (com overflow)
Adiciona dois registros, estende sinal de largura de registro.

        0000 00ss ssst tttt dddd d000 0010 0000

Sintaxe: `ADD $1,$2,$3`  
Significado: `$1 = $2 + $3 (signed)`  
format `R`, opcode `0`, funct `20` _(16)_

#### Branch on equal
Vai para a instrução no endereço especificado se os dois registradores tiverem
o mesmo valor.

        0001 00ss ssst tttt iiii iiii iiii iiii

Sintaxe: `BEQ $1,$2,OFFSET`  
Significado: `if ($1 == $2) go to PC+4+OFFSET`  
format `I`

#### Set on less than (signed)
Testa se um registrador é menor do que o outro.

        0000 00ss ssst tttt dddd d000 0010 1010

Sintaxe: `SLT $1,$2,$3`  
Significado: `$1 = ($2 < $3)`  
format `R`

#### Add immediate (com overflow)
Adiciona dois registros, estende sinal de largura de registro.

        0010 00ss ssst tttt iiii iiii iiii iiii

Sintaxe: `ADDI $1,$2,CONST`  
Significado: `$1 = $2 + CONST (signed)`  
format `I`, opcode `8` _(16)_

#### Load word
Carrega a termo armazenada a partir de: `Memória[$2+OFFSET]` e os seguintes 3
bytes.

        1000 11ss ssst tttt iiii iiii iiii iiii

Sintaxe: `LW $1,OFFSET($2)`  
Significado: `$1 = Memória[$2+OFFSET]`  
format `I`, funct `23` _(16)_

#### Store word

        1010 11ss ssst tttt iiii iiii iiii iiii

Armazena um termo em: `Memória[$2+OFFSET]` e os seguintes 3 ​​bytes. A ordem dos
operadores é uma grande fonte de confusão.

Sintaxe: `SW $1,OFFSET($2)`  
Significado: `Memória[$2+OFFSET] = $1`  
format `I`