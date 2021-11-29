lui $s1 0x2
lui $s2 0x1
slt $s1 $s2 $s3
#assert ($s3 == 0x0)