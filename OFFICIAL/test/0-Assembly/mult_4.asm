addiu t0 $0 0x0002
addiu t1 $0 0xFFFF
mult t0 t1
jr $0
mfhi v0
