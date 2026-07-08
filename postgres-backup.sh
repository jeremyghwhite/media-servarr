#!/usr/bin/env bash
set -euo pipefail

POSTGRES_HOST="${POSTGRES_HOST:-postgres}"
POSTGRES_PORT="${POSTGRES_PORT:-5432}"
POSTGRES_USER="${POSTGRES_USER:-postgres}"
BACKUP_ROOT="${BACKUP_ROOT:-/backups}"
RETENTION_DAYS="${POSTGRES_BACKUP_RETENTION_DAYS:-14}"

if [ -z "${POSTGRES_PASSWORD:-}" ]; then
  echo "POSTGRES_PASSWORD is required for PostgreSQL backups" >&2
  exit 1
fi

timestamp="$(date +%Y%m%d_%H%M%S)"
backup_dir="${BACKUP_ROOT%/}/_psql"
backup_file="${backup_dir}/postgres_cluster_${timestamp}.sql.gz"
tmp_file="${backup_file}.tmp"

mkdir -p "$backup_dir"
umask 077
trap 'rm -f "$tmp_file"' EXIT INT TERM

export PGPASSWORD="$POSTGRES_PASSWORD"

echo "Starting PostgreSQL cluster backup to ${backup_file}"
pg_dumpall \
  --host="$POSTGRES_HOST" \
  --port="$POSTGRES_PORT" \
  --username="$POSTGRES_USER" \
  --clean \
  --if-exists \
  | gzip > "$tmp_file"

mv "$tmp_file" "$backup_file"
trap - EXIT INT TERM

echo "PostgreSQL cluster backup complete: ${backup_file}"

if [ "$RETENTION_DAYS" -gt 0 ] 2>/dev/null; then
  find "$backup_dir" -type f -name 'postgres_cluster_*.sql.gz' -mtime +"$RETENTION_DAYS" -delete
fi
