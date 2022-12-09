#!/bin/bash
# part one
# 1. split each line in two, get length/2
# 2. compare each half to see if any characters match
# 3. knowing what each prio is, find the prio for each match

filename="inputs.txt"
prio="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
score=0

function find_prio() {
    # finds the priority of a given letter based on its position
    # in the alphabet
    # 
    # args:
    # $1 :: the letter to find the priority of
    for (( idx=0; idx<${#prio}; idx++ ))
    do
        if [[ $1 == ${prio:$idx:1} ]]
        then
            letter_prio=$(( $idx + 1 ))
            echo "Found prio for ${1} at index ${letter_prio}"
            score=$(( $score + $idx + 1 ))
        fi
    done
}

while read line
do
    match=0
    # 1. split each line
    # we can treat the line as an array of chars
    line_len=${#line}
    # parameter expansion:
    #   first value is the 'offset'
    #   second value is the length of the substring
    first_half=${line:0:line_len/2}
    second_half=${line:line_len/2}
    printf "First half: ${first_half}\t"
    printf "Second half: ${second_half}\n"
    # 2. compare each half
    for (( idx=0; idx<${#first_half}; idx++ ))
    do
        if [[ match -eq 1 ]]
        then
            break
        fi

        for (( jdx=0; jdx<=${#second_half}; jdx++ ))
        do
            if [[ ${second_half:$jdx:1} == ${first_half:$idx:1} ]]
            then
                echo "Found matching character: ${second_half:$jdx:1}"
                # 3. find the priority of the matching letter
                find_prio ${second_half:$jdx:1}
                match=1
                break
            fi
        done
    done

done < $filename

echo "Total prio is: ${score}"
