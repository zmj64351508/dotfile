#!/bin/bash
if [ $# -lt 2 ]; then
	echo "usage $0 repo commit"
	exit -1
fi

repo=$1
commit=$2

git --git-dir=$repo/.git \
format-patch -k -1 --stdout $commit | 
git am -3 -k
