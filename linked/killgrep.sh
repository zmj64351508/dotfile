#/bin/bash

ps -A | grep $@ | sed "s/\([^ ][0-9]*\)\(.*\)/\1/" | xargs kill -9
