addiu s0 $0 0x0246
addiu t0 $0 0x0002
sll s1 s0 22
divu s1 t0
jr $0
mflo v0
