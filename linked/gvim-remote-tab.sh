#!/bin/bash

declare -a server_list
unset server_list
server_list=($(gvim --serverlist))
server_num=${#server_list[@]}

#if [[ $server_num -eq 1 ]]; then
#	echo "yes"
#	gvim --remote-tab-silent $@
#else
	echo "Avalible servers:"
	# show avalible servers
	#gvim --serverlist | sed '$a\New gvim' | sed "=" | sed -r -e "N;s/([^\n]+)\n(^)/\1: \2/" 
	gvim --serverlist | sed '$a\New gvim' | awk '$0=""NR-1": "$0'

	# validate input
	while true; do
		echo -n "Choose: "
		read chosen
		#new_server_index=`expr $server_num + 1`
		if [[ $chosen -lt 0 || $chosen -gt $server_num ]]; then
			echo "Invalid server number"
		else
			break
		fi
	done

	# new gvim server
	if [[ $chosen -eq $server_num ]]; then
		gvim $@
	else
	# attach to server
		server=${server_list[chosen]}
		gvim --servername $server --remote-tab-silent $@
	fi
#fi


#echo $server_num
