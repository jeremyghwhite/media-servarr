#!/usr/bin/env bash
set -euo pipefail

backup_root=${BACKUP_ROOT:-/backups/postgres}
postgres_host=${POSTGRES_HOST:-postgres}
postgres_port=${POSTGRES_PORT:-5432}
postgres_user=${POSTGRES_USER:-postgres}
timestamp=$(date +"%Y%m%d-%H%M%S")
backup_dir="${backup_root}/${timestamp}"
backup_file="${backup_dir}/postgres-all.sql.gz"

mkdir -p "${backup_dir}"

export PGPASSWORD="${POSTGRES_PASSWORD:-${POSTGRES_PASS:-}}"

echo "Starting PostgreSQL backup to ${backup_file}"
pg_dumpall \
  --host="${postgres_host}" \
  --port="${postgres_port}" \
  --username="${postgres_user}" \
  --no-password \
  | gzip -c > "${backup_file}"

echo "PostgreSQL backup completed: ${backup_file}"
