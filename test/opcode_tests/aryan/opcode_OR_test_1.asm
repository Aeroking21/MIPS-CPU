addiu $s1,$zero,0x2A
addiu $s2,$zero,0x2B
OR $v0.$s1.$s2

assert $v0==0x2b
