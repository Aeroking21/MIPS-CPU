addiu s1 s1 0xfff
sll s1 v0 0x14 #assert (v0 == 0xfff00000)
sra v0 v0 0x4  #assert (v0 == 0xffff0000)
sra v0 v0 0x4  #assert (v0 == 0xfffff000)
sra v0 v0 0x4  #assert (v0 == 0xffffff00)
sra v0 v0 0x4  #assert (v0 == 0xfffffff0)
sra v0 v0 0x4  #assert (v0 == 0xffffffff)
jr $0