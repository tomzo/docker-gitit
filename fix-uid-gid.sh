#!/bin/bash

# These are usually known at the time when building the image
DIRECTORY=$GITIT_REPOSITORY
OWNER_USERNAME=gitit
OWNER_GROUPNAME=gitit

if [ -z "$DIRECTORY" ]; then
  echo "Directory not specified"
  exit 1;
fi

if [ -z "$OWNER_USERNAME" ]; then
  echo "Username not specified"
  exit 1;
fi
if [ -z "$OWNER_GROUPNAME" ]; then
  echo "Groupname not specified"
  exit 1;
fi
if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does not exist"
  exit 1;
fi

ret=false
getent passwd $OWNER_USERNAME >/dev/null 2>&1 && ret=true

if ! $ret; then
    echo "User $OWNER_USERNAME does not exist"
    exit 1;
fi
ret=false
getent passwd $OWNER_GROUPNAME >/dev/null 2>&1 && ret=true
if ! $ret; then
    echo "Group $OWNER_GROUPNAME does not exist"
    exit 1;
fi

NEWUID=$(ls --numeric-uid-gid -d $DIRECTORY | awk '{ print $3 }')
NEWGID=$(ls --numeric-uid-gid -d $DIRECTORY | awk '{ print $4 }')

usermod -u $NEWUID $OWNER_USERNAME
groupmod -g $NEWGID $OWNER_GROUPNAME

find /home/gitit -user $OWNER_USERNAME -exec chown -h $NEWUID {} \;
find /home/gitit -group $OWNER_GROUPNAME -exec chgrp -h $NEWGID {} \;
