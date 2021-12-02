addiu $s1,$zero,0x2A
addiu $s2,$zero,0x2B
multu $s1 $s2
mfhi $ v0

assert v0 == 0x70E
