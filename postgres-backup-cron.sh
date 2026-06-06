#!/usr/bin/env bash
set -euo pipefail

if [ -r /proc/1/environ ]; then
  set -a
  # shellcheck disable=SC1091
  . <(tr '\0' '\n' < /proc/1/environ)
  set +a
fi

/usr/local/bin/backup.sh

if [ -x /usr/local/bin/portainer-backup.sh ]; then
  /usr/local/bin/portainer-backup.sh
fi
