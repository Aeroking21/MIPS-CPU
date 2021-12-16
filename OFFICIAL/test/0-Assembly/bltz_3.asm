addiu s1 $0 0x1
addiu s0 $0 0xfffd
addu s0 s0 s1
bltz s0 0xfffe
addiu v0 v0 0x1
jr $0
addu v0 v0 s2