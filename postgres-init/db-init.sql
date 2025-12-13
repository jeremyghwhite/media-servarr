-- PostgreSQL Init Script
-- This script only runs when the data directory is EMPTY (first initialization)
-- It has been updated to be idempotent (safe to run multiple times)
-- However, if this script runs, it means your data was already lost

-- Create Authelia database
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'authelia_user') THEN
    CREATE USER authelia_user WITH PASSWORD 'TmTN1Gc6voyPkp';
  END IF;
END
$$;
SELECT 'CREATE DATABASE authelia' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'authelia')\gexec
\connect authelia
GRANT ALL PRIVILEGES ON DATABASE authelia TO authelia_user;
ALTER SCHEMA public OWNER TO authelia_user;
GRANT ALL ON SCHEMA public TO authelia_user;

-- Create Bazarr database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'bazarr_user') THEN
    CREATE USER bazarr_user WITH PASSWORD 'YmQFf8Z9UytZ';
  END IF;
END
$$;
SELECT 'CREATE DATABASE bazarr OWNER bazarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'bazarr')\gexec
\connect bazarr
ALTER SCHEMA public OWNER TO bazarr_user;
GRANT ALL ON SCHEMA public TO bazarr_user;
GRANT ALL PRIVILEGES ON DATABASE bazarr TO bazarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO bazarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO bazarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO bazarr_user;

-- Create Homarr database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'homarr_user') THEN
    CREATE user homarr_user WITH PASSWORD '77KOKlabti3b';
  END IF;
END
$$;
SELECT 'CREATE DATABASE homarr OWNER homarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'homarr')\gexec
\connect homarr
ALTER SCHEMA public OWNER TO homarr_user;
GRANT ALL ON SCHEMA public TO homarr_user;
GRANT ALL PRIVILEGES ON DATABASE homarr TO homarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO homarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO homarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO homarr_user;


-- Create Homeassistant database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'homeassistant_user') THEN
    CREATE USER homeassistant_user WITH PASSWORD '3onoMrPULWgI';
  END IF;
END
$$;
SELECT 'CREATE DATABASE homeassistant OWNER homeassistant_user ENCODING ''UTF8'' TEMPLATE template0' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'homeassistant')\gexec
\connect homeassistant
ALTER SCHEMA public OWNER TO homeassistant_user;
GRANT ALL ON SCHEMA public TO homeassistant_user;


-- Create the Immich database
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'immich_user') THEN
    CREATE USER immich_user WITH PASSWORD 'veD9r24Nf5vwuR';
  END IF;
END
$$;
SELECT 'CREATE DATABASE immich OWNER immich_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'immich')\gexec
\connect immich
CREATE EXTENSION IF NOT EXISTS cube;
CREATE EXTENSION IF NOT EXISTS earthdistance;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS vector;
ALTER SCHEMA public OWNER TO immich_user;
GRANT ALL ON SCHEMA public TO immich_user;


-- Create Jellyseerr database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'jellyseerr_user') THEN
    CREATE USER jellyseerr_user WITH PASSWORD 'lI831lwDvnWb';
  END IF;
END
$$;
SELECT 'CREATE DATABASE jellyseerr OWNER jellyseerr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'jellyseerr')\gexec
\connect jellyseerr
ALTER SCHEMA public OWNER TO jellyseerr_user;
GRANT ALL ON SCHEMA public TO jellyseerr_user;


-- Create the Joplin database
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'joplin_user') THEN
    CREATE USER joplin_user WITH PASSWORD 'fH72sJkP2xM8nW';
  END IF;
END
$$;
SELECT 'CREATE DATABASE joplin' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'joplin')\gexec
\connect joplin
GRANT ALL PRIVILEGES ON DATABASE joplin TO joplin_user;


-- Create Lidarr database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'lidarr_user') THEN
    CREATE USER lidarr_user WITH PASSWORD 'L4pNc2Gv6uHz';
  END IF;
END
$$;
SELECT 'CREATE DATABASE lidarr OWNER lidarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'lidarr')\gexec
\connect lidarr
ALTER SCHEMA public OWNER TO lidarr_user;
GRANT ALL ON SCHEMA public TO lidarr_user;
GRANT ALL PRIVILEGES ON DATABASE lidarr TO lidarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO lidarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO lidarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO lidarr_user;


SELECT 'CREATE DATABASE lidarr_logs OWNER lidarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'lidarr_logs')\gexec
\connect lidarr_logs
ALTER SCHEMA public OWNER TO lidarr_user;
GRANT ALL ON SCHEMA public TO lidarr_user;
GRANT ALL PRIVILEGES ON DATABASE lidarr_logs TO lidarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO lidarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO lidarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO lidarr_user;


-- Create Prowlarr database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'prowlarr_user') THEN
    CREATE USER prowlarr_user WITH PASSWORD 'qWN6RPlzMoXP';
  END IF;
END
$$;
SELECT 'CREATE DATABASE prowlarr OWNER prowlarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'prowlarr')\gexec
\connect prowlarr
ALTER SCHEMA public OWNER TO prowlarr_user;
GRANT ALL ON SCHEMA public TO prowlarr_user;
GRANT ALL PRIVILEGES ON DATABASE prowlarr TO prowlarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO prowlarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO prowlarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO prowlarr_user;

