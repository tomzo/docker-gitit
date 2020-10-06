#!/bin/bash

FILE="/etc/ssh/sshd_config"

LINE="AuthorizedKeysFile ${SSH_AUTHORIZED_KEYS}"
grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

LINE="Port ${SSH_PORT}"
grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
