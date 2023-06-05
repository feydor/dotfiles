#!/bin/sh
# dotfiles-install.sh
# Setup my dotfiles on this system

REPO=''
git clone --bare $REPO $HOME/.dotfiles

# input: a git sub-command
function config {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME &@
}

mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
    echo "Checked out dotfiles.";
else
    echo "Backing up pre-existing dotfiles."
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;

config checkout
config config status.showUntrackedFiles no

