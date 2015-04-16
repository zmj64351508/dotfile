#!/bin/bash

script=$0

usage()
{
	echo "usage: $script [-a] language1 language2 ..."
	echo "  -a	append to gtags.files, otherwise create a new"
	echo "  language can be c,s,cpp"
}

append=false
param_count=0
declare -a languages

opts=$(getopt -q "ah" "$@")
while [ -n "$1" ]; do
	case "$1" in
		-a)
			append=true
			;;
		-h)
			usage
			exit 0
			;;
		--)
			;;
		*)
			languages[param_count]=$1
			param_count+=1
			;;
	esac
	shift
done

for lan in ${languages[@]}; do
	case $lan in
		"c")
			if [[ $file != '' ]]; then
				file+=' -o '
			fi
			file+=' -name "*.[hc]" '
			;;
		"cpp")
			if [[ $file != '' ]]; then
				file+=' -o '
			fi
			file+=' -name "*.[hc]pp" -o -name "*.cc" '
			;;
		"s")
			if [[ $file != '' ]]; then
				file+=' -o '
			fi
			file+=' -name "*.[sS]" '
			;;
		*)
			usage
			exit 1
			;;
	esac
done

if [[ $append = true ]]; then
	echo $file | xargs find  >> gtags.files
else
	echo $file | xargs find  > gtags.files
fi

gtags

