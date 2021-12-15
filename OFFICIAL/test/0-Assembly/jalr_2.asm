lui s2 0xBFC0
addiu s2 s2 0x001c
jalr s2
lui s1 0x8888
addiu s1 s1 0x12
jr $0
addu v0 v0 s1
jr $31
addiu v0 s1 0x0
jr $0 
addiu v0 $0 0xffff