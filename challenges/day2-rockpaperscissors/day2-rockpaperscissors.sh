#!/bin/bash

# ~~~ PART ONE ~~~ #
# rock paper scissors
# 1. get input of whether it's rps
# 2. compare input to opponent's input
# 3. determine winner
# 4. tot up points for round
# 5. tot up points for all rounds

filename="inputs.txt"
playerinput=""
opponentinput=""
score=0

function compareinputs() {
    # $1 is player
    # $2 is opponent
    if [ $1 == $2 ]
    then
        score=$((score + 3))
    elif [[ $1 == "paper" && $2 == "rock" ]]
    then
        score=$((score + 6))
    elif [[ $1 == "scissors" && $2 == "paper" ]]
    then
        score=$((score + 6))
    elif [[ $1 == "rock" && $2 == "scissors" ]]
    then
        score=$((score + 6))
    fi
}

function getinput() {
    local inputarr=()
    local index=0
    local input=""

    # allows us to easily change what the
    # players and opponents inputs are read as
    if [ $1 == "player" ]
    then
        inputarr=("X" "Y" "Z")
        index=1
    elif [ $1 == "opponent" ]
    then
        inputarr=("A" "B" "C")
        index=0
    fi

    if [ ${splitline[$index]} == ${inputarr[0]} ]
    then
        input="rock"
    elif [ ${splitline[$index]} == ${inputarr[1]} ]
    then
        input="paper"
    elif [ ${splitline[$index]} == ${inputarr[2]} ]
    then
        input="scissors"
    fi
    # then return the input
    echo $input
}

function getinputscore() {
    # required to add the extra score for the
    # input picked
    if [ $1 == "rock" ]
    then
        score=$((score + 1))
    elif [ $1 == "paper" ]
    then
        score=$((score + 2))
    elif [ $1 == "scissors" ]
    then
        score=$((score + 3))
    fi
}

while read line
do
    splitline=($line)
    # firstly, get inputs
    # wrapped to capture the `echo`
    playerinput=$(getinput "player")
    opponentinput=$(getinput "opponent")
    # then the score for picking one of
    # rock, paper or scissors
    getinputscore $playerinput
    # then the score for winning or losing
    compareinputs $playerinput $opponentinput
done < $filename

echo "Score: ${score}"
