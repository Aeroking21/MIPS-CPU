addiu s0 $0 0x0123
blez s0 14
addu v0 $0 $0
jr $0
# assert($v0 == 0x0000)
