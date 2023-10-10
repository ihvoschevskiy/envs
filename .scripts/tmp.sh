#!/bin/bash

# widths=(450 1920 2560)
#
# function prepareBPoints() {
#   input=("$@")
#
#   length="${#input[@]}"
#
#   result=()
#   for (( i=1; i < "${length}"; i++ )); do 
#     result+=("${input[i-1]}"/"${input[i]}")
#   done
#
#   result+=("Set sizes")
#   result+=("Quit")
#
#   echo "${result[@]}"
#
# }
#
# arr=( $(prepareBPoints "${widths[@]}") )
#
# echo "${arr[2]}"
#
create_array() {
    local -n arr=$1             # use nameref for indirection
    arr=(one "two three" four)
}

use_array() {
    local my_array
    create_array my_array       # call function to populate the array
    # echo "inside use_array"
    declare -p my_array         # test the array
}

result=( $(use_array) )
echo "${result[@]}"
