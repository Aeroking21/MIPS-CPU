lui $s1 0xffff
lui $s2 0x0000ffff
xor $s1 $s2 $v0

#assert ($v0 == 0xffffffff)
