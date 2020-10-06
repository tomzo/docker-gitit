#!/bin/bash

DIRECTORY=${GITIT_REPOSITORY}
CONF=${GITIT_CONF}
USER=${GITIT_USER}
GROUP=${GITIT_GROUP}

cd ${DIRECTORY}

if [ ! -f ${CONF} ]; then
  gitit --print-default-config > ${CONF}
  chown ${USER} ${CONF}
  chgrp ${GROUP} ${CONF}
fi

FILE="${CONF}"

LINE="port: ${GITIT_PORT}"
grep -qxF -- "$LINE" "$FILE" || sed -i "/^port: [[:digit:]]*/a ${LINE}" $FILE

