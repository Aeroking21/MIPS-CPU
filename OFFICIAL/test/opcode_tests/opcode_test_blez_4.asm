addiu s1 s1 0x3
addiu s2 s2 0x1
subu v0 s1 s2
blez v0 2
j 0x3f00001
addiu v0 v0 0x100
jr $0
