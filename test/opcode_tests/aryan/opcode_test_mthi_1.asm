addiu s4 $0 0x0123
mthi s4
mfhi v0
jr $0

# assert v0 = 0x0123
