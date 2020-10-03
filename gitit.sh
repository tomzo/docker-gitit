#!/bin/bash

set -e

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

exec chpst -u ${USER} ${GROUP} -f ${CONF}
