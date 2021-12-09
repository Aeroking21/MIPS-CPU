addiu $s1 $0 0x2A
addiu $s2 $0 0xffff
OR V0 $S1 $S2

assert v0 == 0xffff
