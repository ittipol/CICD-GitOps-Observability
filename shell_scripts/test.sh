#!/bin/bash
# set -e tells the shell to exit the script if any command returns a non-zero exit status
# -e  Exit immediately if a command exits with a non-zero status
# set -ex

# $? The exit status of the last command executed
# $0 The filename of the current script
# $# The number of arguments supplied to a script
# $$ The process number of the current shell. For shell scripts, this is the process ID under which they are executing.

# If Statement
if [ "$status" = "success" ]; then
    echo "value equal"
    exit 1
elif [ -n "$error" ]; then
    echo "the length of STRING is nonzero"
    exit 0
else
    echo "message"
    exit 1
fi

# Check variable is true
if [ "$start" = true ]; then
    print "true"
fi

if [ ! -z "$option" ]; then
    echo "Invalid option" >&2
    exit 1
fi

string="matched-string"
# Check if the string matches the pattern "matched-*"
if [[ $string =~ "matched-*" ]] then
   exit 0
fi

# if option
# -e file
#    true if file exists. 
# -d file
#    operator to test if the given directory exists or not
# -n STRING
#    the length of STRING is nonzero
# -z STRING
#    the length of STRING is zero

# if [ -e /path/to/file ] ; then
#     echo "exist";
# fi

# if [ -d /path/to/directory ] ; then
#     echo "exist";
# fi

# The command [ -t 1 ] is executed. If it exits with status 0 (indicating success, which for the [ command means the condition evaluates to true) then the commands in the body of the if statement are executed
# return code of 0 ("success")
# if [ -t 1 ]; then 
#     exec zsh
# fi
# ---
# It may be a bit surprising that [ is a command, rather than part of shell syntax, but that's the case. Your if could be rewritten equivalently to use the test command instead
# if test -t 1; then
#     exec zsh
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

# >&2
# > redirect standard output
# & what comes next is a file descriptor, not a file (only for right hand side of >)
# 2 stderr file descriptor number
# Redirect stdout from echo command to stderr. (If you were to use echo "hey" >2 you would output hey to a file called 2)
# File descriptor 1 is stdout and File descriptor 2 is stderr

# -eq: Check if the two numbers are equal
# -ne: Check if the two numbers are not equal
# -lt: Check if the first number is less than the second number
# -le: Check if the first number is less than or equal to the second number
# -gt: Check if the first number is greater than the second number
# -ge: Check if the first number is greater than or equal to the second number