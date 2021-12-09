addiu s1 s1 0xffff0000
addiu s2 s2 0x0000ffff
xor s1 s2 v0

#assert ($v0 == 0xffffffff)
