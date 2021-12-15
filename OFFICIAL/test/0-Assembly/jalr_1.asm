lui s1 0xBFC0
addiu s1 s1 0x001c
jalr s1
addiu s2 s2 0x1110
jr $0
addiu v0 s2 0x1
addiu s2 s2 0xffff
addiu s2 s2 0x1 
jr $31
sll $0 $0 0x0
jr $0
addiu v0 v0 0xffff