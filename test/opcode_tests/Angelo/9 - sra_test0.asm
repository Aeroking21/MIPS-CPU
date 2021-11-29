lui $s1 0x8
sra $s1 $s2 1

#assert $s2 == (0x4)

lui $s1 0x80000000
sra $s1 $s2 1

#assert $s2 == (0xc)