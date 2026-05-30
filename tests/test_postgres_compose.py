from pathlib import Path
import unittest


REPO_ROOT = Path(__file__).resolve().parents[1]
COMPOSE_FILE = REPO_ROOT / "docker-compose.yaml"


def indented_block(text: str, header: str, indent: int) -> str:
    lines = text.splitlines()
    try:
        start = lines.index(header)
    except ValueError as exc:
        raise AssertionError(f"Missing compose block header: {header}") from exc

    sibling_prefix = " " * indent
    child_prefix = " " * (indent + 2)
    block = [lines[start]]

    for line in lines[start + 1 :]:
        if line.strip() and line.startswith(sibling_prefix) and not line.startswith(child_prefix):
            break
        block.append(line)

    return "\n".join(block)


class PostgresComposeInvariantsTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.compose = COMPOSE_FILE.read_text(encoding="utf-8")

    def test_postgres_server_stays_on_existing_cluster_major(self) -> None:
        block = indented_block(self.compose, "  postgres:", indent=2)

        self.assertIn("    image: pgvector/pgvector:pg14", block)
        self.assertNotIn("pgvector/pgvector:pg18", block)

    def test_postgres_backup_client_matches_server_major(self) -> None:
        block = indented_block(self.compose, "  postgres-backup:", indent=2)

        self.assertIn("    image: postgres:14", block)
        self.assertNotIn("image: postgres:18", block)

    def test_postgres_data_volume_remains_external(self) -> None:
        block = indented_block(self.compose, "  postgres-data:", indent=2)

        self.assertIn("    external: true", block)
        self.assertIn("    name: media-servarr_postgres-data", block)


if __name__ == "__main__":
    unittest.main()
