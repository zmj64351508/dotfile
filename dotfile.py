#! /usr/bin/python
import os
import sys, getopt

################# Configurations #########################
backup_files = (
    {"source": "~/.profile", "backup": "profile"},
    {"source": "~/.bashrc",  "backup": "bashrc"},
    {"source": "~/.vimrc",   "backup": "vimrc"},
    {"source": "/usr/share/vim/vim74/syntax/c.vim",     "backup": "c.vim"},
)

linked_files = (
    {"target": "~/bin/make", "backup": "colormake.sh"}, # color make
)

backup_dir = os.path.expanduser("~/backup")
linked_dir = backup_dir + "/" + "linked"
cp = "cp -rf "
ln = "ln -s "
mv = "mv "

################# Script start ###########################
def run_cmd(cmd):
    print cmd
    os.system(cmd)

def update_backup():
    if not os.path.isdir(backup_dir):
        print "Create %s" %(backup_dir)
        os.makedirs(backup_dir)

    print "Start Update..."
    for files in backup_files:
        cmd = cp + files["source"] + " " + backup_dir + "/" + files["backup"]
        run_cmd(cmd)

def restore():
    print "Backup original files.."
    for files in backup_files:
        source_path = os.path.expanduser(files["source"])
        # backup current file first
        if os.path.exists(source_path):
            run_cmd(cp + source_path + " " + source_path + ".dotbak")

    print "Start Restore.."
    for files in backup_files:
        source_path = os.path.expanduser(files["source"])
        # do restore
        if(os.path.exists(backup_dir + "/" + files["backup"])):
            run_cmd(cp + backup_dir + "/" + files["backup"] + " " + source_path)

def link():
    print "Start linking.."
    for files in linked_files:
        target_path = os.path.expanduser(files["target"])
        if os.path.exists(target_path) or os.path.islink(target_path):
            run_cmd(mv + target_path + " " + target_path + ".dotbak")
        # automaticly make dirs is not exsisted
        target_parent = os.path.dirname(target_path)
        if not os.path.isdir(target_parent):
            os.makedirs(target_parent)
        run_cmd(ln + linked_dir + "/" + files["backup"] + " " + target_path)
        
def print_usage():
    print "usage:"

def print_sub_cmds():
    print "sub commands: "
    print "    u, update  -- update backup dir according to backup_files"
    print "    r, restore -- restore backup dir to system"
    print "    l, link    -- link files according to linked_files to system"

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print_sub_cmds()
        sys.exit()

    sub_cmd = sys.argv[1];
    opts, args = getopt.getopt(sys.argv[2:], "h", ["help"])
    do_update = False
    do_restore = False
    do_link = False
    for cmd in sub_cmd:
        if sub_cmd in ("u", "update"):
            do_update = True
        elif sub_cmd in ("r", "restore"):
            do_restore = True
            do_link = True
        elif sub_cmd in ("l", "link"):
            do_link = True

    for op, value in opts:
        if op in ("-h", "--help"):
            print_usage()
            sys.exit()

    if do_update:
        update_backup()

    if do_restore:
        restore()

    if do_link:
        link()

