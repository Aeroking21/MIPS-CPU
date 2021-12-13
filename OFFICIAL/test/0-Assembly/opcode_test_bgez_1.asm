addu s0 $0 $1
addu s1 $0 $2
bgez s0 0x2
addiu v1 $0 0x000A
addiu s3 v1 0x0001
addiu v0 s3 0x0002
jr $0

# assert(v == 3)
