#!/bin/bash

DIRECTORY=${GITIT_REPOSITORY}
USER=${GITIT_USER}
GROUP=${GITIT_GROUP}
DIRLIST="static templates"
SRC_DIR=${GITIT_THEME_DIR}
SUFFIX=${GITIT_THEME_ACTIVE}

for DIR in ${DIRLIST}
do
  if [ $(readlink -f ${DIRECTORY}/${DIR}) != ${DIRECTORY}/${DIR}-${SUFFIX} ]; then
    unlink ${DIRECTORY}/${DIR}
    if [ ${SUFFIX} != default ]; then
      cp -r "${SRC_DIR}/out/${DIR}" "${DIRECTORY}/${DIR}-${SUFFIX}"
      chown -R ${USER} "${DIRECTORY}/${DIR}-${SUFFIX}"
      chgrp -R ${GROUP} "${DIRECTORY}/${DIR}-${SUFFIX}"
    fi
    ln -sr ${DIRECTORY}/${DIR}-${SUFFIX} ${DIRECTORY}/${DIR}
  fi
done
