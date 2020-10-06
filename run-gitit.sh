#!/bin/bash

set -e

DIRECTORY=${GITIT_REPOSITORY}
CONF=${GITIT_CONF}
USER=${GITIT_USER}
GROUP=${GITIT_GROUP}

cd ${DIRECTORY}

if [ -d ${GITIT_REPOSITORY}/cache ]; then
  rm -rf ${GITIT_REPOSITORY}/cache/*
fi

exec chpst -u ${USER} ${GROUP} -f ${CONF}
