lui v0 0x4000
addiu s1 s1 0x4
srav v0 v0 s1
beq v0 s1 2
j 0x3f00002
jr $0
#will shift 1 hex at a time 