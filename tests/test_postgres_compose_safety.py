import re
import unittest
from pathlib import Path


COMPOSE_FILE = Path(__file__).resolve().parents[1] / "docker-compose.yaml"


def service_block(compose_text, service_name):
    match = re.search(
        rf"(?ms)^  {re.escape(service_name)}:\n(?P<body>.*?)(?=^  [a-zA-Z0-9_-]+:|\Z)",
        compose_text,
    )
    if match is None:
        raise AssertionError(f"Missing service {service_name!r}")

    return match.group("body")


class PostgresComposeSafetyTest(unittest.TestCase):
    def setUp(self):
        self.compose_text = COMPOSE_FILE.read_text(encoding="utf-8")

    def test_postgres_image_matches_existing_pg14_data_volume(self):
        postgres = service_block(self.compose_text, "postgres")
        backup = service_block(self.compose_text, "postgres-backup")

        self.assertIn("image: pgvector/pgvector:pg14", postgres)
        self.assertIn("image: postgres:14", backup)

    def test_postgres_data_volume_remains_external(self):
        match = re.search(
            r"(?ms)^volumes:\n(?P<body>.*?)(?=^[a-zA-Z0-9_-]+:|\Z)",
            self.compose_text,
        )
        self.assertIsNotNone(match, "Missing top-level volumes section")

        postgres_data = re.search(
            r"(?ms)^  postgres-data:\n(?P<body>.*?)(?=^  [a-zA-Z0-9_-]+:|\Z)",
            match.group("body"),
        )
        self.assertIsNotNone(postgres_data, "Missing postgres-data volume")

        self.assertIn("external: true", postgres_data.group("body"))
        self.assertIn("name: media-servarr_postgres-data", postgres_data.group("body"))


if __name__ == "__main__":
    unittest.main()
