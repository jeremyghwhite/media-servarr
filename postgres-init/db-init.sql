-- Create the Immich database
CREATE DATABASE immich;

-- Connect to the new database and create roles
\connect immich

-- Create required extensions as superuser
CREATE EXTENSION IF NOT EXISTS cube;
CREATE EXTENSION IF NOT EXISTS earthdistance;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS vector;

-- Create the immich user
CREATE USER immich_user WITH PASSWORD 'veD9r24Nf5vwuR';

-- Grant privileges to immich_user
ALTER DATABASE immich OWNER TO immich_user;
ALTER SCHEMA public OWNER TO immich_user;
GRANT ALL ON SCHEMA public TO immich_user;

-- Enable required extensions in the immich database
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Create the Tandoor database
CREATE DATABASE tandoor;

-- Connect to the new database and create roles
\connect tandoor

-- Create the tandoor user
CREATE USER tandoor_user WITH PASSWORD 'hZj9VTkJBRs2';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE tandoor TO tandoor_user;

-- Create the Joplin database
CREATE DATABASE joplin;

-- Connect to the new database and create roles
\connect joplin

-- Create the joplin user
CREATE USER joplin_user WITH PASSWORD 'fH72sJkP2xM8nW';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE joplin TO joplin_user;

-- Create the Vaultwarden database
CREATE DATABASE vaultwarden;

-- Connect to the new database and create roles
\connect joplin

-- Create the vault user
CREATE USER vault_user WITH PASSWORD 'b4L7a3MGGbJJ';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE vaultwarden TO vault_user;
GRANT CONNECT ON DATABASE vaultwarden TO vault_user;
GRANT USAGE ON SCHEMA public TO vault_user;
ALTER SCHEMA public OWNER TO vault_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO vault_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO vault_user;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO vault_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO vault_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO vault_user;
ALTER DATABASE vaultwarden OWNER TO vault_user;

-- Create Bazarr database and user
CREATE DATABASE bazarr;
\connect bazarr
CREATE USER bazarr_user WITH PASSWORD 'YmQFf8Z9UytZ';
ALTER DATABASE bazarr OWNER TO bazarr_user;
ALTER SCHEMA public OWNER TO bazarr_user;
GRANT ALL ON SCHEMA public TO bazarr_user;

-- Create Calibre database and user

CREATE DATABASE calibre;
\connect calibre
CREATE USER calibre_user WITH PASSWORD 'ftIa82XE6GeL';
ALTER DATABASE calibre OWNER TO calibre_user;
ALTER SCHEMA public OWNER TO calibre_user;
GRANT ALL ON SCHEMA public TO calibre_user;

-- Create Homeassistant database and user

CREATE DATABASE homeassistant;
\connect homeassistant
CREATE USER homeassistant_user WITH PASSWORD '3onoMrPULWgI';
ALTER DATABASE homeassistant OWNER TO homeassistant_user;
ALTER SCHEMA public OWNER TO homeassistant_user;
GRANT ALL ON SCHEMA public TO homeassistant_user;

-- Create Jellyfin database and user

CREATE DATABASE jellyfin;
\connect jellyfin
CREATE USER jellyfin_user WITH PASSWORD 'OM6MZAR5hGhc';
ALTER DATABASE jellyfin OWNER TO jellyfin_user;
ALTER SCHEMA public OWNER TO jellyfin_user;
GRANT ALL ON SCHEMA public TO jellyfin_user;

-- Create Jellyseerr database and user

CREATE DATABASE jellyseerr;
\connect jellyseerr
CREATE USER jellyseerr_user WITH PASSWORD 'lI831lwDvnWb';
ALTER DATABASE jellyseerr OWNER TO jellyseerr_user;
ALTER SCHEMA public OWNER TO jellyseerr_user;
GRANT ALL ON SCHEMA public TO jellyseerr_user;

-- Create Lidarr database and user
CREATE DATABASE lidarr_main;
\connect lidarr_main
CREATE USER lidarr_user WITH PASSWORD 'L4pNc2Gv6uHz';
ALTER DATABASE lidarr_main OWNER TO lidarr_user;
ALTER SCHEMA public OWNER TO lidarr_user;
GRANT ALL ON SCHEMA public TO lidarr_user;

