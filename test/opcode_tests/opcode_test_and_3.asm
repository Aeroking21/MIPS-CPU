addiu s0 $0 0xFFFF
addiu t0 $0 0xFFFF
and v0 s0 t0
jr $0

# assert(v0 == 4394967295)
