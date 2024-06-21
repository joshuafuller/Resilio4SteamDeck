#!/bin/bash

# Author: dazewell (copied and modified from the work of Tritschla)
# 2024-06

# This script does the following:
# 1. It is backing up the previous installation (`~/rslsync`) to the `~/rslsync_bak`.
# 2. It is downloading the Resilio application
# 3. Restarting Resilio Sync service

set -e

# Backing up old installation (removing the previous backup also)
rm -rf "$HOME/rslsync_bak" &>/dev/null
mv "$HOME/rslsync" "$HOME/rslsync_bak" &>/dev/null

# Create a folder for rslsync, if not present
mkdir -p "$HOME/rslsync" &>/dev/null
cd "$HOME/rslsync" || exit 1

# Download the rslsync package from AUR
cd "$HOME" || exit 1
git clone https://aur.archlinux.org/rslsync.git

# Download i386 rslsync package:
cd "$HOME/.R4SD" || exit 1
wget https://download-cdn.resilio.com/stable/linux/i386/0/resilio-sync_i386.tar.gz

# Extract i386 files to destination folder
tar -xzf resilio-sync_i386.tar.gz -C "$HOME/rslsync"

systemctl --user restart rslsync_user

# Completion of the installation
zenity --info --text="R4SD / Resilio has been successfully updated and can be accessed through a browser (e.g. Google Chrome) using the following link: http://localhost:8888" --width=300 2> /dev/null
