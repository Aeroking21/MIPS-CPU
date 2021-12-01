addiu $s0, $0, 0x123
bgez $0, 14
addu $v0, $0, $0


0x60 : addu $v0, $0, $s0 

# assert($v0 == 0x123)
