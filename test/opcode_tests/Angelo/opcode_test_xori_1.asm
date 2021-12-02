#Test 0A

lui $s1 0xffff
xori $s1 $s2 0xffff0000

#assert ($s2 == 0xffffffff)
