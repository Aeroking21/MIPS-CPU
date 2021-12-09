jal $0
nop
addiu $s1 $0 0x0
addiu $s2 $0 0x1
OR v0 $s1 $s2

assert v0 == 0x1
