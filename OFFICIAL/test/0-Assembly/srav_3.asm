lui s0 0x4000
addiu s1 s1 0x4000
addiu s2 s2 0x8
srav s0 s0 s2
beq s0 s1 2
sll $0 $0 0x0
j 0x3f00003
addiu v0 v0 0x1
jr $0
sll $0 $0 0x0 