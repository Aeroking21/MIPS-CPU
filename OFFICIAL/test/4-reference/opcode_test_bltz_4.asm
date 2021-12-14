addiu s1 s1 0x2
addiu s2 s2 0x1
subu v0 s1 s2
bltz v0 2
j 0x3f00001
addiu v0 v0 0x100
jr $0
#v0 Becomes -1 (4294967295 unsigned), then adds to 255