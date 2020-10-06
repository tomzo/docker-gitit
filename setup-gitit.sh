#!/bin/bash

DIRECTORY=${GITIT_REPOSITORY}
CONF=${GITIT_CONF}
USER=${GITIT_USER}
GROUP=${GITIT_GROUP}
DIRLIST="static templates"
GITIT_THEME_ACTIVE=${GITIT_THEME_ACTIVE}

cd ${DIRECTORY}

if [ ! -f ${CONF} ]; then
  gitit --print-default-config > ${CONF}
  chown ${USER} ${CONF}
  chgrp ${GROUP} ${CONF}
  chpst -u ${USER} ${GROUP} -f ${CONF} &
  sleep 2
  kill $!
fi

for DIR in ${DIRLIST}
do
  if [ ! -L ${DIRECTORY}/${DIR}-default ]; then
    mv ${DIRECTORY}/${DIR}{,-default}
    ln -sr ${DIRECTORY}/${DIR}-default ${DIRECTORY}/$DIR
  fi
done

FILE="${CONF}"

LINE="port: ${GITIT_PORT}"
grep -qxF -- "$LINE" "$FILE" || sed -i "/^port: [[:digit:]]*/a ${LINE}" $FILE
