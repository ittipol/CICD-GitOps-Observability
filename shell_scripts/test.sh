# if [ "$#" -eq 0 ]; then
#     echo "Usage: $0 <username> <age> <fullname>"
#     exit 1
# fi

# if [ $var -eq 12 ]; then 
#     echo "This is a numeric comparison if example"
# fi

# if [ "$var" = "12" ]; then
#     echo "This is a string if comparison example"
# fi

# if [[ "$var" = *12* ]]; then
#     echo "This is a string regular expression if comparison example"
# fi

# if [ "$1" = "docker" ]; then

#     if [ "$#" -eq 1 ]; then
#         echo "docker-compose up -d --build"
#         exit 1
#     fi
    
#     if [ "$2" = "start" ]; then
#         echo "docker-compose up -d --build"
#         exit 1
#     fi

#     if [ "$2" = "stop" ]; then
#         echo "docker-compose stop"
#         exit 1
#     fi
    
#     exit 1
# fi

# if [ "$1" = "minikube" ]; then

#     if [ "$#" -eq 1 ]; then
#         echo "minikube start"
#         exit 1
#     fi
    
#     if [ "$2" = "start" ]; then
#         echo "minikube start"
#         exit 1
#     fi

#     if [ "$2" = "stop" ]; then
#         minikube stop
#     fi

#     exit 1
# fi

arg0=$(basename "$0" .sh)
blnk=$(echo "$arg0" | sed 's/./ /g')

docker_flag=''
minikube_flag=''
files=''
verbose='false'

while getopts 'd:m:f:v' flag; do
  case "${flag}" in
    d | --docker) docker_flag="${OPTARG}" ;;
    m | --minikube) minikube_flag="${OPTARG}" ;;
    f) files="${OPTARG}" ;;
    v) verbose='true' ;;
    *) echo "Invalid option" 
        exit 1 ;;
  esac
done

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