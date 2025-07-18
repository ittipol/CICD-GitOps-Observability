#!/bin/bash
set -e

which colima > /dev/null 2>&1 || { echo "colima is not installed"; exit 1; }

start() {
  colima start --cpu 7 --memory 20 --disk 200
}

if [ "$1" = "start" ]; then

    # -arch        architecture (aarch64, x86_64) (default "aarch64")
    # --vm-type    virtual machine type (qemu, vz) (default "vz")
    # --vz-rosetta enable Rosetta for amd64 emulation
    # --cpu        number of CPUs (default 2)
    # --memory     memory in GiB (default 2)

    start

    # To start Qemu mode
    # colima start --cpu 4 --memory 12 --arch aarch64 --vm-type qemu

    # To start VZ mode
    # colima start --cpu 4 --memory 12 --arch aarch64 --vm-type=vz --vz-rosetta
elif [ "$1" = "stop" ]; then
    colima stop
elif [ "$1" = "restart" ]; then
    colima stop
    start
elif [ "$1" = "delete" ]; then
    colima delete
elif [ "$1" = "help" ]; then
    colima help start
else
    echo "Invalid option" >&2; exit 1;
fi