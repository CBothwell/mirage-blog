#!/bin/bash

echo "Shutting down linode instance...."
ssh -t $LINODE_USER@$LISH_HOST $LINODE_NAME shutdown
while [[ $(ssh -t $LINODE_USER@$LISH_HOST $LINODE_NAME status) =~ Running ]]
  do sleep 3
done
echo "Starting Finnix..."
ssh -t $LINODE_USER@$LISH_HOST $LINODE_NAME boot 2
while [[ $(ssh -t $LINODE_USER@$LISH_HOST $LINODE_NAME status) =~ Powered ]]
  do sleep 3
done

echo "Generating SSH key...."
ssh-keygen -f "$HOME/.ssh/id_rsa" -q -N ""

echo "Sending SSH Key and starting SSH."
expect bin/linode-finnix.expect

echo "Generating the menu.lst file"
# Create the menu.lst file#########################
cat > menu.lst << EOF
timeout 1

title mirage
root (hd0)
kernel /boot/mir-seal.xen root=/dev/xvda ro quiet
EOF
##################################################

echo "Mounting drives...."
ssh root@$LINODE_IP "mount /dev/xvda /mirage"
ssh root@$LINODE_IP "mkdir -p /mirage/boot/grub"

echo "Moving kernel to Linode...."
rsync -avP $PWD/mir-seal.xen root@$LINODE_IP:/mirage/boot/
rsync -avP $PWD/menu.lst root@$LINODE_IP:/mirage/boot/grub/

echo "Content Moved. Rebooting!"
ssh -t $LINODE_USER@$LISH_HOST $LINODE_NAME reboot 1
