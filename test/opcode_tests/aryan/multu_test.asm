li $s1.0x2A
lI $s2.0x2B
multu $s1 $s2
mfhi $ v0

assert v0 == 0x70E
