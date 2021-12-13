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




exit 0

# This is how to do a comment

# This is how to make a function
# print(){
#   echo "Inside print function! $1 $2"

#   if [[ $x == 6 ]]; then
#     read -p "Enter name: " name
#     echo "Hello $name"
#   else
#     echo "Not Present"
#   fi
# }

# Uses -eq, -gt conditionals
# if [[ num1 -gt num2 ]]; then
#   echo " $num1 greater than $num2"
# else
#   echo "$num1 less than $num2"
# fi


# File conditions
# File="Brad"
# if [[ -f $File ]]; then
#   echo "$File is present"
# fi


# For loop to rename files
# cd Brad
# echo $PWD

# Files=$(ls *.txt)
# new="New"

# for file in $Files; do
#   echo "Renaming $file"
#   mv $file $file.pdf
# done

# For loop through array of names
# names="Kevin Jimothy Michael Oscar" 
# for name in $names; do
#   echo "Hello $name"cd 

# done