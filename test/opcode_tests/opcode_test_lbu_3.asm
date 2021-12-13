addiu v1 $0 0x01FF
sb v1 0x100(v1)
lbu v0 0x100(v1)
jr $0

#(assert v0 = 255)
