#!/bin/bash

# part one:
# 1. split each line on comma
# 2. take each value in the pair and compare then
# 3. if the first value is lesser and the second value is greater
# or vice versa, then there is overlap
# 4. add to the count and move onto the next pair

filename="inputs.txt"
overlaps=0

function find_hyphen() {
    for (( idx = 0; idx < ${#1}; idx++ ))
    do
        if [[ ${1:$idx:1} == "-" ]]
        then
            # echo "found a hyphen in ${1} at index ${idx}"
            hyphen_index=$idx
            break
        fi
    done
}

while read line
do
    IFS=',' read -ra input <<< "$line"
    unset IFS
    first_value=0
    second_value=0
    hyphen_index=0
    count=0
    for input_range in ${input[*]}
    do
        find_hyphen $input_range
        if [[ $count -eq 0 ]]
        then
            first_value=${input_range:0:$hyphen_index}
            second_value=${input_range:$hyphen_index+1}
        elif [[ $count -eq 1 ]]
        then
            # printf "first part: ${first_value}\tsecond part: ${second_value}\n"
            # printf "first part: ${input_range:0:$hyphen_index}\tsecond part: ${input_range:$hyphen_index+1}\n"
            if [[ $first_value -le ${input_range:0:$hyphen_index} && $second_value -ge ${input_range:$hyphen_index+1} ]]
            then
                overlaps=$(( $overlaps + 1 ))
            elif [[ ${input_range:0:$hyphen_index} -le $first_value && ${input_range:$hyphen_index+1} -ge $second_value ]]
            then
                overlaps=$(( $overlaps + 1 ))
            fi
        fi
        count=$(( $count + 1 ))
    done

done < $filename

echo "Found :: ${overlaps} :: overlaps"
