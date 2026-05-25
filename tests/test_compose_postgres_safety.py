from pathlib import Path


COMPOSE_FILE = Path(__file__).resolve().parents[1] / "docker-compose.yaml"


def main() -> None:
    compose = COMPOSE_FILE.read_text(encoding="utf-8")

    assert "image: pgvector/pgvector:pg14" in compose
    assert "image: postgres:14" in compose
    assert (
        "  postgres-data:\n"
        "    external: true\n"
        "    name: media-servarr_postgres-data\n"
    ) in compose


if __name__ == "__main__":
    main()
