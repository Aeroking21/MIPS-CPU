addiu s1 $0 0x002A
addiu s2 $0 0x002B
multu s1 s2
mfhi v0

# assert v0 == 0x70E
