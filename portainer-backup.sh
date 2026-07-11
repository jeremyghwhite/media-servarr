#!/bin/sh
set -eu

backup_root=${BACKUP_ROOT:-/backups/portainer}
source_dir=${PORTAINER_SOURCE_DIR:-/source}

if [ ! -d "${source_dir}" ] && [ -d /source-portainer ]; then
  source_dir=/source-portainer
fi

if [ ! -d "${source_dir}" ]; then
  echo "Portainer source directory not found: ${source_dir}" >&2
  exit 1
fi

timestamp=$(date +"%Y%m%d-%H%M%S")
backup_file="${backup_root}/portainer-${timestamp}.tar.gz"

mkdir -p "${backup_root}"

echo "Starting Portainer backup to ${backup_file}"
tar -czf "${backup_file}" -C "${source_dir}" .
echo "Portainer backup completed: ${backup_file}"
