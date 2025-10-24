-- pgvecto.rs uses the extension name 'vectors'
CREATE EXTENSION IF NOT EXISTS vectors;
-- Enable pg_trgm often used for search (safe if present)
CREATE EXTENSION IF NOT EXISTS pg_trgm;
