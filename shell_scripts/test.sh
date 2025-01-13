#!/bin/bash
# set -e tells the shell to exit the script if any command returns a non-zero exit status

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

# docker_flag=''
# minikube_flag=''
# files=''
# verbose='false'

# while getopts 'd:m:f:v' flag; do
#   case "${flag}" in
#     d | --docker) docker_flag="${OPTARG}" ;;
#     m | --minikube) minikube_flag="${OPTARG}" ;;
#     f) files="${OPTARG}" ;;
#     v) verbose='true' ;;
#     *) echo "Invalid option" 
#         exit 1 ;;
#   esac
# done

# while getopts "r:" opt; do
#   case $opt in
#     r | --run)
#       echo "-r was triggered, Parameter: $OPTARG"
#       if [ "$OPTARG" = "docker" ]; then
#           echo ""
#       fi
#       exit 1
#       ;;
#     \?)
#       echo "Invalid option: -$OPTARG"
#       exit 1
#       ;;
#     :)
#       echo "Option -$OPTARG requires an argument."
#       if [ "$OPTARG" = "a" ]; then
#           echo "This is a string if comparison example"
#       fi
#       exit 1
#       ;;
#     *) print_usage
#        exit 1 ;;
      
#   esac
# done

# while getopts "d:m:" opt; do
#   case $opt in
#     d | --docker)
#       echo "docker-compose up -d --build"
#       # exit 1
#       ;;
#     m | --minikube)
#       # echo "minikube start"
#       sh minikube_start.sh
#       # minikube start
#       # minikube status
#       # minikube ip
#       # exit 1
#       ;;
    # \?)
    #   echo "Invalid option: -$OPTARG" >&2
    #   exit 1
    #   ;;
    # :)
    #   echo "Option -$OPTARG requires an argument." >&2
    #   if [ "$OPTARG" = "a" ]; then
    #       echo "This is a string if comparison example"
    #   fi
    #   exit 1
#       ;;
#   esac
# done