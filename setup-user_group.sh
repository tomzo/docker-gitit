#!/bin/bash

USER=${GITIT_USER}
GROUP=${GITIT_GROUP}

if getent passwd ${USER} &>/dev/null; then
  echo "${USER} exist"
else
  echo "${USER} does not exist"
  echo "Creating ${USER}"
  useradd -Ums /bin/bash ${GITIT_USER}
  usermod -p '*' ${GITIT_USER}
fi

if getent group ${GROUP} &>/dev/null; then
  echo "${GROUP} exist"
else
  echo "${GROUP} does not exist"
  echo "Creating ${GROUP}"
  groupadd ${GITIT_GROUP}
fi
