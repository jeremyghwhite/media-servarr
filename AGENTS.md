# AGENTS.md

## Overview

This is a Docker Compose infrastructure-as-code repository ("Media Servarr") that orchestrates 40 containerized services for automated media acquisition, management, streaming, home automation, and personal productivity. There is no application source code to build or compile; all development work involves editing `docker-compose.yaml`, `.env`, `postgres-init/db-init.sql`, and config files.

## Cursor Cloud specific instructions

### Architecture

- **Compose file**: `docker-compose.yaml` (single file, ~1011 lines, 40 services)
- **Environment**: `.env` contains all secrets, paths, ports, and API keys
- **Database init**: `postgres-init/db-init.sql` creates 15+ databases and users on first Postgres startup
- **DATA_ROOT**: All service data lives under `DATA_ROOT` (defined in `.env`, default `/home/jeremy/media-servarr-app-data`)

### Validation (lint equivalent)

```bash
docker compose config --quiet
```

This validates the compose file syntax and variable interpolation. Exit code 0 means valid.

### Running services

Standard commands per `README.md`:
- Start all: `docker compose up -d`
- Stop all: `docker compose down`
- Start specific: `docker compose up -d postgres redis vaultwarden`
- Logs: `docker compose logs <service>`

### Cloud VM caveats

1. **Docker-in-Docker**: The cloud VM runs inside a container, requiring `fuse-overlayfs` storage driver and `iptables-legacy`. Docker daemon must be started manually: `sudo dockerd &>/tmp/dockerd.log &`
2. **Missing network mounts**: The compose file references Windows drive letters (`T:/`, `E:/`) and PHOENIX server SMB mounts. In the cloud VM, create empty directories at `/T`, `/E`, and under `DATA_ROOT` so Docker can bind-mount them without errors.
3. **Missing script files**: The compose file mounts `./portainer-backup.sh`, `./postgres-backup.sh`, and `./postgres-backup-cron.sh` which are not tracked in git. Create empty placeholder files with `touch` so containers can start.
4. **Placeholder config files**: Several services require config files to exist before mounting:
   - `${DATA_ROOT}/vaultwarden/config/vaultwarden.env`
   - `${DATA_ROOT}/decluttarr/config/config.yaml`
   - `${DATA_ROOT}/subgen/data/subgen.env`
   - `${DATA_ROOT}/caddy/Caddyfile`
   - `${DATA_ROOT}/cloudflared/config/config.yml`, `cert.pem`, and tunnel JSON
5. **Prowlarr port mismatch**: Prowlarr listens on port 9696 internally but the compose maps `${PROWLARR_PORT}:${PROWLARR_PORT}` (48086:48086). Access it via the container's internal IP on port 9696, or adjust the port mapping in the compose file.
6. **Vaultwarden HTTPS requirement**: Account creation in Vaultwarden requires HTTPS. In the cloud VM without TLS termination, the web vault login page loads but account creation may be blocked by the client-side security policy.
7. **Minimal viable subset**: For testing, start `postgres`, `redis`, and individual services as needed rather than the full stack (which requires all 40 services for Caddy's dependency chain).
