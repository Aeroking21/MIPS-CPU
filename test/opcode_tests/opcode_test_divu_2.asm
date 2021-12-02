addiu $s0, $0, 0x0246
addiu $t0, $0, 0x0002

not $s1, $s0

div $s1, $t0

mflo $v0

# assert($v0 == ??idk)
