#!/bin/bash
set -eou pipefail


#get a list of all the instructions
INSTRUCTIONS="test/0-Assembly/*_1.asm"


#loop through every instruction and test them individually
for i in ${INSTRUCTIONS} ; do
    INSTR=$(basename ${i} _1.asm)
    test/run_one_testcase.sh ${1} ${INSTR}
    echo "--------------------------"
done