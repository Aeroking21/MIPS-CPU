#!/bin/bash
set -eou pipefail

Opcode="$2"

>&2 echo "Currently testing Harvard CPU with ${Opcode}"


TestCases="test/0-Assembly/opcode_test_${Opcode}_*.asm"

for i in $TestCases; do
        TESTNAME=$(basename ${i} .asm)
        # i is basically the opcode test


        >&2 echo "2 - Compiling test-bench"
        # Verilog compilation -- ask for help, I have no clue
        iverilog -g 2012 \
        -s CPU_tb \
        -P CPU_tb.RAM_INIT_FILE=\"test/testcases/${Opcode}_ram_init.mem\" \
        -o CPU_tb test/CPU_tb.v test/ROM.v rtl/mips_cpu_harvard.v rtl/alu.v rtl/loadstore.v rtl/RAM.v



        >&2 echo "3 - Running test-bench"
        # Run the simulator, and capture all output to a file
        set +e
        test/2-simulator/CPU_tb > test/3-output/CPU_tb_${i}.stdout
        # Capture the exit code of the simulator in a variable
        RESULT=$?
        set -e

        if [[ "${RESULT}" -ne 0 ]] ; then
          # fail condition
           echo "${TESTNAME} Fail"
           continue
        fi

        # we now need to extract the necessary lines with the prefix "RESULT : "
        # The associated value is then output and written into a .out file
        # so that we can compare it to the reference output result files
        PATTERN="RESULT : "
        NOTHING=""

        set +e
        # grep grabs the lines with the prefix described by PATTERN and outputs them to a new file
        grep "${PATTERN}" test/3-output/CPU_Harvard_bus_${TESTNAME}.stdout > \
        test/3-output/CPU_Harvard_bus_${TESTNAME}.result-lines

        # Now we need to remove the "RESULT : " bit and maintain the correct value
        set -e
        sed -e "s/${PATTERN}/${NOTHING}/g" test/3-output/CPU_MU0_bus_${TESTNAME}.result-lines \
        > test/3-output/CPU_MU0_bus_${TESTNAME}.out
        # Actual final result of the test case is stored in a .out file
        # Note that the output of this will have spaces before the actual value but
        # this shouldn't have an effect when comparing to the reference files

        >&2 echo " 4 - Comparing to the reference output files for ${TESTNAME}"
        # Here we compare the generated output files from part 3 with the pre-generated
        # output files in 4-reference

        set +e # +e used to stop the script failing if an error occurs
        >&2 diff -w test/4-reference/${TESTNAME}.out test/3-output/CPU_MU0_bus_${TESTNAME}.out
        RESULT=$? # output of this diff line stored in RESULT
        set -e

        # Based on whether differences were found, either pass or fail
        if [[ "${RESULT}" -ne 0 ]] ; then
          # fail condition
           echo "${TESTNAME} ${TESTNAME} Fail"
        else
          # pass condition
           echo "${TESTNAME} ${TESTNAME} Pass"
        fi

done
















































