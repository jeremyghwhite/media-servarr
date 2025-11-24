# Media Servarr Docker Setup

This repository contains a complete Docker setup for your *arr services stack, configured to work with network-mounted media from your PHOENIX server.

## 🏗️ Architecture

- **Media Server**: PHOENIX (Windows) - Contains all media files
- **Docker Host**: New PC (Linux/WSL) - Runs all *arr services in Docker
- **Network Access**: Mapped drives and WSL mounts for remote media access

## 📁 Directory Structure

```
media-servarr/
├── docker-compose.yaml          # Main Docker Compose configuration
├── setup-docker.sh             # Linux/WSL setup script
├── setup-docker.ps1            # Windows PowerShell setup script
├── downloads/                   # Local downloads (ignored in git)
├── backups/                    # Backup storage (structure tracked, files ignored)
├── media/                      # Local media (structure tracked, files ignored)
└── [service-configs]/          # Individual service configurations
```

## 🚀 Quick Start

### Prerequisites

1. **Network Drive Mapping** (Windows):
   ```powershell
   net use D: \\PHOENIX\Data\Downloads /user:jeremy welcome
   net use M: \\PHOENIX\Movies /user:jeremy welcome
   net use N: \\PHOENIX\Music /user:jeremy welcome
   net use P: \\PHOENIX\Photos /user:jeremy welcome
   net use T: \\PHOENIX\tv /user:jeremy welcome
   net use B: \\PHOENIX\Bookz /user:jeremy welcome
   ```

2. **WSL Mounts** (Linux/WSL):
   ```bash
   sudo mkdir -p /media-servarr/media/phoenix_movies
   sudo mount -t drvfs '\\PHOENIX\Movies' /media-servarr/media/phoenix_movies
   sudo mkdir -p /media-servarr/media/phoenix_tv
   sudo mount -t drvfs '\\PHOENIX\tv' /media-servarr/media/phoenix_tv
   sudo mkdir -p /media-servarr/media/phoenix_music
   sudo mount -t drvfs '\\PHOENIX\Music' /media-servarr/media/phoenix_music
   sudo mkdir -p /media-servarr/media/phoenix_books
   sudo mount -t drvfs '\\PHOENIX\Bookz' /media-servarr/media/phoenix_books
   sudo mkdir -p /media-servarr/media/phoenix_photos
   sudo mount -t drvfs '\\PHOENIX\Photos' /media-servarr/media/phoenix_photos
   sudo mkdir -p /media-servarr/media/phoenix_downloads
   sudo mount -t drvfs '\\PHOENIX\Data\Downloads' /media-servarr/media/phoenix_downloads
   ```

### Setup

**For Windows:**
```powershell
.\setup-docker.ps1
```

**For Linux/WSL:**
```bash
chmod +x setup-docker.sh
./setup-docker.sh
```

## 🐳 Services

| Service | Port | Description |
|---------|------|-------------|
| **Prowlarr** | 9696 | Indexer management |
| **Radarr** | 7878 | Movie management |
| **Sonarr** | 8989 | TV show management |
| **Readarr** | 8787 | Book management |
| **Lidarr** | 8686 | Music management |
| **Bazarr** | 6767 | Subtitle management |
| **qBittorrent** | 8080 | Torrent client |
| **Jellyfin** | 8096 | Media server |
| **Jellyseerr** | 5055 | Request management |
| **AdGuard** | 3000 | DNS ad blocking |
| **Vaultwarden** | 3012 | Password manager |
| **Immich** | 2283 | Photo management |
| **Home Assistant** | 8123 | Home automation |
| **Joplin** | 22300 | Note taking |
| **Tandoor** | 8081 | Recipe management |

## 🔧 Configuration

### Media Paths

The Docker Compose file is configured with the following media paths:
- Movies: `/media-servarr/media/phoenix_movies`
- TV Shows: `/media-servarr/media/phoenix_tv`
- Music: `/media-servarr/media/phoenix_music`
- Books: `/media-servarr/media/phoenix_books`
- Photos: `/media-servarr/media/phoenix_photos`
- Downloads: `/media-servarr/media/phoenix_downloads`

