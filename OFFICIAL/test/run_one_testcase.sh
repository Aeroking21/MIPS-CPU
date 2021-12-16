#!/bin/bash
set -eou pipefail

Opcode="$2"


TestCases="test/0-Assembly/${Opcode}_*.asm"

for i in $TestCases; do
        TESTNAME="$(basename ${i} .asm)"

 

        iverilog -g 2012 \
        -s CPU_tb \
        -P CPU_tb.ROM_INIT_FILE=\"test/1-binary/${TESTNAME}_instructions.mem\" \
        -P CPU_tb.RAM_INIT_FILE=\"test/5-data/data_${TESTNAME}.mem\" \
        -o test/2-simulator/CPU_tb_${TESTNAME} test/CPU_tb.v test/ROM.v ${1}/mips_cpu_harvard.v ${1}/mips_cpu_alu.v ${1}/mips_cpu_loadstore.v test/RAM.v



        set +e
        test/2-simulator/CPU_tb_${TESTNAME} > test/3-output/cpu_harvard_${TESTNAME}.stdout
        RESULT=$?
        set -e
    
        if [[ "${RESULT}" -ne 0 ]] ; then
          echo "  $TESTNAME  $Opcode  Fail"
          continue
        fi

        PATTERN="RESULT = "
        NOTHING=""

        set +e
        grep "${PATTERN}" test/3-output/cpu_harvard_${TESTNAME}.stdout > \
        test/3-output/cpu_harvard_${TESTNAME}.result-lines


        set -e
        sed -e "s/${PATTERN}/${NOTHING}/g" test/3-output/cpu_harvard_${TESTNAME}.result-lines \
        > test/3-output/cpu_harvard_${TESTNAME}.out
      

        set +e 
        diff -w test/4-reference/${TESTNAME}.out test/3-output/cpu_harvard_${TESTNAME}.out  > /dev/null 2>&1
        RESULT=$? 
        set -e

        # Based on whether differences were found, either pass or fail
        if [[ "${RESULT}" -ne 0 ]] ; then
          # fail condition
          echo "  $TESTNAME  $Opcode  Fail"
        else
          # pass condition
          echo "  $TESTNAME  $Opcode  Pass"
        fi

done







