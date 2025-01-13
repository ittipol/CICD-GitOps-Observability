createFolder() {
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

deleteFolder() {
    rm -rf "$folder_name"
}

checkInstalledBinary() {
    $binary_file='openssl'
    which $binary_file > /dev/null 2>&1 || { echo "$binary_file is not installed"; exit 1; }
}