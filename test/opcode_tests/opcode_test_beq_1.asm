addiu s0 $0 0x123
addiu s1 $0 0x123
beq s0 s1 0x0002
addiu v0 $0 0x000A
addiu s3 s2 0x0001
addiu v0 v0 0x0002
jr $0

# assert(v == 2)
