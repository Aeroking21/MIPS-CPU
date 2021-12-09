addiu t0 $0 0x0003
addiu t1 $0 0xffff
mult t0 t1
mfhi v0
jr $0
