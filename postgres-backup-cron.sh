#!/usr/bin/env bash
set -euo pipefail

# Cron does not inherit the container environment, so reload the variables
# Docker injected into PID 1 before invoking the mounted backup script.
while IFS= read -r -d '' env_var; do
  case "${env_var}" in
    POSTGRES_HOST=*|POSTGRES_PORT=*|POSTGRES_USER=*|POSTGRES_PASSWORD=*|BACKUP_ROOT=*|TZ=*)
      export "${env_var}"
      ;;
  esac
done < /proc/1/environ

exec /usr/bin/env bash /usr/local/bin/backup.sh
