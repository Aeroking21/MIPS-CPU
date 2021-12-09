jal $0
nop
addiu $s1 $0 0x2A
addiu $v0 $0 0x2B
multu $s1 $v0
mfhi $ v0

assert v0 == 0x70E
