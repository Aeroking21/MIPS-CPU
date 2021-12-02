addiu $s0, $0, 0xFFFFFFFF
jr $0
and $v0, $s0, $0

# assert($v0 == 8'hFFFFFFFF)
