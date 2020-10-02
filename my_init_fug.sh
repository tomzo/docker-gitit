#!/bin/bash

/usr/bin/fix-uid-gid
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

/sbin/my_init
