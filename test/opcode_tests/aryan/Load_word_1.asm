lui $t1.0xffff
addiu $t0.$t1.0x0000

lw $v0.0x22($t1)

assert $v0 == 0xffff0022
