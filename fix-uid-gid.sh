#!/bin/bash

# These are usually known at the time when building the image
DIRECTORY=$GITIT_REPOSITORY
GITIT_USER=${GITIT_USER:-gitit}
GITIT_GROUP=${GITIT_GROUP:-gitit}

if [ -z "$DIRECTORY" ]; then
  echo "Directory not specified"
  exit 1;
fi

if [ -z "$GITIT_USER" ]; then
  echo "Username not specified"
  exit 1;
fi
if [ -z "$GITIT_GROUP" ]; then
  echo "Groupname not specified"
  exit 1;
fi
if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does not exist"
  exit 1;
fi

ret=false
getent passwd $GITIT_USER >/dev/null 2>&1 && ret=true

if ! $ret; then
    echo "User $GITIT_USER does not exist"
    exit 1;
fi
ret=false
getent passwd $GITIT_GROUP >/dev/null 2>&1 && ret=true
if ! $ret; then
    echo "Group $GITIT_GROUP does not exist"
    exit 1;
fi

NEWUID=$(ls --numeric-uid-gid -d $DIRECTORY | awk '{ print $3 }')
NEWGID=$(ls --numeric-uid-gid -d $DIRECTORY | awk '{ print $4 }')

usermod -u $NEWUID $GITIT_USER
groupmod -g $NEWGID $GITIT_GROUP

find /home/gitit -user $GITIT_USER -exec chown -h $NEWUID {} \;
find /home/gitit -group $GITIT_GROUP -exec chgrp -h $NEWGID {} \;
