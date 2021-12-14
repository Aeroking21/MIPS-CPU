addiu t1 $0 0x0123
sw t1 0x104($0)
lw v0 0x104($0)
jr $0

# assert v0 = 0x00000123
