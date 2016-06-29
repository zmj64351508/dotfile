#!/bin/bash

dir=$pwd

if [[ $1 == "make" ]]; then
	exe="make"
	file="Makefile"
else
	exe=$1
	file=$1
fi

while true; do
	cur_dir=$(pwd)
	has_git=$(find . -maxdepth 1 -name $file)
	if [[ $has_git != '' || $cur_dir = '/' ]]; then
		break
	fi
	cd ..
done

if [[ $cur_dir = '/' ]]; then
	echo "Can not find " $file
	exit 0
fi

eval "./$file ${@:2}"

cd $dir
