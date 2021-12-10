addiu t0 $0 0xFFFF
andi v0 t0 0x0001
jr $0

# assert(v0 == 1)
