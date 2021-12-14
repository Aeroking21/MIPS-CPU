addiu v1 $0 0xF
sb v1 0x22(v1)
lbu v0 0x22(v1)
jr $0

# (assert v0 = 15)
