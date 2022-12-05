#!/bin/bash

filename="inputs.txt"
maxcalories="0"
total="0"
declare -a individualcount=()

# ~~~ PART ONE ~~~ #
# insert this code into the while loop that reads all the lines
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

# ~~~ PART TWO ~~~ #
# By the time you calculate the answer to the Elves' question,
# they've already realized that the Elf carrying the most Calories
# of food might eventually run out of snacks.
# 
# To avoid this unacceptable situation, the Elves would instead like
# to know the total Calories carried by the top three Elves carrying
# the most Calories. That way, even if one of those Elves runs out of
# snacks, they still have two backups.
# In the example above, the top three Elves are the fourth Elf
# (with 24000 Calories), then the third Elf (with 11000 Calories),
# then the fifth Elf (with 10000 Calories).
# The sum of the Calories carried by these three elves is 45000.
# Find the top three Elves carrying the most Calories.
# How many Calories are those Elves carrying in total?

# working:
# 1. create list of elves and their calories :: DONE
# 2. whilst creating the list if the number of entries exceeds three, pop the
# lowest number :: DONE (differently)
# 3. once we have the list of the top three, sum up the entries
# 4. print out the result

# create file for storing the sorted values
tmpfile=sorted.txt
> $tmpfile

while read line
do
    if [[ $line -eq "" ]]
    then
        total=$(IFS=+; echo "$((${individualcount[*]}))")
        unset IFS
        echo $total >> $tmpfile
        # make sure to clean up the array before starting counting
        # the next elf's calories
        individualcount=()
        continue
    fi
    individualcount+=($line)
done < $filename

# writes the sorted values back to the temporary file
# -n is for numbers, -o outputs to the provided file
sort -n -o $tmpfile $tmpfile

readarray -t sortedcalories < $tmpfile
# using $((val1 + val2)) makes each value be read as a number
maxcalories=$((sortedcalories[-1] + sortedcalories[-2] + sortedcalories[-3]))

echo "Max cals: ${maxcalories}"

# cleanup
rm $tmpfile
