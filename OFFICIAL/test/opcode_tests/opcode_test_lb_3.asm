lui t1 0xffff
srl t1 t1 0x10
sb t1 0x2($0)
addiu $1 $1 0x1
lb v0 0x0($1)
j 0x3f00003
#demonstration of how lb and sb work
#only outputs value to v0 when ($s + 1):8 is the same as for sb
#for sb 