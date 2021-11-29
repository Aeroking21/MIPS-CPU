#Test0A

lui $s1 0xffff
lui $s2 0x0000ffff
xor $s1 $s2 $s3

#assert ($s3 == 0xffffffff)

#Test0B

lui $s1 0x0
lui $s2 0x0
xor $s1 $s2 $s3

#assert ($s3 == 0x0)

#Test0C

lui $s1 0xf0f0f0f0
lui $s2 0xf0f0f0f0
xor $s1 $s2 $s3

#assert ($s3 == 0x0)