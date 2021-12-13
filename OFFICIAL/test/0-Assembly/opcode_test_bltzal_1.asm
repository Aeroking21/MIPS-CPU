addiu s1 s1 0x2
addiu s2 s2 0x1
subu s3 s1 s2
bltzal s3 2
j 0x3f00001
addiu s3 s3 0x100
addu v0 v0 $31
jr $0