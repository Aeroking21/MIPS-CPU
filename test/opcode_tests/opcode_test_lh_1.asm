addiu s1 $0 0x45
addiu t1 $0 0x58
mult s1 t1
mflo t2
sw t2 0x100($0)
lhu v0 0x100($0) 
sw v0 0x100($0)
addiu v0 v0 0x0fff
jr $0
