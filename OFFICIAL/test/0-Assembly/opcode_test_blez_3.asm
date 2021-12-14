lui s0 0xffff
blez s0 3
addu v0 s0 $0
jr $0
addu v0 t0 $0
jr $0
#assert (v0 == 0x123)
