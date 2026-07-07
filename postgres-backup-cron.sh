#!/usr/bin/env bash
set -euo pipefail

if [ -r /proc/1/environ ]; then
  while IFS= read -r -d '' entry; do
    case "$entry" in
      *=*) export "$entry" ;;
    esac
  done < /proc/1/environ
fi

bash /usr/local/bin/backup.sh

if [ -d /source-portainer ] && [ -f /usr/local/bin/portainer-backup.sh ]; then
  PORTAINER_SOURCE_DIR=/source-portainer sh /usr/local/bin/portainer-backup.sh
fi
