from pathlib import Path
import unittest


COMPOSE = Path(__file__).resolve().parents[1] / "docker-compose.yaml"


class DockerComposeRegressionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.compose = COMPOSE.read_text(encoding="utf-8")

    def test_postgres_stays_on_existing_major_version(self):
        self.assertIn("image: pgvector/pgvector:pg14", self.compose)
        self.assertIn("image: postgres:14", self.compose)
        self.assertNotIn("image: pgvector/pgvector:pg18", self.compose)
        self.assertNotIn("image: postgres:18", self.compose)

    def test_postgres_data_volume_is_external(self):
        self.assertIn("  postgres-data:\n    external: true\n    name: media-servarr_postgres-data", self.compose)

    def test_no_windows_drive_tv_mounts_in_linux_compose(self):
        self.assertNotIn("T:/:/data/media/tv", self.compose)
        self.assertEqual(
            self.compose.count("${DATA_ROOT}/${MEDIA_TV}:/data/media/tv"),
            4,
        )


if __name__ == "__main__":
    unittest.main()
