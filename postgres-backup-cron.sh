#!/usr/bin/env bash
set -euo pipefail

if [[ -r /proc/1/environ ]]; then
  while IFS='=' read -r -d '' name value; do
    case "$name" in
      BACKUP_DIR|POSTGRES_HOST|POSTGRES_PORT|POSTGRES_USER|POSTGRES_PASSWORD|TZ)
        export "$name=$value"
        ;;
    esac
  done < /proc/1/environ
fi

bash /usr/local/bin/backup.sh

if [[ -r /usr/local/bin/portainer-backup.sh && -d /source-portainer ]]; then
  PORTAINER_SOURCE=/source-portainer sh /usr/local/bin/portainer-backup.sh
fi
