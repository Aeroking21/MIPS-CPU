addiu $s0, $0, 0x0246
addiu $t0, $0, 0x0002

div $s1, $t0

mfhi $v0

# assert($v0 == 0x0000)
