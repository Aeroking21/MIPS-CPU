addiu $s1 $0 0x0
addiu $s2 $0 0xffff
mult $s1 $s2
mflo $ v0

assert v0 == 0
