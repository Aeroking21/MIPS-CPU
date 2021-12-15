#!/bin/bash
set -eou pipefail

gcc assemble.cpp -lstdc++ -o assemble.out

TestCases="test/0-Assembly/opcode_test_${Opcode}_*.asm"

echo " Assembling test cases"

for i in $TestCases; do
  TESTNAME=$(basename ${i} .asm)
  # This basically converts the assembly to hex using the assembler
  ./assemble.out $i > test/testcases/${TESTNAME}_instructions.mem

done