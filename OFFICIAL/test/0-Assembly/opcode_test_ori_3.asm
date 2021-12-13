lui s0 0x000F
ori v0  s0 0x002B
jr $0

assert v0 == 0x000F002B
