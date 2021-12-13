addiu t0 $0 0x0001
addiu s1 $0 0x0001
bgezal t0 0x2
addiu v1 $0 0x000A
addiu s3 v1 0x0005
addiu s0 s3 0x0004
addiu v0 $31 0x0
jr $0

# assert (v0 = 3217031180)
