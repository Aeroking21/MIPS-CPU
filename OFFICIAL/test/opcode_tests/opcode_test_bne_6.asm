addiu v1 $0 0x6
addiu v0 v0 0x1
addiu v0 v0 0x1
bne v1 v0 0xFFFF
jr $0

# (assert v0 = 6)
