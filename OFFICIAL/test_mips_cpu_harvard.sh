#!/bin/bash
set -eou pipefail

if [[ -f "$1/mips_cpu_harvard.v" ]]; then

  echo "Building in progress....." > /dev/stderr

  # Testing all possible instructions
  if [[ $# == 1 ]]; then
    echo "Procedding to run all test cases" > /dev/stderr
    chmod +x ./run_all_testcase.sh
    ./run_one_testcase.sh $1

  # Testing only the instructions they provide
  elif [[ $# == 2 ]]; then
    echo "Procedding to run $2 test case " > /dev/stderr
    chmod +x ./run_one_testcase.sh
    ./run_one_testcase.sh $1 $2

  else
    >&2 echo "Invalid arguments"
  fi
  
else
  >&2 echo "Invalid Source Directory"

fi


