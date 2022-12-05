#!/bin/bash

filename="inputs-example.txt"
maxcalories="0"
total="0"
declare -a individualcount=()
declare -a topthreecount=()

function topcaloriecount() {
    # joins all array elements with a +, getting the sum
    # * expands all array elements
    total=$(IFS=+; echo "$((${individualcount[*]}))")
    if [[ $total -gt $maxcalories ]]
    then
        maxcalories=$total
    fi
    # make sure to clean up the array before starting counting
    # the next elf's calories
    individualcount=()
}

function topthreecaloriecount() {
    echo "put code in here once done :)"
}

while read line
do
    echo $line
    if [[ $line -eq "" ]]
    then
        total=$(IFS=+; echo "$((${individualcount[*]}))")
        echo "length: ${#topthreecount[@]}"
        echo "topthreecount: ${topthreecount}"
        if [[ "${#topthreecount[@]}" -lt 3 ]]
        then
            topthreecount=("${topthreecount[@]} $total")
            continue
        fi
        # make sure to clean up the array before starting counting
        # the next elf's calories
        individualcount=()
        continue
    fi
    individualcount+=($line)
done < $filename

echo "Max cals: ${maxcalories}"
