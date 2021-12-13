addiu s1 s1 0xBFC0
addiu s2 s2 0x8
addiu s2 s2 0x8
sllv s3 s1 s2
addiu s3 s3 28
jalr s3
addiu v0 v0 1
addu v0 v0 $31