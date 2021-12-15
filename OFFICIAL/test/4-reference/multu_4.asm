addiu t3 $0 0x0fff
addiu t4 $0 0x0fff
multu t4 t3
mfhi v0
jr $0

#v0 = 0x00000000
