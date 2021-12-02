
lui $t0.0xf000
lui $t1.0x0ff0
sw t1.0($t0)
lbu $t2.0x2($t0)

assert $t2 == 0xfff00000
