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

    def test_subgen_webhook_port_matches_container_publish(self) -> None:
        """Subgen must listen on the container port published by compose.

        WEBHOOKPORT controls uvicorn's bind port. The host mapping is
        `${SUBGEN_PORT}:9000`, so the process must listen on 9000 — not the
        host-side ${SUBGEN_PORT} value (e.g. 49000), which would leave both
        the published mapping and the documented Bazarr endpoint dead.
        """
        env = self.compose["services"]["subgenai"]["environment"]
        ports = self.compose["services"]["subgenai"]["ports"]

        self.assertEqual(env["WEBHOOKPORT"], 9000)
        self.assertIn("${SUBGEN_PORT}:9000", ports)
        self.assertNotIn("WEBHOOKPORT: ${SUBGEN_PORT}", self.compose_text)


if __name__ == "__main__":
    unittest.main()
