lui t1 0x00ff
srl t1 t1 0x10
addiu $1 $1 0x10
addiu t2 t2 0x0f
sb t1 0x0($1)
lb v0 0x1(t2)
#works as a combined test of sb and lb. 
#assert (v0 == 0xffffffff) -> Sign extended contents of lower byte of t1.