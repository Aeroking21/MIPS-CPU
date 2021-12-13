addiu $s0, $0, 0x0246
addiu $t0, $0, 0x0002

sll $s1, $s0, 22

div $s1, $t0

mfhi $v0


# after sll $s1 = -3707764736
# assert($v0 == 0x000)
