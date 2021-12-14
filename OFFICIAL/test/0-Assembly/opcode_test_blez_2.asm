addiu s0 $0 0x0123
blez s0 0x3
addu v0 $0 s0
jr $0
addu v0 v0 s0
jr $0
addiu v0 $0 0xffff
