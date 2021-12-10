jal $0
nop
lui $v0 0x0000f0ff

assert v0 == 0xf0ff0000
