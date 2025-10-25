-- Official pgvector uses the extension name 'vector'
CREATE EXTENSION IF NOT EXISTS vector;
-- Enable pg_trgm often used for search (safe if present)
CREATE EXTENSION IF NOT EXISTS pg_trgm;