SELECT 'CREATE DATABASE prowlarr_logs OWNER prowlarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'prowlarr_logs')\gexec
\connect prowlarr_logs
ALTER SCHEMA public OWNER TO prowlarr_user;
GRANT ALL ON SCHEMA public TO prowlarr_user;
GRANT ALL PRIVILEGES ON DATABASE prowlarr_logs TO prowlarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO prowlarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO prowlarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO prowlarr_user;


-- Create Radarr database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'radarr_user') THEN
    CREATE USER radarr_user WITH PASSWORD 'R8vLq3Tz0bYn';
  END IF;
END
$$;
SELECT 'CREATE DATABASE radarr OWNER radarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'radarr')\gexec
\connect radarr
ALTER SCHEMA public OWNER TO radarr_user;
GRANT ALL ON SCHEMA public TO radarr_user;
GRANT ALL PRIVILEGES ON DATABASE radarr TO radarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO radarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO radarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO radarr_user;

SELECT 'CREATE DATABASE radarr_logs OWNER radarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'radarr_logs')\gexec
\connect radarr_logs
ALTER SCHEMA public OWNER TO radarr_user;
GRANT ALL ON SCHEMA public TO radarr_user;
GRANT ALL PRIVILEGES ON DATABASE radarr_logs TO radarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO radarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO radarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO radarr_user;


-- Create Readarr database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'readarr_user') THEN
    CREATE USER readarr_user WITH PASSWORD 'Re4dA1rP8kQz';
  END IF;
END
$$;
SELECT 'CREATE DATABASE readarr OWNER readarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'readarr')\gexec
\connect readarr
ALTER SCHEMA public OWNER TO readarr_user;
GRANT ALL ON SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON DATABASE readarr TO readarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO readarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO readarr_user;

SELECT 'CREATE DATABASE readarr_logs OWNER readarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'readarr_logs')\gexec
\connect readarr_logs
ALTER SCHEMA public OWNER TO readarr_user;
GRANT ALL ON SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON DATABASE readarr_logs TO readarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO readarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO readarr_user;

SELECT 'CREATE DATABASE readarr_cache OWNER readarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'readarr_cache')\gexec
\connect readarr_cache
ALTER SCHEMA public OWNER TO readarr_user;
GRANT ALL ON SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON DATABASE readarr_cache TO readarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO readarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO readarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO readarr_user;


-- Create Sonarr database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'sonarr_user') THEN
    CREATE USER sonarr_user WITH PASSWORD 'Jx7kP1rV9sQm';
  END IF;
END
$$;
SELECT 'CREATE DATABASE sonarr OWNER sonarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sonarr')\gexec
\connect sonarr
ALTER SCHEMA public OWNER TO sonarr_user;
GRANT ALL ON SCHEMA public TO sonarr_user;
GRANT ALL PRIVILEGES ON DATABASE sonarr TO sonarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sonarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sonarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO sonarr_user;


SELECT 'CREATE DATABASE sonarr_logs OWNER sonarr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sonarr_logs')\gexec
\connect sonarr_logs
ALTER SCHEMA public OWNER TO sonarr_user;
GRANT ALL ON SCHEMA public TO sonarr_user;
GRANT ALL PRIVILEGES ON DATABASE sonarr_logs TO sonarr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sonarr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sonarr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO sonarr_user;


-- Create the Tandoor database
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'tandoor_user') THEN
    CREATE USER tandoor_user WITH PASSWORD 'hZj9VTkJBRs2';
  END IF;
END
$$;
SELECT 'CREATE DATABASE tandoor' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'tandoor')\gexec
\connect tandoor
GRANT ALL PRIVILEGES ON DATABASE tandoor TO tandoor_user;


-- Create the Vaultwarden database
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'vault_user') THEN
    CREATE USER vault_user WITH PASSWORD 'b4L7a3MGGbJJ';
  END IF;
END
$$;
SELECT 'CREATE DATABASE vaultwarden' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'vaultwarden')\gexec
\connect vaultwarden
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


-- Create Whisparr database and user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'whisparr_user') THEN
    CREATE USER whisparr_user WITH PASSWORD 'Aa3o6icHuT';
  END IF;
END
$$;
SELECT 'CREATE DATABASE whisparr OWNER whisparr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'whisparr')\gexec
\connect whisparr
ALTER SCHEMA public OWNER TO whisparr_user;
GRANT ALL ON SCHEMA public TO whisparr_user;
GRANT ALL PRIVILEGES ON DATABASE whisparr TO whisparr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO whisparr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO whisparr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO whisparr_user;

SELECT 'CREATE DATABASE whisparr_logs OWNER whisparr_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'whisparr_logs')\gexec
\connect whisparr_logs
ALTER SCHEMA public OWNER TO whisparr_user;
GRANT ALL ON SCHEMA public TO whisparr_user;
GRANT ALL PRIVILEGES ON DATABASE whisparr_logs TO whisparr_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO whisparr_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO whisparr_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO whisparr_user;
