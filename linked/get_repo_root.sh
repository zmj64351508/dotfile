#!/bin/bash

while true; do
	cur_dir=$(pwd)
	has_git=$(find . -maxdepth 1 -name ".git")
	if [[ $has_git != '' || $cur_dir = '/' ]]; then
		break
	fi
	cd ..
done

if [[ $cur_dir = '/' ]]; then
	echo .
else
	pwd
fi



