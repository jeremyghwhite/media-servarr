#!/usr/bin/env bash
set -euo pipefail

if [ -r /proc/1/environ ]; then
  while IFS= read -r -d '' env_var; do
    case "${env_var}" in
      POSTGRES_*|TZ=*|BACKUP_ROOT=*)
        export "${env_var}"
        ;;
    esac
  done < /proc/1/environ
fi

/usr/local/bin/backup.sh

if [ -x /usr/local/bin/portainer-backup.sh ]; then
  /usr/local/bin/portainer-backup.sh
fi
