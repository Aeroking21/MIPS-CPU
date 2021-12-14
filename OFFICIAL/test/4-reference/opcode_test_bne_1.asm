addiu s0 $0 0xFFFF
addu s1 $0 v0
bne s0 s1 0x2
addiu v0 $0 0x000A
addiu v0 v1 0x0005
jr $0
addiu v0 v0 0x0003
addiu v0 $0 0x0001
