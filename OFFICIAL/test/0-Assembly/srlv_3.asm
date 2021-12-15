lui v0 0x8000
addiu s1 s1 0xffff
srlv v0 v0 s1
jr $0
#assert (v0 == 0x0)