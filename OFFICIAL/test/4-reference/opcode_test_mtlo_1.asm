addiu s4 $0 0x0123
mtlo s4
mflo v0
jr $0

# assert v0 = 0x0123
