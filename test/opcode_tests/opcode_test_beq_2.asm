addiu $s0, $0, 0x123
addiu $s1, $0, 0x123
beq $s0, $s1, 14
addu $v0, $0, $0


0x60 : addu $v0, $0, $s0 

# assert($v0 == 0x123)