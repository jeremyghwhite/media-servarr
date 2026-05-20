import re
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
COMPOSE = ROOT / "docker-compose.yaml"


def service_block(compose_text, service_name):
    match = re.search(
        rf"(?ms)^  {re.escape(service_name)}:\n(?P<body>.*?)(?=^  [A-Za-z0-9_-]+:\n|^networks:|^volumes:|\Z)",
        compose_text,
    )
    if not match:
        raise AssertionError(f"Service {service_name!r} not found")
    return match.group("body")


class PostgresMajorVersionTest(unittest.TestCase):
    def test_postgres_images_match_existing_pg14_data_volume(self):
        compose_text = COMPOSE.read_text(encoding="utf-8")

        postgres = service_block(compose_text, "postgres")
        postgres_backup = service_block(compose_text, "postgres-backup")

        self.assertIn("image: pgvector/pgvector:pg14", postgres)
        self.assertIn("- postgres-data:/var/lib/postgresql/data", postgres)
        self.assertIn("image: postgres:14", postgres_backup)
        self.assertRegex(
            compose_text,
            r"(?ms)^volumes:\n(?:.*\n)*?  postgres-data:\n(?:.*\n)*?    name: media-servarr_postgres-data\b",
        )


if __name__ == "__main__":
    unittest.main()
