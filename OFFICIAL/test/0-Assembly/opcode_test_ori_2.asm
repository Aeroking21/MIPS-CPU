addiu s0 $0 0x002A
ori v0 s0 0xffff
jr $0

#assert $v0==0xffff