### Service Configuration

Each service stores its configuration in its respective folder:
- `./prowlarr/config/` - Prowlarr configuration
- `./radarr/config/` - Radarr configuration
- `./sonarr/config/` - Sonarr configuration
- etc.

## 🔄 Backup Strategy

- **Backups folder**: Structure tracked in git, actual backup files ignored
- **Media folder**: Structure tracked in git, actual media files ignored
- **Downloads folder**: Structure tracked in git, download files ignored
- **Configurations**: All service configs are tracked in git

## 🚨 Troubleshooting

### Network Drive Issues
- Ensure network drives are properly mapped before starting services
- Check that WSL mounts are active: `mount | grep phoenix`
- Verify permissions on network shares

### Service Access Issues
- Check if ports are already in use: `netstat -tulpn | grep :PORT`
- Verify Docker containers are running: `docker ps`
- Check container logs: `docker logs CONTAINER_NAME`

### Permission Issues
- Ensure proper ownership: `sudo chown -R 1000:1000 .`
- Check WSL mount permissions: `ls -la /media-servarr/media/`

## 📝 Maintenance

### Updates
```bash
docker-compose pull
docker-compose up -d
```

### Backups
```bash
# Backup configurations
tar -czf backup-$(date +%Y%m%d).tar.gz */config/

# Restore configurations
tar -xzf backup-YYYYMMDD.tar.gz
```

### Logs
```bash
# View all logs
docker-compose logs

# View specific service logs
docker-compose logs radarr
```

## Postgres

docker exec -it postgres psql -U postgres -d postgres

\l		- list DBs
\du 	- list users

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname='sonarr'
  AND pid <> pg_backend_pid();



## Docker Commands

Stop all containers:
	docker compose down

Start all containers:
	docker compose up -d

Prune old Docker volumes and mounts:
	docker system prune -af --volumes


## SQLlite to Postgres migration


1. Create the databases, e.g. CREATE DATABASE sonarr; and CREATE DATABASE sonarr_log;,

2. Configure the app to use postgres and start it, which will create the tables
	> docker compose up -d sonarr

3. Dump the schema: pg_dump sonarr -s > sonarr.sql
	> docker exec -i postgres sh -c "pg_dump -U postgres -d sonarr -s" > ~/media-servarr-app-data/server-backups/_psql/sonarr/sonarr.sql

4. Drop the database and recreate it, e.g. DROP DATABASE sonarr; DROP DATABASE sonarr;
	> docker exec -it postgres psql -U postgres -d postgres
	> DROP DATABASE sonarr;
	> CREATE DATABASE sonarr OWNER sonarr_user;
	> exit
	

5. Import the schema you've just dumped: psql sonarr < sonarr.sql
	> PG_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' postgres)
	> pgloader sqlite:///home/jeremy/media-servarr-app-data/server-backups/sonarr/manual/sonarr_backup_v4.0.15.2940_2025.11.14_10.57.43/sonarr.db  postgresql://postgres@${PG_IP}:5432/sonarr


docker run --rm -it \
  --network=media-servarr_default \
  -v /home/jeremy/media-servarr-app-data/server-backups/sonarr/manual/sonarr_backup_v4.0.15.2940_2025.11.14_10.57.43:/data \
  dimitri/pgloader:latest \
  pgloader sqlite:///data/sonarr.db postgresql://postgres:dNhv6pQMkpGM@postgres:5432/sonarr



6. Import your old database using pgloader.


====


1. Stop Sonarr
	docker compose stop sonarr
2. delete old sonarr and sonarr_logs sqlite DBs
	rm /home/jeremy/media-servarr-app-data/sonarr/config/logs.db*
	rm /home/jeremy/media-servarr-app-data/sonarr/config/sonarr.db*
