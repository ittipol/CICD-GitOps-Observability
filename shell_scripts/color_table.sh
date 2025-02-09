#!/bin/bash
color(){
    for c; do
        printf '\e[48;5;%dm%03d' $c $c
    done
    printf '\e[0m \n'
}

IFS=$' \t\n'

# Print color table
color {0..15}

# Print color table
for ((i=0;i<6;i++)); do
    color $(seq $((i*36+16)) $((i*36+51)))
done

# Print color table
color {232..255}

printf '\e[%sm ' {40..47} 0; echo