addiu s4 $0 0xf123
mthi s4
mfhi v0
jr $0

# assert v0 = 0xFFFFF123