CREATE DATABASE lidarr_logs;
\connect lidarr_logs
ALTER DATABASE lidarr_logs OWNER TO lidarr_user;
ALTER SCHEMA public OWNER TO lidarr_user;
GRANT ALL ON SCHEMA public TO lidarr_user;

-- Create Plex database and user
CREATE DATABASE plex;
\connect plex
CREATE USER plex_user WITH PASSWORD 'xklm0F2nPYQC';
ALTER DATABASE plex OWNER TO plex_user;
ALTER SCHEMA public OWNER TO plex_user;
GRANT ALL ON SCHEMA public TO plex_user;

-- Create Prowlarr database and user
CREATE DATABASE prowlarr_main;
\connect prowlarr_main
CREATE USER prowlarr_user WITH PASSWORD 'qWN6RPlzMoXP';
ALTER DATABASE prowlarr_main OWNER TO prowlarr_user;
ALTER SCHEMA public OWNER TO prowlarr_user;
GRANT ALL ON SCHEMA public TO prowlarr_user;

CREATE DATABASE prowlarr_logs;
\connect prowlarr_logs
ALTER DATABASE prowlarr_logs OWNER TO prowlarr_user;
ALTER SCHEMA public OWNER TO prowlarr_user;
GRANT ALL ON SCHEMA public TO prowlarr_user;

-- Create Radarr database and user
CREATE DATABASE sonarr_logs;
\connect sonarr_logs
CREATE USER radarr_user WITH PASSWORD 'R8vLq3Tz0bYn';
ALTER DATABASE sonarr_logs OWNER TO radarr_user;
ALTER SCHEMA public OWNER TO radarr_user;
GRANT ALL ON SCHEMA public TO radarr_user;

CREATE DATABASE radarr_logs;
\connect radarr_logs
ALTER DATABASE radarr_logs OWNER TO radarr_user;
ALTER SCHEMA public OWNER TO radarr_user;
GRANT ALL ON SCHEMA public TO radarr_user;

-- Create Readarr database and user
CREATE DATABASE readarr_main;
\connect readarr_main
CREATE USER readarr_user WITH PASSWORD 'Re4dA1rP8kQz';
ALTER DATABASE readarr_main OWNER TO readarr_user;
ALTER SCHEMA public OWNER TO readarr_user;
GRANT ALL ON SCHEMA public TO readarr_user;

CREATE DATABASE readarr_logs;
\connect readarr_logs
ALTER DATABASE readarr_logs OWNER TO readarr_user;
ALTER SCHEMA public OWNER TO readarr_user;
GRANT ALL ON SCHEMA public TO readarr_user;

-- Create Sonarr database and user
CREATE DATABASE sonarr_main;
\connect sonarr_main
CREATE USER sonarr_user WITH PASSWORD 'Jx7kP1rV9sQm';
ALTER DATABASE sonarr_main OWNER TO sonarr_user;
ALTER SCHEMA public OWNER TO sonarr_user;
GRANT ALL ON SCHEMA public TO sonarr_user;

CREATE DATABASE sonarr_logs;
\connect sonarr_logs
ALTER DATABASE sonarr_logs OWNER TO sonarr_user;
ALTER SCHEMA public OWNER TO sonarr_user;
GRANT ALL ON SCHEMA public TO sonarr_user;

-- Create Whisparr database and user
CREATE DATABASE whisparr_main;
\connect whisparr_main
CREATE USER whisparr_user WITH PASSWORD 'Aa3o6icHuT';
ALTER DATABASE whisparr_main OWNER TO whisparr_user;
ALTER SCHEMA public OWNER TO whisparr_user;
GRANT ALL ON SCHEMA public TO whisparr_user;

CREATE DATABASE whisparr_logs;
\connect whisparr_logs
ALTER DATABASE whisparr_logs OWNER TO whisparr_user;
ALTER SCHEMA public OWNER TO whisparr_user;
GRANT ALL ON SCHEMA public TO whisparr_user;




