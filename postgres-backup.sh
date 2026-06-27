#!/usr/bin/env bash
set -euo pipefail

backup_root="${BACKUP_DIR:-/backups}"
timestamp="$(date +%Y%m%d-%H%M%S)"
destination="${backup_root%/}/postgres"

mkdir -p "$destination"

export PGPASSWORD="${POSTGRES_PASSWORD:-}"

pg_dumpall \
  --host="${POSTGRES_HOST:-postgres}" \
  --port="${POSTGRES_PORT:-5432}" \
  --username="${POSTGRES_USER:-postgres}" \
  --file="${destination}/postgres-${timestamp}.sql"

gzip "${destination}/postgres-${timestamp}.sql"

echo "PostgreSQL backup written to ${destination}/postgres-${timestamp}.sql.gz"
