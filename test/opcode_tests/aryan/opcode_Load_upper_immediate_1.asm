lui $v1 0xFFFF
addiu $v0 $v1 0x00FF
jr $zero
nop

# assert v0 = 0xFFFF00FF
