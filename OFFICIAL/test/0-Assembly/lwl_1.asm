lui t0 0xa0
addiu t1 $0 0xffff
sw t0 0x100($0)
lwl t1 0x101($0)
jr $0
addu v0 t1 $0