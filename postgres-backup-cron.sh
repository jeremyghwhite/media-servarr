#!/usr/bin/env bash
set -euo pipefail

if [ -r /proc/1/environ ]; then
  while IFS= read -r -d '' entry; do
    case "$entry" in
      POSTGRES_HOST=*|POSTGRES_PORT=*|POSTGRES_USER=*|POSTGRES_PASSWORD=*|BACKUP_ROOT=*|TZ=*)
        export "$entry"
        ;;
    esac
  done < /proc/1/environ
fi

exec /usr/local/bin/backup.sh
