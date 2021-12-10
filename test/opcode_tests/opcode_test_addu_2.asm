addiu t0 $0 0xFFFF
addiu t1 $0 0xFFFF
addu v0 t0 t1
jr $0

# assert(v0 = 4294967294)