3. DELETE/RECREATE
	docker exec -it postgres psql -U postgres -c "DROP DATABASE sonarr;"
	docker exec -it postgres psql -U postgres -c "CREATE DATABASE sonarr OWNER sonarr_user;"

	docker exec -it postgres psql -U postgres -c "DROP DATABASE sonarr_logs;"
	docker exec -it postgres psql -U postgres -c "CREATE DATABASE sonarr_logs OWNER sonarr_user;"
4. Restore sqlite DB using pgloader

docker run --rm -it \
  --network=media-servarr_default \
  -v /home/jeremy/media-servarr-app-data/server-backups/sonarr/manual/sonarr_backup_v4.0.15.2940_2025.11.14_10.57.43:/data \
  dimitri/pgloader:latest \
  pgloader sqlite:///data/sonarr.db postgresql://postgres:dNhv6pQMkpGM@postgres:5432/sonarr
5. Start Sonarr
	docker compose up -d sonarr


---- Using pgloader in docker container ----

If you want to completely reset Sonarr’s PostgreSQL DB to “fresh install” state, run this:

DROP DATABASE sonarr;
DROP DATABASE sonarr_logs;
CREATE DATABASE sonarr;
CREATE DATABASE sonarr_logs;

After that:
- Start Sonarr
- It will recreate tables automatically
- Stop Sonarr
- Run pgloader

1. manual backup on sqlite DB
2. Update config.xml with postgres configuration

  <PostgresUser>sonarr_user</PostgresUser>
  <PostgresPassword>Jx7kP1rV9sQm</PostgresPassword>
  <PostgresPort>5432</PostgresPort>
  <PostgresHost>postgres</PostgresHost>
  <PostgresMainDb>sonarr</PostgresMainDb>
  <PostgresLogDb>sonarr_logs</PostgresLogDb>
  
3. Restart Sonarr so it connects to the empty postgres DB and create tables
4. Stop Sonarr
5. Connect to sonarr DB using postgres container

# psql -U postgres -d postgres
postgres=# \c sonarr
DELETE FROM "QualityProfiles";
DELETE FROM "QualityDefinitions";
DELETE FROM "DelayProfiles";
DELETE FROM "Metadata";
DELETE FROM "Config";
DELETE FROM "VersionInfo";
DELETE FROM "ScheduledTasks";
	
6. Start migration with pgloader

pgloader --with "quote identifiers" --with "data only" /data/_psql/lidarr/lidarr.db "postgresql://postgres:dNhv6pQMkpGM@postgres:5432/lidarr"
pgloader --with "quote identifiers" --with "data only" /data/_psql/radarr/radarr.db "postgresql://postgres:dNhv6pQMkpGM@postgres:5432/radarr"
pgloader --with "quote identifiers" --with "data only" /data/_psql/sonarr/sonarr.db "postgresql://postgres:dNhv6pQMkpGM@postgres:5432/sonarr"
pgloader --with "quote identifiers" --with "data only" /data/_psql/prowlarr/prowlarr.db "postgresql://postgres:dNhv6pQMkpGM@postgres:5432/prowlarr"
pgloader --with "quote identifiers" --with "data only" /data/_psql/readarr/readarr.db "postgresql://postgres:dNhv6pQMkpGM@postgres:5432/readarr"
pgloader --with "quote identifiers" --with "data only" /data/_psql/whisparr/whisparr2.db "postgresql://postgres:dNhv6pQMkpGM@postgres:5432/whisparr"

pgloader --with "quote identifiers" /data/_psql/bazarr/bazarr.db "postgresql://postgres:dNhv6pQMkpGM@postgres:5432/bazarr"


7. Verify data in postgres db

docker exec -it postgres psql -U sonarr_user -d sonarr -c "SELECT COUNT(*) FROM Series;"
docker exec -it postgres psql -U sonarr_user -d sonarr -c "SELECT COUNT(*) FROM Episodes;"
