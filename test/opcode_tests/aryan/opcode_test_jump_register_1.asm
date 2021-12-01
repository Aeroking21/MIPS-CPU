jal $zero
nop
jr $zero 
addiu v1 $ra 0x3 
nop

assert v1 = bfc00007
