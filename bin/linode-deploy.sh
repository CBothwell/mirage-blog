#!/bin/bash

# Create the menu.lst file
cat > menu.lst << EOF
timeout 1

title mirage
root (hd0)
kernel /boot/mir-seal.xen root=/dev/xvda ro quiet
EOF
##################################################
