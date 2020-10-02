#!/bin/bash

set -e

DIRECTORY=${GITIT_REPOSITORY}
CONF=${GITIT_CONF}
USER=${GITIT_USER}
GROUP=${GITIT_GROUP}

mkdir -p $DIRECTORY
cd $DIRECTORY

if [ ! -f $CONF ]; then
  gitit --print-default-config > $CONF
  chown ${USER} ${GROUP} $CONF
fi

exec chpst -u ${USER} ${GROUP} -f ${CONF}
