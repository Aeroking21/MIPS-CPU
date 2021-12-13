addiu s4 $0 0xFFFF
mtlo s4
mflo v0
jr $0

# assert v0 = 0xFFFFFFFF
