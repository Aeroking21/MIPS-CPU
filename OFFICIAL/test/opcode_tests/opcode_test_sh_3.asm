addiu s1 $0 0xFFFF
addiu s2 $0 0x1
mult s1 s2
mfhi s3
sh s3 0x2(v0)
lw v0 0x2(v0)
jr $0

# (assert v0 = 65535)
