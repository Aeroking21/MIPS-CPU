#!/bin/bash
set -eou pipefail

set -eou pipefail


#get a list of all the instructions
INSTRUCTIONS="test/0-Assembly/*.asm"



#loop through every instruction and test them individually
for i in ${INSTRUCTIONS} ; do
    INSTR=$(basename ${i} .asm)
    cat test/5-data/original.mem >> test/5-data/data_${INSTR}.mem
    #test/run_one_testcase.sh ${1} ${INSTR}
done
