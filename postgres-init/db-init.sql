-- Create Authentik database
CREATE DATABASE authentik;
\connect authentik
CREATE USER authentik_user WITH PASSWORD 'TmTN1Gc6voyPkp';
GRANT ALL PRIVILEGES ON DATABASE authentik TO authentik_user;

-- Create Bazarr database and user
CREATE USER bazarr_user WITH PASSWORD 'YmQFf8Z9UytZ';
CREATE DATABASE bazarr OWNER bazarr_user;
\connect bazarr
ALTER SCHEMA public OWNER TO bazarr_user;
GRANT ALL ON SCHEMA public TO bazarr_user;
GRANT ALL PRIVILEGES ON DATABASE bazarr TO bazarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO bazarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO bazarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO bazarr_user;


-- Create Homeassistant database and user
CREATE USER homeassistant_user WITH PASSWORD '3onoMrPULWgI';
CREATE DATABASE homeassistant OWNER homeassistant_user ENCODING 'UTF8' TEMPLATE template0;
\connect homeassistant
ALTER SCHEMA public OWNER TO homeassistant_user;
GRANT ALL ON SCHEMA public TO homeassistant_user;


-- Create the Immich database
CREATE USER immich_user WITH PASSWORD 'veD9r24Nf5vwuR';
CREATE DATABASE immich OWNER immich_user;
\connect immich
CREATE EXTENSION IF NOT EXISTS cube;
CREATE EXTENSION IF NOT EXISTS earthdistance;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS vector;
ALTER SCHEMA public OWNER TO immich_user;
GRANT ALL ON SCHEMA public TO immich_user;


-- Create the Tandoor database
CREATE DATABASE tandoor;
\connect tandoor
CREATE USER tandoor_user WITH PASSWORD 'hZj9VTkJBRs2';
GRANT ALL PRIVILEGES ON DATABASE tandoor TO tandoor_user;

-- Create the Joplin database
CREATE DATABASE joplin;
\connect joplin
CREATE USER joplin_user WITH PASSWORD 'fH72sJkP2xM8nW';
GRANT ALL PRIVILEGES ON DATABASE joplin TO joplin_user;

-- Create the Vaultwarden database
CREATE DATABASE vaultwarden;
\connect vaultwarden
CREATE USER vault_user WITH PASSWORD 'b4L7a3MGGbJJ';
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
CREATE DATABASE lidarr;
\connect lidarr
CREATE USER lidarr_user WITH PASSWORD 'L4pNc2Gv6uHz';
ALTER DATABASE lidarr OWNER TO lidarr_user;
ALTER SCHEMA public OWNER TO lidarr_user;
GRANT ALL ON SCHEMA public TO lidarr_user;
GRANT ALL PRIVILEGES ON DATABASE lidarr TO lidarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO lidarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO lidarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO lidarr_user;


CREATE DATABASE lidarr_logs;
\connect lidarr_logs
ALTER DATABASE lidarr_logs OWNER TO lidarr_user;
ALTER SCHEMA public OWNER TO lidarr_user;
GRANT ALL ON SCHEMA public TO lidarr_user;
GRANT ALL PRIVILEGES ON DATABASE lidarr_logs TO lidarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO lidarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO lidarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO lidarr_user;

-- Create Prowlarr database and user
CREATE DATABASE prowlarr;
\connect prowlarr
CREATE USER prowlarr_user WITH PASSWORD 'qWN6RPlzMoXP';
ALTER DATABASE prowlarr OWNER TO prowlarr_user;
ALTER SCHEMA public OWNER TO prowlarr_user;
GRANT ALL ON SCHEMA public TO prowlarr_user;
GRANT ALL PRIVILEGES ON DATABASE prowlarr TO prowlarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO prowlarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO prowlarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO prowlarr_user;

