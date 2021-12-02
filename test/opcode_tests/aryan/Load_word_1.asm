lui $t1.0xffff
addu $t0.$t1

lw $v0.0x22($t1)

assert == 0xffff0022
