#!/bin/bash

# part one
# 1. split each line in two, get length/2
# 2. compare each half to see if any characters match
# 3. knowing what each prio is, find the prio for each match

# part two
# 1. get each group of three lines
# 2. check each rucksack for common letters
# 3. find the priority

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
            score=$(( $score + $idx + 1 ))
        fi
    done
}

function get_string_halves() {
    # splits each string in two and gets the two halves
    # 
    # args:
    # $1 :: the string to split in two

    # we can treat the line as an array of chars
    line_len=${#1}
    # parameter expansion:
    #   first value is the 'offset'
    #   second value is the length of the substring
    first_half=${1:0:line_len/2}
    second_half=${1:line_len/2}
}

function part_one() {
    while read line
    do
        match=0
        # 1. split each line
        get_string_halves $line
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
}

# ~~~ PART TWO FUNCTIONS ~~~ #
function compare_strings() {
    # $1 is the first one
    # $2 is the second one
    # $3 is the third one
    for (( idx=0; idx<${#1}; idx++ ))
    do
        # break at each level to get out of the nested loops
        if [[ match -eq 1 ]]
        then
            break
        fi
        for (( jdx=0; jdx<${#2}; jdx++ ))
        do
            if [[ match -eq 1 ]]
            then
                break
            fi
            for (( kdx=0; kdx<${#3}; kdx++ ))
            do
                if [[ ${1:$idx:1} == ${2:$jdx:1} ]] && [[ ${2:$jdx:1} == ${3:$kdx:1} ]]
                then
                    # echo "Found matching letter: ${3:$kdx:1}"
                    find_prio ${3:$kdx:1}
                    match=1
                    break
                fi
            done
        done
    done
}

line_count=0
# easiest to use three strings rather than dealing with an array
first_line=""
second_line=""
third_line=""
while read line
do
    match=0

    line_count=$(( $line_count + 1 ))
    if [[ $line_count -eq 1 ]]
    then
        first_line=$line
    elif [[ $line_count -eq 2 ]]
    then
        second_line=$line
    elif [[ $line_count -eq 3 ]]
    then
        third_line=$line
        compare_strings $first_line $second_line $third_line
        # reset all once we have the three lines
        line_count=0
        first_line=""
        second_line=""
        third_line=""
    fi
done < $filename

echo "Final score: ${score}"
