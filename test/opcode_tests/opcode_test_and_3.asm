addiu $s0, $0, 0xFFFF
addiu $t0, $0, 0x0001
jr $0
and $v0, $s0, $0

# assert($v0 == 4'h0001)
