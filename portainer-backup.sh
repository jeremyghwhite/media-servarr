#!/bin/sh
set -eu

source_dir="${PORTAINER_BACKUP_SOURCE:-/source}"
if [ ! -d "${source_dir}" ] && [ -d /source-portainer ]; then
  source_dir=/source-portainer
fi

if [ ! -d "${source_dir}" ]; then
  echo "Portainer backup source not found: ${source_dir}" >&2
  exit 1
fi

backup_root="${PORTAINER_BACKUP_ROOT:-/backups/portainer}"
timestamp="$(date +%Y%m%d_%H%M%S)"
backup_file="${backup_root}/portainer_${timestamp}.tar.gz"

mkdir -p "${backup_root}"
umask 077
tar -czf "${backup_file}" -C "${source_dir}" .

echo "Portainer backup written to ${backup_file}"
