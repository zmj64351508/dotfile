# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# swap esc and caps lock
#xmodmap /home/magee/cap2esc

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set cross-tool path
PATH="$PATH:/opt/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin:/opt/p4v-2008.2.193639/bin"
PATH="$PATH:/home/magee/Work/tools/bootimg"

# setup perfoce command-line tool
export P4PASSWD=shglx
export P4CLIENT=magee
export P4USER=SH_GL_LINUX
export P4PORT=10.28.251.101:2666

