addiu $s0, $0, 0x0246
addiu $t0, $0, 0x0002

sll $s1, $s0, 22

mflo $v0

# assert($v0 == -1853882368)
