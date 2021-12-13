lui s1 0x1010
addiu s1 s1 0x1010
xor v0 s1 $0
jr $0
#assert (v0 = 0x10101010)