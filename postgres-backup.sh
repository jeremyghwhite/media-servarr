#!/usr/bin/env bash
set -euo pipefail

: "${POSTGRES_HOST:?POSTGRES_HOST is required}"
: "${POSTGRES_PORT:=5432}"
: "${POSTGRES_USER:?POSTGRES_USER is required}"
: "${POSTGRES_PASSWORD:?POSTGRES_PASSWORD is required}"

backup_root="${BACKUP_ROOT:-/backups/postgres}"
timestamp="$(date +%Y%m%d_%H%M%S)"
backup_file="${backup_root}/postgres_all_${timestamp}.sql.gz"

mkdir -p "${backup_root}"
umask 077

export PGPASSWORD="${POSTGRES_PASSWORD}"
pg_dumpall \
  --host="${POSTGRES_HOST}" \
  --port="${POSTGRES_PORT}" \
  --username="${POSTGRES_USER}" \
  --no-password \
  | gzip > "${backup_file}"

echo "PostgreSQL backup written to ${backup_file}"
