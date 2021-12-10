addiu s1 $0 0x0000
addiu t2 $0 0xffff
mult s1 t2
mflo v0
jr $0
