lui t1 0xaaff
srl t1 t1 0x10
addiu s1 s1 0x10
addiu t2 t2 0x0f
sh t1 0x0(s1)
jr $0
lb v0 0x2(s1)