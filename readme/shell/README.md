# Shell

### Print environment variable
``` bash
env

printenv
```

### User
``` bash
echo $USER
```

### List shell
``` bash
cat /etc/shells
```

### Echo
``` bash
echo Hello

echo "Hello World"

echo $message

echo "$message"

# ===============================================================
echo "$(function_name_here)"

echo $(pwd)

echo "$(pwd)/path/to"

echo $(kubectl get node minikube -o jsonpath='{.status.capacity}')
```

## Bash (Bourne Again Shell) 

### Bash Script
- #!/bin/bash is called Shebang
``` bash
#!/bin/bash

path="$1"

if [ -z "$path" ]; then
  echo "path is empty."
  exit 1
else
  echo "path is not empty."
fi
```

### Executable
``` bash
chmod +x script.sh

./script.sh
```