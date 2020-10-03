#!/bin/bash

LINE="AuthorizedKeysFile ${SSH_AUTHORIZED_KEYS}"
FILE="/etc/ssh/sshd_config"

grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
