lui v0 0x4000
lui s1 0xffff
srav v0 v0 s1
#expeted behaviour: assert (v0 == 0)