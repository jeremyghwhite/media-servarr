#!/bin/sh
set -eu

SOURCE_DIR="${PORTAINER_SOURCE_DIR:-}"
if [ -z "$SOURCE_DIR" ]; then
  if [ -d /source ]; then
    SOURCE_DIR=/source
  else
    SOURCE_DIR=/source-portainer
  fi
fi

BACKUP_ROOT="${BACKUP_ROOT:-/backups}"
RETENTION_DAYS="${PORTAINER_BACKUP_RETENTION_DAYS:-14}"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Portainer source directory does not exist: ${SOURCE_DIR}" >&2
  exit 1
fi

timestamp="$(date +%Y%m%d_%H%M%S)"
backup_dir="${BACKUP_ROOT%/}/portainer"
backup_file="${backup_dir}/portainer_${timestamp}.tar.gz"
tmp_file="${backup_file}.tmp"

mkdir -p "$backup_dir"
trap 'rm -f "$tmp_file"' EXIT INT TERM

echo "Starting Portainer backup to ${backup_file}"
tar -czf "$tmp_file" -C "$SOURCE_DIR" .
mv "$tmp_file" "$backup_file"
trap - EXIT INT TERM

echo "Portainer backup complete: ${backup_file}"

if [ "$RETENTION_DAYS" -gt 0 ] 2>/dev/null; then
  find "$backup_dir" -type f -name 'portainer_*.tar.gz' -mtime +"$RETENTION_DAYS" -delete
fi
