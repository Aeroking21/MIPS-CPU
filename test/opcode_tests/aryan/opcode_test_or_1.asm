addiu s1 $0 0x002A
addiu s3 $0 0x002B
OR v0 s1 s3
jr $0

assert $v0==0x2b
