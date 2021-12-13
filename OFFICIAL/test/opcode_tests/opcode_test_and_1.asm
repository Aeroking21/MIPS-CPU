addiu s0 $0 0x0001
addiu s1 $0 0xFFF3
and v0 s0 s1
jr $0

# assert(v0 == 1)
