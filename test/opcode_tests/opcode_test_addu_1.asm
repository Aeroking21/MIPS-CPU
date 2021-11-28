lui $s2, 0x0001
addiu $s1, $s2, 0x1170
addiu $s3, $s2, 0x01D0
addu $v0, $s1, $s3
addiu $v1, $v0, 0x0FA0

# assert($v1 = 140,000)
# assert($v0 = 136,000)
