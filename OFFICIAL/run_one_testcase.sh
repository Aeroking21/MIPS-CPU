#!/bin/bash
set -eou pipefail

Opcode="$2"

>&2 echo "Currently testing Harvard CPU using test-case ${Opcode}"

TestCases="test/opcode_tests/opcode_test_${Opcode}_*.asm"

>&2 echo " 2 - Compiling test-bench"




>&2 echo "  3 - Running test-bench"












































iverilog -g 2012 \
        -s CPU_tb \
        -P CPU_tb.RAM_INIT_FILE=\"test/testcases/${Opcode}_ram_init.mem\" \
        -o CPU_tb test/CPU_tb.v test/ROM.v rtl/mips_cpu_harvard.v rtl/alu.v rtl/loadstore.v rtl/RAM_*.v