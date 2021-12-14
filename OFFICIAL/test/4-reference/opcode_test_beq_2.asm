addiu s0 $0 0x123
addiu s1 $0 0x124
beq s0 s1 0x0002
addiu v1 $0 0x000A
addiu s3 v1 0x0001
addiu v0 s3 0x0002
jr $0

# assert(v == 13)
