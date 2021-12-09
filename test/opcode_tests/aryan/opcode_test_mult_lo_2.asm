addiu $s1 $0 0x2A
addiu $s2 $0 0x2B
div $s1 $s2
mflo $ v0

assert v0 == 0
