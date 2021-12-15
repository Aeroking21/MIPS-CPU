addiu s2 s2 3
addiu s1 s1 1
beq s1 s2 0x2
addiu v0 v0 0x1
j 0x3f00001
sll $0 $0 0x0
jr $0
sll $0 $0 0x0