#!/usr/bin/env python3
"""Regression checks for critical compose wiring bugs."""

from __future__ import annotations

import unittest
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[1]
COMPOSE_PATH = ROOT / "docker-compose.yaml"


class DockerComposeRegressionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.compose_text = COMPOSE_PATH.read_text(encoding="utf-8")
        cls.compose = yaml.safe_load(cls.compose_text)

    def test_sonarr_mounts_full_shared_data_tree(self) -> None:
        """Sonarr must see download-client paths and media under /data."""
        volumes = self.compose["services"]["sonarr"]["volumes"]
        self.assertIn("${DATA_ROOT}/${DATA}:/data", volumes)
        self.assertNotIn("${DATA_ROOT}/${DATA_MEDIA}:/data/media", volumes)

        # Peer *arr apps that import from download clients keep the same layout.
        for service in ("radarr", "lidarr", "bazarr"):
            self.assertIn(
                "${DATA_ROOT}/${DATA}:/data",
                self.compose["services"][service]["volumes"],
                msg=f"{service} should mount the shared data tree",
            )

    def test_subgen_uses_plex_container_port(self) -> None:
        """Subgen must call Plex on the Docker-network listen port, not host publish."""
        env = self.compose["services"]["subgenai"]["environment"]
        self.assertEqual(env["PLEXSERVER"], "http://plex:32400")
        self.assertNotIn("http://plex:${PLEX_PORT}", self.compose_text)

        plex_ports = self.compose["services"]["plex"]["ports"]
        self.assertIn("${PLEX_PORT}:32400", plex_ports)


if __name__ == "__main__":
    unittest.main()
