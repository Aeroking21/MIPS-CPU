
lui $s1 0x02
lui $s2 0xf
sllv $s2 $s1 $v0 #shift s2 by s1 store in s3

#assert($v0 == 0x3c)
