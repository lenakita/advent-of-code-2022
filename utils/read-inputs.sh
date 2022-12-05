#!/bin/bash

function readfile() {
    while read line
    do
        if [[ $line = "" ]]
        then
            continue
        fi
        echo $line
    done < $1
}
