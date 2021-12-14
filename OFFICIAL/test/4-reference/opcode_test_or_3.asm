addiu s1 $0 0x0000
addiu s2 $0 0x0001
or v0 s1 s2
jr $0

# assert v0 == 0x1
