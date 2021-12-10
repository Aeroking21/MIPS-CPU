addiu s2 $0 0x0001
addiu s1 s2 0x1170
addiu s3 s2 0x01D0
addu v0 s1 s3
addu v0 v0 v0
jr $0

#assert (v0 = 9860)
