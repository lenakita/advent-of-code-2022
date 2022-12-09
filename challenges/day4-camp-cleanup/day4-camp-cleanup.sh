#!/bin/bash

# part one:
# 1. split each line on comma
# 2. take each value in the pair and compare then
# 3. if the first value is lesser and the second value is greater
# or vice versa, then there is overlap
# 4. add to the count and move onto the next pair

# part two:
# same steps as one to get the input, but from step three
# 1. if any values are within the range of one another, there is
# overlap
# 2. add to the count and move on to the next pair

filename="inputs.txt"
overlaps=0

function find_hyphen() {
    # finds a hyphen in a given string
    # 
    # args:
    # $1 :: the string to be parsed
    for (( idx = 0; idx < ${#1}; idx++ ))
    do
        if [[ ${1:$idx:1} == "-" ]]
        then
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
    # read each 'pair' of each line
    for input_range in ${input[*]}
    do
        find_hyphen $input_range
        if [[ $count -eq 0 ]]
        then
            # on the first loop, we get the first two values
            first_value=${input_range:0:$hyphen_index}
            second_value=${input_range:$hyphen_index+1}
        elif [[ $count -eq 1 ]]
        then
            # then on the second loop, we compare the first two values
            # to the second two
            if [[ $first_value -le ${input_range:0:$hyphen_index} && $second_value -ge ${input_range:$hyphen_index+1} ]]
            then
                # if the first pair covers the second pair
                overlaps=$(( $overlaps + 1 ))
            elif [[ ${input_range:0:$hyphen_index} -le $first_value && ${input_range:$hyphen_index+1} -ge $second_value ]]
            then
                # if the second pair covers the first pair
                overlaps=$(( $overlaps + 1 ))
            elif [[ $second_value -ge ${input_range:0:$hyphen_index} && $first_value -le ${input_range:$hyphen_index+1} ]]
            then
                # PART TWO: added this condition
                overlaps=$(( $overlaps + 1 ))
            fi
        fi
        count=$(( $count + 1 ))
    done
done < $filename

echo "Found :: ${overlaps} :: overlaps"
