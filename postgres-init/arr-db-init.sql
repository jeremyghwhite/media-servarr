-- Create Sonarr database and user
CREATE DATABASE sonarr;
\connect sonarr
CREATE USER sonarr_user WITH PASSWORD 'Jx7kP1rV9sQm';
ALTER DATABASE sonarr OWNER TO sonarr_user;
ALTER SCHEMA public OWNER TO sonarr_user;
GRANT ALL ON SCHEMA public TO sonarr_user;

-- Create Radarr database and user
CREATE DATABASE radarr;
\connect radarr
CREATE USER radarr_user WITH PASSWORD 'R8vLq3Tz0bYn';
ALTER DATABASE radarr OWNER TO radarr_user;
ALTER SCHEMA public OWNER TO radarr_user;
GRANT ALL ON SCHEMA public TO radarr_user;

-- Create Lidarr database and user
CREATE DATABASE lidarr;
\connect lidarr
CREATE USER lidarr_user WITH PASSWORD 'L4pNc2Gv6uHz';
ALTER DATABASE lidarr OWNER TO lidarr_user;
ALTER SCHEMA public OWNER TO lidarr_user;
GRANT ALL ON SCHEMA public TO lidarr_user;

-- Create Readarr database and user
CREATE DATABASE readarr;
\connect readarr
CREATE USER readarr_user WITH PASSWORD 'Re4dA1rP8kQz';
ALTER DATABASE readarr OWNER TO readarr_user;
ALTER SCHEMA public OWNER TO readarr_user;
GRANT ALL ON SCHEMA public TO readarr_user;
