#/bin/bash

pids=$(ps -A | grep $@ | sed "s/\([^ ][0-9]*\)\(.*\)/\1/")
echo $pids
if [[ $pids != '' ]]; then
	kill -9 $pids
fi
