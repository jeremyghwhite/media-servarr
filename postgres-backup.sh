#!/usr/bin/env bash
set -euo pipefail

backup_root="${BACKUP_ROOT:-/backups/postgres}"
timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
backup_dir="${backup_root}/${timestamp}"
host="${POSTGRES_HOST:-postgres}"
port="${POSTGRES_PORT:-5432}"
user="${POSTGRES_USER:-postgres}"

mkdir -p "${backup_dir}"
export PGPASSWORD="${POSTGRES_PASSWORD:-}"

echo "Waiting for PostgreSQL at ${host}:${port}..."
until pg_isready -h "${host}" -p "${port}" -U "${user}" >/dev/null 2>&1; do
  sleep 2
done

echo "Writing PostgreSQL backup to ${backup_dir}/all-databases.sql.gz"
pg_dumpall -h "${host}" -p "${port}" -U "${user}" | gzip > "${backup_dir}/all-databases.sql.gz"

echo "PostgreSQL backup complete: ${backup_dir}/all-databases.sql.gz"
