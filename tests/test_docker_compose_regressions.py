from pathlib import Path
import unittest


COMPOSE = Path(__file__).resolve().parents[1] / "docker-compose.yaml"


class DockerComposeRegressionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.compose = COMPOSE.read_text(encoding="utf-8")

    def test_homepage_uses_current_image_repository(self):
        self.assertIn("image: ghcr.io/gethomepage/homepage:latest", self.compose)
        self.assertNotIn("image: ghcr.io/benphelps/homepage", self.compose)

    def test_no_windows_drive_mounts_in_linux_compose_file(self):
        self.assertNotIn("T:/:/data/media/tv", self.compose)
        self.assertEqual(
            self.compose.count("${DATA_ROOT}/${MEDIA_TV}:/data/media/tv"),
            4,
        )

    def test_decluttarr_uses_internal_servicarr_ports(self):
        self.assertIn('SONARR_URL: "http://sonarr:8989"', self.compose)
        self.assertIn('RADARR_URL: "http://radarr:7878"', self.compose)
        self.assertIn('LIDARR_URL: "http://lidarr:8686"', self.compose)
        self.assertNotIn('SONARR_URL: "http://sonarr:${SONARR_PORT}"', self.compose)
        self.assertNotIn('RADARR_URL: "http://radarr:${RADARR_PORT}"', self.compose)
        self.assertNotIn('LIDARR_URL: "http://lidarr:${LIDARR_PORT}"', self.compose)

    def test_host_ports_map_to_container_defaults(self):
        expected_mappings = [
            '"${LIDARR_PORT}:8686"',
            '"${PROWLARR_PORT}:9696"',
            '"${RADARR_PORT}:7878"',
            '"${READARR_PORT}:8787"',
            '"${SONARR_PORT}:8989"',
            '"${WHISPARR_PORT}:6969"',
        ]
        for mapping in expected_mappings:
            with self.subTest(mapping=mapping):
                self.assertIn(f"- {mapping}", self.compose)

    def test_tandoor_database_settings_match_postgres_init(self):
        self.assertIn("POSTGRES_HOST: postgres", self.compose)
        self.assertIn("POSTGRES_DB: tandoor", self.compose)
        self.assertNotIn("POSTGRES_HOST: postgres://postgres:5432", self.compose)
        self.assertNotIn("POSTGRES_DB: djangodb", self.compose)


if __name__ == "__main__":
    unittest.main()
