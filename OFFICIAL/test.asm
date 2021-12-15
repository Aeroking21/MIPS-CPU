addiu t0 $0 0x12AA
sb t0 0x0002($0)
jr $0
lw v0 0x0000($0)

.data
00 00 00 F3