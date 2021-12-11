addiu s0 0xFFFF
xori v0  s0 0xFFFF
jr $0

# assert v0 = 0xFFFF0000
