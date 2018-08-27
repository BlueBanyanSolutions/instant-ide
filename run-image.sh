#!/bin/bash

# SRC=~/src
# KEYS=`pwd`"/ssh"
# if [ -f $KEYS/authorized_keys ]
# then
#     echo "$KEYS/authorized_keys found..."
# else
#     echo "Creating $KEYS/authorized_keys..."
#     cp $KEYS/authorized_keys.example $KEYS/authorized_keys
# fi
# MSG="\n\
# 1. Setup file mappings: \n\
#  Source code: $SRC to /src \n\
#  Public keys of pair programmers: $KEYS/authorized_keys copied to /root/.ssh/authorized_keys \n\
# \n\"
# 2. Booting instant-ide instance...\n\
# - SSH on port 2222\n"
# echo -e $MSG
sudo docker run --init -v /home/bboyd/src:/src:Z -p 8181:8181 -it instant-ide:latest /bin/bash
