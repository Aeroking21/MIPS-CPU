addiu s1 s1 0x2
addiu s2 s2 0x1
bne s1 s2 3
addiu v0 v0 0x10
jr $0
j 0x3f00001
jr $0