#!/bin/bash

DIRECTORY=$GITIT_REPOSITORY
USER=${GITIT_USER}
GROUP=${GITIT_GROUP}

if [ -d "${DIRECTORY}" ]; then
  echo "${DIRECTORY} exist"
else
  echo "${DIRECTORY} does not exist"
  echo "Creating ${DIRECTORY}"
  mkdir ${DIRECTORY}
  chown -R ${USER} ${DIRECTORY}
  chgrp -R ${GROUP} ${DIRECTORY}
fi
