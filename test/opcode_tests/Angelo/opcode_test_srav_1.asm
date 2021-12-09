addiu s1 s1 0x80 
addiu s2 s2 0x2
srav s2 s1 v0

#assert (v0 == 0x20)
