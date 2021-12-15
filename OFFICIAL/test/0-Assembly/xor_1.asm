addiu s1 s1 0xffff
addiu s3 s3 0x0020
sllv s1 s1 s3
addiu s2 s2 0xffff
jr $0
xor v0 s1 s2
