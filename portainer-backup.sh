#!/bin/sh
set -eu

backup_root="${BACKUP_ROOT:-/backups}"
if [ "${PORTAINER_SOURCE:-}" ]; then
  source_dir="$PORTAINER_SOURCE"
elif [ -d /source ]; then
  source_dir="/source"
else
  source_dir="/source-portainer"
fi
backup_dir="${backup_root%/}/portainer"
timestamp="$(date +"%Y%m%d-%H%M%S")"
output_file="${backup_dir}/portainer-${timestamp}.tar.gz"
tmp_file="${output_file}.tmp"

if [ ! -d "$source_dir" ]; then
  echo "Portainer source directory does not exist: $source_dir" >&2
  exit 1
fi

mkdir -p "$backup_dir"
rm -f "$tmp_file"

tar -czf "$tmp_file" -C "$source_dir" .
mv "$tmp_file" "$output_file"

find "$backup_dir" -type f -name "portainer-*.tar.gz" -mtime +30 -delete

echo "Portainer backup written to $output_file"
