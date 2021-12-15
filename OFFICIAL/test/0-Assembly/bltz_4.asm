addiu s1 s1 0x1
addiu s2 s2 0x2
subu v0 s2 s1
bltz v0 2
addiu s1 s1 0x1
j 0x3f00002
sll $0 $0 0x0
jr $0
addiu v0 s1 0x100
