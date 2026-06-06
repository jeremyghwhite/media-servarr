#!/usr/bin/env sh
set -eu

backup_root="${BACKUP_ROOT:-/backups/portainer}"
timestamp="$(date -u +%Y%m%dT%H%M%SZ)"

if [ -n "${PORTAINER_SOURCE_DIR:-}" ]; then
  source_dir="${PORTAINER_SOURCE_DIR}"
elif [ -d /source ]; then
  source_dir="/source"
elif [ -d /source-portainer ]; then
  source_dir="/source-portainer"
else
  echo "Portainer source directory is not mounted" >&2
  exit 1
fi

if [ ! -d "${source_dir}" ]; then
  echo "Portainer source directory does not exist: ${source_dir}" >&2
  exit 1
fi

mkdir -p "${backup_root}"
archive="${backup_root}/portainer-${timestamp}.tar.gz"

tar -czf "${archive}" -C "${source_dir}" .
echo "Portainer backup complete: ${archive}"
