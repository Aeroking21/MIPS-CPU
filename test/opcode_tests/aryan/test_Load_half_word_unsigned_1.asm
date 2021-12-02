lui $t0.0xf000
lui $t1.0x0ff0
sw t1.0($t0)
lh $t2.0x0($t0)

assert $t2 == 0xf0000fff
