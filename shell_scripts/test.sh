#!/bin/bash
# set -e tells the shell to exit the script if any command returns a non-zero exit status
# -e  Exit immediately if a command exits with a non-zero status

# If Statement
# if [[ "$certificate_details" == *"string"* ]]; then
#     echo "message"
#     exit 1
# elif [[ "$certificate_details" == *""* ]]; then
#     echo "message"
#     exit 0
# else
#     echo "message"
#     exit 1
# fi

# Just like any other simple command, [ ... ] or test requires spaces between its arguments.
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
fi

if test "$#" -ne 1; then
    echo "Illegal number of parameters"
fi

# When in Bash, prefer using [[ ]] instead as it doesn't do word splitting and pathname expansion to its variables that quoting may not be necessary unless it's part of an expression.
if [[ $# -ne 2 ]]; then
    echo "Illegal number of parameters" >&2
    exit 2
fi

# Loop parameters
while test $# -gt 0
do
    case "$1" in
    flutter)
        echo "matched with flutter";
        shift # to move $1 to the next argument
        ;;
    nginx)
        echo "matched with nginx";
        shift # to move $1 to the next argument
        ;;
    *)
        echo "Invalid option" >&2
        shift # to move $1 to the next argument
        ;;
    esac
done