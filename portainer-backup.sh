#!/bin/sh
set -eu

backup_root="${BACKUP_DIR:-/backups}"
source_dir="${PORTAINER_SOURCE:-/source}"
timestamp="$(date +%Y%m%d-%H%M%S)"
destination="${backup_root%/}/portainer"

if [ ! -d "$source_dir" ]; then
  echo "Portainer source directory not found: $source_dir" >&2
  exit 1
fi

mkdir -p "$destination"

tar -czf "${destination}/portainer-${timestamp}.tar.gz" -C "$source_dir" .

echo "Portainer backup written to ${destination}/portainer-${timestamp}.tar.gz"
