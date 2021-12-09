addiu s1 s1 0x01
addiu s2 s2 0x02
sltu s1 s2 v0

#assert(v0 == 0x1)
