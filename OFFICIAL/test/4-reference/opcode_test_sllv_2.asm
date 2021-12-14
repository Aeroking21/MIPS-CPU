addiu v0 v0 0xfff
sll v0 v0 0x4
addiu v0 v0 0xf
addiu s1 s1 0x10
sllv v0 v0 s1
#assert (v0 == 0xffff0000)
