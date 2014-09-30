#! /usr/bin/python
import os
import sys, getopt

################# Configurations #########################
backup_dir = os.path.expanduser("~/backup")
linked_dir = backup_dir + "/" + "linked"
cp = "cp -f "
ln = "ln -s "
mv = "mv "
quiet = False
################# Script start ###########################
def run_cmd(cmd):
    if not quiet:
        print cmd
    os.system(cmd)

def print_common_opt_usage():
    print "    -h --help  -- display help"
    print "    -q --quiet -- do not display command message"

def print_sub_cmds():
    print "sub commands: "
    print "    u, update  -- update backup dir according to backupfiles"
    print "    r, restore -- restore backup dir to system"
    print "    l, link    -- link files according to linkedfiles to system"

def print_update_usage():
    print "usage: update -hq [files...]"
    print "If no file specified, it will update all the files in backupfiles and linkedfiles"
    print_common_opt_usage()

def print_restore_usage():
    print "usage: restore -hq [files...]"
    print "If no file specified, it will restore all the files in backupfiles and linkedfiles"
    print_common_opt_usage()

def print_link_usage():
    print "usage: link -hq [files...]"
    print "If no file specified, it will link all the files in linkedfiles"
    print_common_opt_usage()

class BackupFile(object):
    def __init__(self, source, backup):
        self.source = source
        if backup:
            self.backup = backup
        else:
            self.backup = self.make_backup(self.source)

    def make_backup(self, source):
        backup = os.path.basename(source);
        return backup

class BackupFiles(object):
    def __init__(self, db_dir):
        self.db_dir = db_dir
        self.db = open(self.db_dir, 'rw')
        self.all_files = self.__get_all_files()

    # return the list of all the backup files
    def __get_all_files(self):
        sources_list = []
        line = self.db.readlines()
        line_num = 0
        for curline in line:
            line_num += 1
            comment_split = curline.split("#", 1)
            nocomment = comment_split[0].strip()
            if not nocomment:
                continue
            nocomment_split = nocomment.split()
            source = nocomment_split[0].strip()
            if len(nocomment_split) == 2:
                backup = nocomment_split[1].strip()
            elif len(nocomment_split) > 2:
                print "Error: ignore " + self.db_dir + ":%d" % line_num
                continue
            else:
                backup = None
            if source:
                sources_list.append(BackupFile(source, backup))
            
        return sources_list
    
    def do_backup(self, backupfile):
        source_path = os.path.expanduser(backupfile.source)
        cmd = cp + source_path + " " + backup_dir + "/" + backupfile.backup
        run_cmd(cmd)

    def do_restore(self, backupfile):
        # backup current file first
        source_path = os.path.expanduser(backupfile.source)
        if os.path.exists(source_path):
            run_cmd(cp + source_path + " " + source_path + ".dotbak")

        # do restore
        if(os.path.exists(backup_dir + "/" + backupfile.backup)):
            run_cmd(cp + backup_dir + "/" + backupfile.backup + " " + source_path)
        else:
            print "Can't find backup for " + backupfile.source

    def do_all_restore(self):
        for backupfile in self.all_files:
            self.do_restore(backupfile)

    def do_all_backup(self):
        for backupfile in self.all_files:
            self.do_backup(backupfile)

    def get_backupfile(self, name):
        for backupfile in self.all_files:
            if os.path.expanduser(backupfile.source) == os.path.expanduser(name):
                return backupfile
        return None

class LinkedFiles(BackupFiles):

    def do_backup(self, backup_file):
        pass

    def do_restore(self, backupfile):
        source_path = os.path.expanduser(backupfile.source)
        if os.path.exists(source_path) or os.path.islink(source_path):
            run_cmd(mv + source_path + " " + source_path + ".dotbak")
        # automaticly make dirs is not exsisted
        source_parent = os.path.dirname(source_path)
        if not os.path.isdir(source_parent):
            os.makedirs(source_parent)
        run_cmd(ln + linked_dir + "/" + backupfile.backup + " " + source_path)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print_sub_cmds()
        sys.exit()

    sub_cmd = sys.argv[1];
    opts, args = getopt.getopt(sys.argv[2:], "hqr", ["help", "quiet", "recursive"])
    do_update = False
    do_restore = False
    do_link = False
    recursive = False
    for cmd in sub_cmd:
        if sub_cmd in ("u", "update"):
            do_update = True
        elif sub_cmd in ("r", "restore"):
            do_restore = True
        elif sub_cmd in ("l", "link"):
            do_link = True
        else:
            print_sub_cmds()
            sys.exit()
            

    for op, value in opts:
        if op in ("-h", "--help"):
            if do_update:
                print_update_usage()
            elif do_restore:
                print_restore_usage()
            elif do_link:
                print_link_usage()
            sys.exit()
        if op in ("-q", "--quiet"):
            quiet = True;
        if op in ("-r", "--recursive"):
            cp = cp + "-r "

    backupfiles = BackupFiles(backup_dir + "/" + "backupfiles")
    linkedfiles = LinkedFiles(backup_dir + "/" + "linkedfiles")

    files = []
    files_count = 0
    if len(args) != 0:
        files = args
        files_count = len(args)

    backup_list = []
    linked_list = []
    if files_count > 0:
        for candidate in files:
            backupfile = backupfiles.get_backupfile(candidate)
            if not backupfile:
                linkedfile = linkedfiles.get_backupfile(candidate)

            if backupfile:
                backup_list.append(backupfile)
            elif linkedfile:
                linked_list.append(linkedfile)
            else:
                print "Warning: file \"" + candidate + "\" is not in backupfiles or linkedfiles, ignoring it"

        for candidate in backup_list:
            if do_update:
                backupfiles.do_backup(candidate)
            elif do_restore:
                backupfiles.do_restore(candidate)
        
        for candidate in linked_list:
            if do_restore or do_link:
                linkedfiles.do_restore(candidate)

    else:
        if do_update:
            backupfiles.do_all_backup()

        elif do_restore:
            backupfiles.do_all_restore()
            linkedfiles.do_all_restore()

        elif do_link:
            linkedfiles.do_all_restore()

