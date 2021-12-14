addiu s0 $0 0x123
bgtz s0 0x02
addiu s1 $0 0x0002
addiu v0 s1 0x0008
jr $0

# assert (v0 == 8) jumps to line 4 and ignores line 3
