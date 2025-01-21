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

copy_folder() {
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