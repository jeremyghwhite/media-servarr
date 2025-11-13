#!/bin/bash
set -e

export PGPASSWORD="${POSTGRES_PASSWORD}"
DATE=$(date +%Y-%m-%d_%H-%M)
echo "=== Starting PostgreSQL multi-database backup at ${DATE} ==="

SQL="SELECT datname FROM pg_database WHERE datistemplate = false AND datname NOT IN ('postgres','template0','template1');"
DBS=$(psql -h "${POSTGRES_HOST}" -U "${POSTGRES_USER}" -p "${POSTGRES_PORT}" -t -c "${SQL}")

for DB in ${DBS}; do
  DB=$(echo "${DB}" | xargs)
  echo "--- Backing up ${DB} ---"
  DB_DIR="/backups/${DB}"
  mkdir -p "${DB_DIR}"
  FILE="${DB_DIR}/${DB}_${DATE}.sql.gz"
  pg_dump -h "${POSTGRES_HOST}" -U "${POSTGRES_USER}" -p "${POSTGRES_PORT}" "${DB}" | gzip > "${FILE}"
  echo "Backup complete: ${FILE}"

  cd "${DB_DIR}"
  ls -1t ${DB}_*.sql.gz | tail -n +4 | xargs -r rm --
  echo "Old backups pruned for ${DB}"
done

echo "=== All database backups finished ==="
