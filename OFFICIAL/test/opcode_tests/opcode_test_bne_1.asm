addiu s0 $0 0xFFFF
addu s1 $0 $2
bne s0 s1 0x2
addiu v1 $0 0x000A
addiu s3 v1 0x0005
addiu v0 s3 0x0003
jr $0

# assert(v == 8)
