addiu t2 $0 0x00F1
sb t2 0x100(t2)
lbu v0 0x100(t2)
jr $0

# (assert v0 = 241)
