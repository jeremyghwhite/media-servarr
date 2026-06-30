#!/usr/bin/env bash
set -euo pipefail

backup_root="${BACKUP_ROOT:-/backups}"
backup_dir="${backup_root%/}/postgres"
timestamp="$(date +"%Y%m%d-%H%M%S")"
output_file="${backup_dir}/postgres-${timestamp}.sql.gz"
tmp_file="${output_file}.tmp"

postgres_host="${POSTGRES_HOST:-postgres}"
postgres_port="${POSTGRES_PORT:-5432}"
postgres_user="${POSTGRES_USER:-postgres}"

mkdir -p "$backup_dir"
rm -f "$tmp_file"

export PGPASSWORD="${POSTGRES_PASSWORD:-}"

pg_dumpall \
  --host="$postgres_host" \
  --port="$postgres_port" \
  --username="$postgres_user" \
  --clean \
  --if-exists \
  | gzip > "$tmp_file"

mv "$tmp_file" "$output_file"

find "$backup_dir" -type f -name "postgres-*.sql.gz" -mtime +30 -delete

echo "PostgreSQL backup written to $output_file"
