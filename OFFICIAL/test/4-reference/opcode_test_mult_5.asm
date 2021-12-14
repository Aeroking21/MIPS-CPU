addiu t0 $0 0x0002
addiu t1 $0 0xFFFF
mult t0 t1
mfhi v0
jr $0

# v0 = 0xFFFFFFFF
