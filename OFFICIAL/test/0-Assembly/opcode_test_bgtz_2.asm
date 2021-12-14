addiu s1 $0 0x1
addiu s0 $0 0x0003
subu s0 s0 s1
bgtz s0 0xfffe
addiu s2 s2 0x1
jr $0
addu v0 v0 s2
