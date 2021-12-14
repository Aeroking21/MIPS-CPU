addiu s0 $0 0xFFFF
bgtz $0 0x02
addiu s1 $0 0x0002
addiu v0 s1 0x0008
jr $0

# assert(v==0)
