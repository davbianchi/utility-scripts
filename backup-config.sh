#!/bin/bash

set -euo pipefail

# generate backup folder
cd
TARNAME="backup-$(whoami)-$(date +"%Y-%m-%d")"
FOLDER="$HOME/$TARNAME"
DOTFILES="$FOLDER/dotfiles"

mkdir $FOLDER
mkdir $DOTFILES

# backup standard linux dotfiles
echo -n "Dotfiles backup..."
cd $DOTFILES
cp $HOME/.xinitrc ./
cp $HOME/.bashrc ./
cp $HOME/.bash_aliases ./
cp $HOME/.bash_logout ./
cp $HOME/.bash_profile ./
cd ..
echo "done."

# backup custom data
echo -n "Saving user data..."
mkdir data
cd

for arg in $@; do
    echo $arg
    cp -r $arg $FOLDER/data
done
echo "done."

# backup ssh keys
cd $FOLDER
echo -n "SSH keys backup..."
mkdir ssh-keys
cd ssh-keys
cp -r $HOME/.ssh/ ./
echo "done."
cd

# compress and zip the backup folder
tar -zcf - $FOLDER"/" | openssl enc -e -aes256 -out $TARNAME".tar.gz"
rclone -P copy $TARNAME".tar.gz" mega:
rm -rf $FOLDER

cd
echo "Backup complete. Check your home directory :)"
