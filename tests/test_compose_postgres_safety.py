from pathlib import Path
import unittest


COMPOSE_FILE = Path(__file__).resolve().parents[1] / "docker-compose.yaml"


def block_for_header(header: str) -> str:
    lines = COMPOSE_FILE.read_text(encoding="utf-8").splitlines()
    start = next(
        i for i, line in enumerate(lines)
        if line == header
    )
    header_indent = len(header) - len(header.lstrip())

    end = len(lines)
    for i in range(start + 1, len(lines)):
        line = lines[i]
        if not line.strip():
            continue

        indent = len(line) - len(line.lstrip())
        if indent <= header_indent:
            end = i
            break

    return "\n".join(lines[start:end])


class ComposePostgresSafetyTest(unittest.TestCase):
    def test_postgres_uses_existing_major_version(self):
        postgres = block_for_header("  postgres:")
        backup = block_for_header("  postgres-backup:")

        self.assertIn("    image: pgvector/pgvector:pg14", postgres)
        self.assertIn("    image: postgres:14", backup)

    def test_postgres_data_volume_is_external(self):
        volume = block_for_header("  postgres-data:")

        self.assertIn("    external: true", volume)
        self.assertIn("    name: media-servarr_postgres-data", volume)


if __name__ == "__main__":
    unittest.main()
