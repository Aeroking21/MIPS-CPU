addiu s1 $0 0x002A
addiu s3 $0 0x002B
mult s1 s3
mflo v0
jr $0

# v0 = 0x0000070E
