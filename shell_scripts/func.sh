create_folder() {
    path=
    chars='abcdefghijklmnopqrstuvwxyz0123456789'
    n=20

    for ((i = 0; i < n; ++i)); do
        path+=${chars:RANDOM%${#chars}:1}
    done

    # create a folder with temp folder to extract the certificates into
    timestamp=$(date "+%Y%m%d_%H%M%S")
    folder_name="${TMPDIR:-/tmp}/$path_$timestamp"
    mkdir -p "$folder_name"
    cd "$folder_name"
}

delete_folder() {
    local folder_name="$1"
    rm -rf "$folder_name"
}

copy_all() {
    local source="$1"
    local dest="$2"
    cp -a "${source}/." "${dest}"
    # cp -a ./code/. ./owasp-dependency-check
}

copy() {
    local source="$1"
    local dest="$2"
    cp -r "$source" "$dest"
    # cp -r ./source_dir/ /path/to/destination
}

check_installed_binary() {
    # local binary_file="$1"
    binary_file='openssl'
    which $binary_file > /dev/null 2>&1 || { echo "$binary_file is not installed"; exit 1; }
}

trivy_image_scan() {    
    timestamp=$(date "+%Y%m%d_%H%M%S")
    file_name="scan_${timestamp}.txt"
    # trivy image --severity HIGH,CRITICAL {your-container-image} > $file_name
    # trivy image --severity HIGH,CRITICAL {your-container-image} | tee -a $file_name
}

extract_tar() {
    local dir="$1"
    local tar_file="$2"
    mkdir -p "${dir}" && tar zxvf "${tar_file}" -C "${dir}"
    # mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-8.0.405-osx-arm64.tar.gz -C $HOME/dotnet
}

unzip() {
    local zip_file="$2"
    unzip $zip_file
    # unzip dependency-check-9.0.10-release.zip
}

basic_auth() {
    local user="$1"
    local password="$2"
    echo -n "$user:$password" | base64
}

map_dns_with_ip() {
    # add minikube ip to /etc/hosts
    echo "`minikube ip` docker.local" | sudo tee -a /etc/hosts > /dev/null
}

run_ifconfig() {
    ifconfig
}

allow_port_80() {
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT
}

save_firewall_rule() {
    iptables-save > /etc/iptables/rules.v4
}

add_env_path() {
    PATH="/path/to/bin:${PATH}"
}

symbolic_link() {
    sudo ln -s /usr/bin/python3 /usr/bin/python
}

check_command_exist() {

    # Use with if statement
    # if check_command_exist "ssh"; then
    #     commandExist=true
    # elif check_command_exist "cat"; then
    #     commandExist=true
    # fi

    # Run command with args suppressing the normal shell function lookup. Only builtin commands or commands found in the PATH are executed
    # -v option is supplied, the exit status is 0 if command was found, and  1  if  not
    command -v "$1" > /dev/null 2>&1

    # $?-The exit status of the last command executed
    return $?
}

to_lowercase() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
    return 0
}

find_home() {

    # how to use
    # home=$(find_home)

    local script=$0
    [ -h "$script" ] && script="$(readlink "$script")"
    echo "$(cd -P "$(dirname "$script")" && pwd)"
}

remove_trailing_slash() {
    local input="$1"
    echo "${input%/}"
    return 0
}

test_url() {
    local $url="$1"

    curl "$url" -s -o /dev/null -w "%{http_code}\n"

    # curl --header "Authorization: Bearer $token" "$url" -s -o /dev/null -w "%{http_code}\n"
}

request_url() {
    local $url="$1"

    max_retries=3
    retry_count=0

    while [ $retry_count -lt $max_retries ]; do
    curl -m 10 $url

    if [ $? -eq 0 ]; then
        echo "Request was successful"
        break
    else
        echo "Request failed with exit code $?. Retrying..."
        retry_count=$((retry_count + 1))
        sleep 3
    fi
    done

    if [ $retry_count -eq $max_retries ]; then
        echo "Request failed after $max_retries retries. Exiting."
    fi
}

remove_beginning_slash() {
    local input="$1"
    echo "${input#/}"
    return 0
}