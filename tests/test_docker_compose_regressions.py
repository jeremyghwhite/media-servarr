#!/usr/bin/env python3
"""Regression checks for critical compose wiring bugs."""

from __future__ import annotations

import json
import urllib.request
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

    def test_readarr_uses_pullable_linuxserver_image(self) -> None:
        """Readarr image must remain pullable; hotio/readarr is GHCR-DENIED."""
        image = self.compose["services"]["readarr"]["image"]
        self.assertFalse(
            image.startswith("ghcr.io/hotio/readarr"),
            f"hotio/readarr is unpublished/DENIED; got {image}",
        )
        self.assertTrue(
            image.startswith("lscr.io/linuxserver/readarr:")
            or image.startswith("ghcr.io/linuxserver/readarr:"),
            f"expected linuxserver/readarr image, got {image}",
        )
        tag = image.rsplit(":", 1)[-1]
        self.assertNotEqual(tag, "latest")
        self.assertNotEqual(tag, "develop")
        self.assertNotEqual(tag, "nightly")

        # Floating LSIO tags were emptied after deprecation; pin must resolve amd64.
        repo = "linuxserver/readarr"
        token_url = (
            "https://ghcr.io/token?service=ghcr.io"
            f"&scope=repository:{repo}:pull"
        )
        with urllib.request.urlopen(token_url, timeout=30) as resp:
            token = json.load(resp)["token"]
        req = urllib.request.Request(
            f"https://ghcr.io/v2/{repo}/manifests/{tag}",
            headers={
                "Authorization": f"Bearer {token}",
                "Accept": (
                    "application/vnd.oci.image.index.v1+json, "
                    "application/vnd.docker.distribution.manifest.list.v2+json, "
                    "application/vnd.docker.distribution.manifest.v2+json"
                ),
            },
        )
        with urllib.request.urlopen(req, timeout=30) as resp:
            manifest = json.load(resp)
        manifests = manifest.get("manifests") or []
        arches = {
            (m.get("platform") or {}).get("architecture")
            for m in manifests
            if (m.get("platform") or {}).get("os") == "linux"
        }
        self.assertIn("amd64", arches, f"{image} has no linux/amd64 manifest")


if __name__ == "__main__":
    unittest.main()
