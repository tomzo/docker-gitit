#!/bin/bash

DIRECTORY=$GITIT_REPOSITORY
USER=${GITIT_USER}
GROUP=${GITIT_GROUP}

OLD_UID=$(getent passwd ${USER} |  awk -F: '{ print $3 }')
OLD_GID=$(getent group ${GROUP} |  awk -F: '{ print $3 }')
NEW_UID=$(stat -c %u $DIRECTORY)
NEW_GID=$(stat -c %g $DIRECTORY)

if [[ ${USER} = "root" && ${NEW_UID} != 0 ]]; then
    echo "${DIRECTORY} must be root owned when running as root."
    exit 1;
fi

if [[ ${USER} != "root" && ${NEW_UID} = 0 ]]; then
    echo "${DIRECTORY} must NOT be root owned when NOT running as root."
    exit 1;
fi

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

if [ "${USER}" != "root" ]; then
    usermod -u $NEW_UID $USER
    groupmod -g $NEW_GID $GROUP
    find / \( -name proc -o -name dev -o -name sys \) -prune -o \( -user ${OLD_UID} -exec chown -hv ${NEW_UID} {} + -o -group ${OLD_GID} -exec chgrp -hv ${NEW_GID} {} + \)
fi
