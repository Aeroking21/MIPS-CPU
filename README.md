# Team00 ISA Project

### ❗: Please look at the Discussions and Projects subfolder 
Some inspiration: 
1. https://github.com/sts219/MAPS-MIPS-CPU
2. https://github.com/JosiahMendes/MIPS32-T501
3. https://github.com/max-wickham/MipsCPU
4. https://github.com/xw2519/ISA-MIPS-coursework
5. https://github.com/aryanghbd/MIPS-CPU


Instruction Set
===============

The target instruction-set is 32-bit big-endian MIPS1, as defined by
the MIPS ISA Specification (Revision 3.2).

The instructions to be tested are:

Code    |   Meaning                                   
--------|---------------------------------------------
**Shaanuka**| **Shaanuka**
ADDIU   |  Add immediate unsigned (no overflow)      
ADDU    |  Add unsigned (no overflow)                 
AND     |  Bitwise and                               
ANDI    |  Bitwise and immediate                     
BEQ     |  Branch on equal                         
BGEZ    |  Branch on greater than or equal to zero   
BGEZAL  |  Branch on non-negative (>=0) and link  
BGTZ    |  Branch on greater than zero     
**Angelo**| **Angelo**
BLEZ    |  Branch on less than or equal to zero   
BLTZ    |  Branch on less than zero               
BLTZAL  |  Branch on less than zero and link          
BNE     |  Branch on not equal                        
DIV     |  Divide                                     
DIVU    |  Divide unsigned                            
J       |  Jump                                       
JALR    |  Jump and link register  
**Joachim**| **Joachim**
JAL     |  Jump and link                              
JR      |  Jump register                              
LB      |  Load byte                                  
LBU     |  Load byte unsigned                         
LH      |  Load half-word                             
LHU     |  Load half-word unsigned                    
LUI     |  Load upper immediate                       
LW      |  Load word   
**Indraneel**| **Indraneel**
LWL     |  Load word left                             
LWR     |  Load word right                            
MTHI    |  Move to HI                                 
MTLO    |  Move to LO                                 
MULT    |  Multiply                                   
MULTU   |  Multiply unsigned                          
OR      |  Bitwise or                                 
ORI     |  Bitwise or immediate   
**Lucia**| **Lucia**
SB      |  Store byte                                 
SH      |  Store half-word                            
SLL     |  Shift left logical                         
SLLV    |  Shift left logical variable                
SLT     |  Set on less than (signed)                  
SLTI    |  Set on less than immediate (signed)        
SLTIU   |  Set on less than immediate unsigned        
SLTU    |  Set on less than unsigned  
**Aryan**| **Aryan**
SRA     |  Shift right arithmetic                     
SRAV    |  Shift right arithmetic                     
SRL     |  Shift right logical                        
SRLV    |  Shift right logical variable               
SUBU    |  Subtract unsigned                          
SW      |  Store word                                 
XOR     |  Bitwise exclusive or                       
XORI    |  Bitwise exclusive or immediate             
