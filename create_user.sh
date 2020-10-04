#!/bin/bash

USER=${GITIT_USER}

if getent passwd ${USER} &>/dev/null; then
  echo "${USER} exist"
else
  echo "${USER} does not exist"
  echo "Creating ${USER}"
  useradd -Ums /bin/bash ${GITIT_USER}
  usermod -p '*' ${GITIT_USER}
fi
