jal $0
nop
addiu $s1,$zero,0x2A
addiu $v0,$zero,0x2B
div $s1 $v0
mfhi $ v0

assert v0 == 0x0
