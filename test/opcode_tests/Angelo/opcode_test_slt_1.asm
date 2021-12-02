lui $s1 0x2
lui $s2 0x1
slt $s1 $s2 $v0
#assert ($v0 == 0x0)
