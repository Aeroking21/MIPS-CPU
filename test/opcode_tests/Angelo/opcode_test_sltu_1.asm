lui $s1 0x01
lui $s2 0x02
sltu $s1 $s2 $s3 

#assert($s3 == 0x1)