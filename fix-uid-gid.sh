#!/bin/bash

# These are usually known at the time when building the image
DIRECTORY=$GITIT_REPOSITORY
USER=${GITIT_USER}
GROUP=${GITIT_GROUP}

if [ -z "$DIRECTORY" ]; then
  echo "Directory not specified"
  exit 1;
fi

if [ -z "$USER" ]; then
  echo "Username not specified"
  exit 1;
fi
if [ -z "$GROUP" ]; then
  echo "Groupname not specified"
  exit 1;
fi
if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does not exist"
  exit 1;
fi

ret=false
getent passwd $USER >/dev/null 2>&1 && ret=true

if ! $ret; then
    echo "User $USER does not exist"
    exit 1;
fi
ret=false
getent passwd $GROUP >/dev/null 2>&1 && ret=true
if ! $ret; then
    echo "Group $GROUP does not exist"
    exit 1;
fi

NEWUID=$(ls --numeric-uid-gid -d $DIRECTORY | awk '{ print $3 }')
NEWGID=$(ls --numeric-uid-gid -d $DIRECTORY | awk '{ print $4 }')

usermod -u $NEWUID $USER
groupmod -g $NEWGID $GROUP

find /home/gitit -user $USER -exec chown -h $NEWUID {} \;
find /home/gitit -group $GROUP -exec chgrp -h $NEWGID {} \;
