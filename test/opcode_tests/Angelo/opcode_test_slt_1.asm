addiu s1 s1 0x2
addiu s2 s2 0x1
slt s1 s2 v0
#assert ($v0 == 0x0)
