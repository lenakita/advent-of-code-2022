#!/bin/bash

# ~~~ PART ONE ~~~ #
# rock paper scissors
# 1. get input of whether it's rps
# 2. compare input to opponent's input
# 3. determine winner
# 4. tot up points for round
# 5. tot up points for all rounds

# ~~~ PART TWO ~~~ #
# 1. get input for player
# 2. add to score based on lose, draw or win
# 3. get opponent input
# 4. calculate player input based on l/d/w and opponent input
# 5. use that to calculate the score for picking one of r/p/s

filename="inputs.txt"
player_input=""
opponent_input=""
score=0

# ~~~ PART ONE FUNCTIONS ~~~ #
function compare_inputs() {
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

function get_input() {
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

function get_input_score() {
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

# ~~~ PART TWO FUNCTIONS ~~~ #
function calculate_input_lose() {
    # $1 is the opponent's input
    if [ $1 == "rock" ]
    then
        score=$((score + 3))
    elif [ $1 == "paper" ]
    then
        score=$((score + 1))
    elif [ $1 == "scissors" ]
    then
        score=$((score + 2))
    fi
}

function calculate_input_win() {
    # $1 is the opponent's input
    if [ $1 == "rock" ]
    then
        score=$((score + 2))
    elif [ $1 == "paper" ]
    then
        score=$((score + 3))
    elif [ $1 == "scissors" ]
    then
        score=$((score + 1))
    fi
}

function get_winning_status() {
    # $1 is the opponent's input
    if [ ${splitline[1]} == "X" ]
    then
        # lose
        calculate_input_lose $1
        score=$((score + 0))
    elif [ ${splitline[1]} == "Y" ]
    then
        # draw
        get_input_score $1
        score=$((score + 3))
    elif [ ${splitline[1]} == "Z" ]
    then
        # win
        calculate_input_win $1
        score=$((score + 6))
    fi
}


while read line
do
    splitline=($line)
    # firstly, get inputs
    # wrapped to capture the `echo`
    # player_input=$(get_input "player")
    opponent_input=$(get_input "opponent")
    # then the score for picking one of
    # rock, paper or scissors
    get_winning_status $opponent_input
    # then the score for winning or losing
    # compare_inputs $player_input $opponent_input
done < $filename

echo "Score: ${score}"