CREATE DATABASE prowlarr_logs;
\connect prowlarr_logs
ALTER DATABASE prowlarr_logs OWNER TO prowlarr_user;
ALTER SCHEMA public OWNER TO prowlarr_user;
GRANT ALL ON SCHEMA public TO prowlarr_user;
GRANT ALL PRIVILEGES ON DATABASE prowlarr_logs TO prowlarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO prowlarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO prowlarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO prowlarr_user;

-- Create Radarr database and user
CREATE DATABASE radarr;
\connect radarr
CREATE USER radarr_user WITH PASSWORD 'R8vLq3Tz0bYn';
ALTER DATABASE radarr OWNER TO radarr_user;
ALTER SCHEMA public OWNER TO radarr_user;
GRANT ALL ON SCHEMA public TO radarr_user;
GRANT ALL PRIVILEGES ON DATABASE radarr TO radarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO radarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO radarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO radarr_user;

CREATE DATABASE radarr_logs;
\connect radarr_logs
ALTER DATABASE radarr_logs OWNER TO radarr_user;
ALTER SCHEMA public OWNER TO radarr_user;
GRANT ALL ON SCHEMA public TO radarr_user;
GRANT ALL PRIVILEGES ON DATABASE radarr_logs TO radarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO radarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO radarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO radarr_user;

-- Create Readarr database and user
CREATE DATABASE readarr;
\connect readarr
CREATE USER readarr_user WITH PASSWORD 'Re4dA1rP8kQz';
ALTER DATABASE readarr OWNER TO readarr_user;
ALTER SCHEMA public OWNER TO readarr_user;
GRANT ALL ON SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON DATABASE readarr TO readarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO readarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO readarr_user;

CREATE DATABASE readarr_logs;
\connect readarr_logs
ALTER DATABASE readarr_logs OWNER TO readarr_user;
ALTER SCHEMA public OWNER TO readarr_user;
GRANT ALL ON SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON DATABASE readarr_logs TO readarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO readarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO readarr_user;

CREATE DATABASE readarr_cache;
\connect readarr_cache
ALTER DATABASE readarr_cache OWNER TO readarr_user;
ALTER SCHEMA public OWNER TO readarr_user;
GRANT ALL ON SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON DATABASE readarr_cache TO readarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO readarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO readarr_user;

-- Create Sonarr database and user
CREATE DATABASE sonarr;
\connect sonarr
CREATE USER sonarr_user WITH PASSWORD 'Jx7kP1rV9sQm';
ALTER DATABASE sonarr OWNER TO sonarr_user;
ALTER SCHEMA public OWNER TO sonarr_user;
GRANT ALL ON SCHEMA public TO sonarr_user;
GRANT ALL PRIVILEGES ON DATABASE sonarr TO sonarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sonarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sonarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO sonarr_user;


CREATE DATABASE sonarr_logs;
\connect sonarr_logs
ALTER DATABASE sonarr_logs OWNER TO sonarr_user;
ALTER SCHEMA public OWNER TO sonarr_user;
GRANT ALL ON SCHEMA public TO sonarr_user;
GRANT ALL PRIVILEGES ON DATABASE sonarr_logs TO sonarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sonarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sonarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO sonarr_user;

-- Create Whisparr database and user
CREATE DATABASE whisparr;
\connect whisparr
CREATE USER whisparr_user WITH PASSWORD 'Aa3o6icHuT';
ALTER DATABASE whisparr OWNER TO whisparr_user;
ALTER SCHEMA public OWNER TO whisparr_user;
GRANT ALL ON SCHEMA public TO whisparr_user;
GRANT ALL PRIVILEGES ON DATABASE whisparr TO whisparr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO whisparr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO whisparr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO whisparr_user;

CREATE DATABASE whisparr_logs;
\connect whisparr_logs
ALTER DATABASE whisparr_logs OWNER TO whisparr_user;
ALTER SCHEMA public OWNER TO whisparr_user;
GRANT ALL ON SCHEMA public TO whisparr_user;
GRANT ALL PRIVILEGES ON DATABASE whisparr_logs TO whisparr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO whisparr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO whisparr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO whisparr_user;




