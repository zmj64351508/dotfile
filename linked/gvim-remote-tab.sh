#!/bin/bash

#declare -a server_list
#unset server_list
server_base_name=$(gvim --serverlist | sed -r -n -e "1s/(^[^0-9]+)([0-9]*)/\1/p")
#server_num=${#server_list[@]}


echo "Avalible servers:"
# show avalible servers
#gvim --serverlist | sed '$a\New gvim' | sed "=" | sed -r -e "N;s/([^\n]+)\n(^)/\1: \2/" 
#gvim --serverlist | sort | sed '$a\n: New gvim' | awk '$0=""NR-1": "$0'
gvim --serverlist | sort | sed -e "s/^.*[^0-9]$/0: \0/" -e '$a\n: New gvim' | sed -r -e "s/^.*([0-9]+)$/\1: \0/"

new_server=false
# validate input
while true; do
	echo -n "Choose: "
	read chosen
	#new_server_index=`expr $server_num + 1`
	if [ $chosen = 'n' ]; then
		new_server=true
		break;
	elif [[ $chosen -lt 0 ]]; then
		echo "Invalid server number"
	else
		server_index=$chosen
		if [ $server_index = '0' ]; then
			server_index=''
		fi
		break
	fi
done

# new gvim server
if [[ $new_server = true ]]; then
	gvim $@
else
	# attach to server
	server=${server_base_name}${server_index}
	gvim --servername $server --remote-tab-silent $@
fi

