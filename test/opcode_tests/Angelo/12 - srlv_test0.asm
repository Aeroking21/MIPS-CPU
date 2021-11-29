lui $s1 0x1
lui $s2 0x8
srlv $s1 $s2 $s3

#assert ($s3 == 0x4)