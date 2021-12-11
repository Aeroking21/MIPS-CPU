addiu $t0, $0, 0x0123
not $s0, $t0
blez $s0, 14
addu $v0, $0, $0


0x60 : addu $v0, $0, $s0 

# assert($v0 == 0x0123)
