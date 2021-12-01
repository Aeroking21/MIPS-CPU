lui $s1 0x80 #10000000
lui $s2 0x2  #10
srav $s2 $s1 $s3

#assert ($s3 == 0x20)