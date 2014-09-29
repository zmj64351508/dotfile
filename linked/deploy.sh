#! /bin/bash
if [ $# -lt 2 ]; then
    echo "usage: deploy [mount point] [src] <dst in mount point>"
    exit
fi
if [ ! -x "$1" ]; then
    echo "wait for mount point $1 to be ready"
fi
while [ ! -x "$1" ] 
do
    sleep 1
done

sudo cp -rf "$2" "${1}/${3}"
if [ $? = 0 ]; then
    sync
    umount "$1"
fi
