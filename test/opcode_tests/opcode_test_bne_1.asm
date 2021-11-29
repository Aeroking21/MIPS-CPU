addiu $s0, $0, 0x0123
addiu $s1, $0, 0x0007
bne $s0, $s1, 14
addu $v0, $0, $s1


0x60 : addu $v0, $0, $s0 

# assert($v0 == 0x0000)
