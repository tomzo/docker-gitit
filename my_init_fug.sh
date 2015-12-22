#!/bin/bash

/usr/bin/fix-uid-gid $GITIT_REPOSITORY gitit gitit
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

/sbin/my_init
