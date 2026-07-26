#!/usr/bin/env python3
"""Regression checks for critical compose wiring bugs."""

from __future__ import annotations

import unittest
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[1]
COMPOSE_PATH = ROOT / "docker-compose.yaml"
ENV_PATH = ROOT / ".env"


def _parse_env(path: Path) -> dict[str, str]:
    values: dict[str, str] = {}
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        values[key] = value
    return values


class DockerComposeRegressionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.compose_text = COMPOSE_PATH.read_text(encoding="utf-8")
        cls.compose = yaml.safe_load(cls.compose_text)
        cls.env = _parse_env(ENV_PATH)

    def test_radarr_uses_servarr_postgres_env_overrides(self) -> None:
        """Radarr Postgres wiring must use RADARR__POSTGRES__* double underscores."""
        env = self.compose["services"]["radarr"]["environment"]
        self.assertEqual(env["RADARR__POSTGRES__HOST"], "postgres")
        self.assertEqual(env["RADARR__POSTGRES__PORT"], 5432)
        self.assertEqual(env["RADARR__POSTGRES__USER"], "${RADARR_DB_USER}")
        self.assertEqual(env["RADARR__POSTGRES__PASSWORD"], "${RADARR_DB_PASS}")
        self.assertEqual(env["RADARR__POSTGRES__MAINDB"], "${RADARR_MAINDB}")
        self.assertEqual(env["RADARR__POSTGRES__LOGDB"], "${RADARR_LOGDB}")

        # Single-underscore forms are ignored by Servarr and must not remain.
        for bad_key in (
            "RADARR__POSTGRES_HOST",
            "RADARR__POSTGRES_PORT",
            "RADARR__POSTGRES_USER",
            "RADARR__POSTGRES_PASSWORD",
            "RADARR__POSTGRES_MAINDB",
        ):
            self.assertNotIn(bad_key, env)
            self.assertNotIn(f"{bad_key}:", self.compose_text)

        self.assertEqual(self.env["RADARR_MAINDB"], "radarr")
        self.assertEqual(self.env["RADARR_LOGDB"], "radarr_logs")

    def test_joplin_selects_postgres_client(self) -> None:
        """Joplin Server requires DB_CLIENT=pg to use the initialized Postgres DB."""
        env = self.compose["services"]["joplin"]["environment"]
        self.assertEqual(env["DB_CLIENT"], "pg")
        self.assertEqual(env["POSTGRES_HOST"], "postgres")
        self.assertEqual(env["POSTGRES_DATABASE"], "joplin")
        self.assertEqual(env["POSTGRES_USER"], "${JOPLIN_DB_USER}")
        self.assertEqual(env["POSTGRES_PASSWORD"], "${JOPLIN_DB_PASS}")

    def test_mylar3_mounts_full_shared_data_tree(self) -> None:
        """Mylar3 must see download-client paths and media under /data."""
        volumes = self.compose["services"]["mylar3"]["volumes"]
        self.assertIn("${DATA_ROOT}/${DATA}:/data", volumes)
        self.assertNotIn("${DATA_ROOT}/${DATA_MEDIA}:/data", volumes)

        # Download clients write under the shared /data tree.
        self.assertIn(
            "${DATA_ROOT}/${DATA_TORRENTS}:/data/torrents",
            self.compose["services"]["qbittorrent"]["volumes"],
        )


if __name__ == "__main__":
    unittest.main()
