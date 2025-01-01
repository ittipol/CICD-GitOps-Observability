install() {
    cd ../kubernetes/argocd/terraform

    terraform init
    terraform apply
}

while getopts "i" opt; do
  case $opt in
    i | --install) install exit 1 ;;
    *) echo "Invalid option" exit 1 ;;
  esac
done