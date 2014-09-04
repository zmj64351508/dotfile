#!/bin/bash 

MAKE=/usr/bin/make

pathpat="(.*[^/]*)+:[0-9]+"
ccred=$(echo -e "\033[0;31m")
ccyellow=$(echo -e "\033[0;33m")
ccend=$(echo -e "\033[0m")
$MAKE "$@" 2>&1 | sed -E -e "
    /[Ee]rror[: ]/ s%$pathpat%$ccred&$ccend%g
    /[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g
"

