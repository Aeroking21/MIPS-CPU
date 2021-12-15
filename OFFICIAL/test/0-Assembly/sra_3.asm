lui v0 0x4000
addiu s1 s1 0x4
sra v0 v0 0x8
beq v0 s1 2
j 0x3f00002
jr $0
#will shift 2 hex at a time until v0 = 0