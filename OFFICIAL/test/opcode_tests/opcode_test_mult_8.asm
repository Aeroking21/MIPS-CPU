addiu t3 $0 0xFFFF
addiu t4 $0 0xFFFE
mult t4 t3
mflo v0
jr $0

# v0  = 0x00000002
