#!/usr/bin/env sh
set -eu

backup_root="${BACKUP_ROOT:-/backups/portainer}"
timestamp="$(date -u +%Y%m%dT%H%M%SZ)"

if [ -d /source ]; then
  source_dir="/source"
elif [ -d /source-portainer ]; then
  source_dir="/source-portainer"
else
  echo "Portainer source directory is not mounted" >&2
  exit 1
fi

mkdir -p "${backup_root}"
archive="${backup_root}/portainer-${timestamp}.tar.gz"

tar -czf "${archive}" -C "${source_dir}" .
echo "Portainer backup complete: ${archive}"
