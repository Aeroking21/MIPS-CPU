jal $0
nop
addiu $s0 $0 0x2A
ORi $v0 $s0 0xffff

assert $v0==0xffff
