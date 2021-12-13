lui s1 0xffff
sra s1 s1 0x10
subu v0 s1 s1
jr $0
#subtracting maximum (0xffffffff) from itself results in 0.
#assert (v0 == 0x0)