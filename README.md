# Team00 ISA Project

### ❗: Please look at the Discussions and Projects subfolder 
Some inspiration: 
1. https://github.com/sts219/MAPS-MIPS-CPU
2. https://github.com/JosiahMendes/MIPS32-T501
3. https://github.com/max-wickham/MipsCPU
4. https://github.com/xw2519/ISA-MIPS-coursework
5. https://github.com/aryanghbd/MIPS-CPU

## How to compile 
1. Go to the OFFICIAL directory
2. Compile the assembler with `gcc assemble.cpp -lstdc++ -o assemble.out` (If it says permission denied run `chmod u+x assemble.cpp`)
3. Change the content of the `test.asm` file to the assembly code you want to test (Check below for format/syntax)
4. Assemble the instructions with `./assemble.out test.asm > instructions.mem`
5. Compile all the verilog files with `iverilog -Wall -g 2012 -s CPU_tb -o cpu_tb test/CPU_tb.v test/ROM.v rtl/mips_cpu_harvard.v rtl/alu.v`
6. Run the output file with `./cpu_tb`
7. Check waveforms with `gtkwave CPU_TB.vcd`
8. Log every bug you find (missbehaving instruction, solution, etc.. so we can discuss together later)

## Assembly instruction format
Every testcase needs to meet the following requirements (assembler wont work otherwise)
- no commas
- Register 0 is called $0
- registers dont need "$" when their register named is used but it is needed when you use the number, for example v0 and $3

For now all test cases also need to meet the following requirements (because of how the CPU and test bench are structured for now)
- substitute all "lui" instructions with an "addiu" instruction. all you need to do is 
    1. change the instruction name and 
    2. add $0 between the first register and the immediate
- add a jr $0 instruction at the end
- make sure the final value of the test bench (the one whose value we want to assert) is in v0. If it isn´t add a "addu v0 reg_in_which_the_value_is $0" before the final jr instruction 

If assembly still does not work check https://github.com/JosiahMendes/MIPS32-T501/tree/master/test/testcases/addiu test cases for the instructions that you are trying to test, make sure you match their syntax and update this section with the rules you have found out. 

## to help with debugging 
- ALU_code is what tells the ALU what instructions to perform. The codes are: 
          - 0: multiplication 
          - 1: addition 
          - 2: set on less than 
          - 3: set on less than unsigned
          - 4: and
          - 5: or 
          - 6: xor
          - 7: lui 
          - 8: shift left logic 
          - 9: multiplication unsigned
          - 10: shift right logical 
          - 11: shift right arithmetic
          - 12: divide unsigned 
          - 13: divide 
          - 14: shift right logic variable
          - 15: shift right arithmetic variable 



**TODO** Indraneel still has to do Jump, BGTZAL, BLTZAL
Instruction Set
===============

The target instruction-set is 32-bit big-endian MIPS1, as defined by
the MIPS ISA Specification (Revision 3.2).

The instructions to be tested are:

Code    |   Meaning                                   
--------|---------------------------------------------
**Shaanuka**| 
ADDIU   |  Add immediate unsigned (no overflow)      
ADDU    |  Add unsigned (no overflow)                 
AND     |  Bitwise and                               
ANDI    |  Bitwise and immediate                     
BEQ     |  Branch on equal                         
BGEZ    |  Branch on greater than or equal to zero   
BGEZAL  |  Branch on non-negative (>=0) and link  
BGTZ    |  Branch on greater than zero     
**Angelo**| 
BLEZ    |  Branch on less than or equal to zero   
BLTZ    |  Branch on less than zero               
BLTZAL  |  Branch on less than zero and link          
BNE     |  Branch on not equal                        
DIV     |  Divide                                     
DIVU    |  Divide unsigned                            
J       |  Jump                                       
JALR    |  Jump and link register  
**Joachim**| 
JAL     |  Jump and link                              
JR      |  Jump register                              
LB      |  Load byte                                  
LBU     |  Load byte unsigned                         
LH      |  Load half-word                             
LHU     |  Load half-word unsigned                    
LUI     |  Load upper immediate                       
LW      |  Load word   
**Indraneel**| 
LWL     |  Load word left                             
LWR     |  Load word right                            
MTHI    |  Move to HI                                 
MTLO    |  Move to LO                                 
MULT    |  Multiply                                   
MULTU   |  Multiply unsigned                          
OR      |  Bitwise or                                 
ORI     |  Bitwise or immediate   
**Lucia**| 
SB      |  Store byte                                 
SH      |  Store half-word                            
SLL     |  Shift left logical                         
SLLV    |  Shift left logical variable                
SLT     |  Set on less than (signed)                  
SLTI    |  Set on less than immediate (signed)        
SLTIU   |  Set on less than immediate unsigned        
SLTU    |  Set on less than unsigned  
**Aryan**|
SRA     |  Shift right arithmetic                     
SRAV    |  Shift right arithmetic                     
SRL     |  Shift right logical                        
SRLV    |  Shift right logical variable               
SUBU    |  Subtract unsigned                          
SW      |  Store word                                 
XOR     |  Bitwise exclusive or                       
XORI    |  Bitwise exclusive or immediate             
