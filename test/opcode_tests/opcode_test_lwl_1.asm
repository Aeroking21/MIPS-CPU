lui $t0.0xf000
lui $t1.0xffff
sw t1.0($t0)
lwl $t2.0x2($t0)

#

assert $t2 == 0xff000000
