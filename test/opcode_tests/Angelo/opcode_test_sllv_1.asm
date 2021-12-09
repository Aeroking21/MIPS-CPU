
addiu $s1 $s1 0x02
addiu $s2 $s2 0xf
sllv $s2 $s1 $v0 
#shift s2 by s1 store in s3

#assert($v0 == 0x3c)
