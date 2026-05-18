from pathlib import Path
import unittest


COMPOSE_FILE = Path(__file__).resolve().parents[1] / "docker-compose.yaml"


def read_compose_lines():
    return COMPOSE_FILE.read_text(encoding="utf-8").splitlines()


def extract_block(lines, header, indent):
    start_marker = f"{' ' * indent}{header}:"
    for index, line in enumerate(lines):
        if line == start_marker:
            start = index
            break
    else:
        raise AssertionError(f"Could not find block {start_marker!r}")

    next_sibling_prefix = " " * indent
    nested_prefix = " " * (indent + 1)
    end = len(lines)
    for index in range(start + 1, len(lines)):
        line = lines[index]
        if line.startswith(next_sibling_prefix) and not line.startswith(nested_prefix) and line.strip():
            end = index
            break

    return "\n".join(lines[start:end])


class PostgresComposeSafetyTests(unittest.TestCase):
    def setUp(self):
        self.lines = read_compose_lines()

    def test_postgres_server_uses_existing_cluster_major_version(self):
        postgres = extract_block(self.lines, "postgres", indent=2)

        self.assertIn("    image: pgvector/pgvector:pg14", postgres)
        self.assertIn("      - postgres-data:/var/lib/postgresql/data", postgres)

    def test_postgres_backup_client_matches_server_major_version(self):
        postgres_backup = extract_block(self.lines, "postgres-backup", indent=2)

        self.assertIn("    image: postgres:14", postgres_backup)

    def test_postgres_data_volume_remains_external(self):
        volumes = extract_block(self.lines, "volumes", indent=0)
        postgres_data = extract_block(volumes.splitlines(), "postgres-data", indent=2)

        self.assertIn("    external: true", postgres_data)
        self.assertIn("    name: media-servarr_postgres-data", postgres_data)


if __name__ == "__main__":
    unittest.main()
