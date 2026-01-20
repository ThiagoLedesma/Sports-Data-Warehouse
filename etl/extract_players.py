import requests
import json
import time
from pathlib import Path
from datetime import date
import os

# =========================
# Configuración
# =========================
API_KEY = os.getenv("API_FOOTBALL_KEY")  # mejor práctica
BASE_URL = "https://v3.football.api-sports.io/players"

LEAGUE_ID = 39
SEASON = 2023

TODAY = date.today().isoformat()

RAW_BASE_PATH = Path(
    f"raw/api_football/players/league={LEAGUE_ID}/season={SEASON}"
)

HEADERS = {
    "x-apisports-key": API_KEY
}

SLEEP_SECONDS = 1.2  # rate limit friendly 😇

# =========================
# Helpers
# =========================
def fetch_page(page: int) -> dict:
    params = {
        "league": LEAGUE_ID,
        "season": SEASON,
        "page": page
    }

    response = requests.get(
        BASE_URL,
        headers=HEADERS,
        params=params,
        timeout=30
    )

    response.raise_for_status()
    return response.json()


# =========================
# Main
# =========================
def main():
    if not API_KEY:
        raise RuntimeError(
            "❌ Falta la variable de entorno API_FOOTBALL_KEY"
        )

    RAW_BASE_PATH.mkdir(parents=True, exist_ok=True)

    print("📡 Llamando API-Football (players)...")

    # Primera página para saber cuántas hay
    first_page = fetch_page(page=1)

    total_pages = first_page["paging"]["total"]
    print(f"📄 Total de páginas: {total_pages}")

    # Guardamos la primera
    output_path = RAW_BASE_PATH / f"snapshot={TODAY}_page=1.json"
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(first_page, f, ensure_ascii=False, indent=2)

    print("✅ Página 1 guardada")

    # Loop resto de páginas
    for page in range(2, total_pages + 1):
        print(f"📥 Descargando página {page}/{total_pages}")

        data = fetch_page(page)

        output_path = RAW_BASE_PATH / f"snapshot={TODAY}_page={page}.json"
        with open(output_path, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)

        time.sleep(SLEEP_SECONDS)

    print("🏁 Descarga completa. Raw zone poblada como los dioses del DW mandan.")


if __name__ == "__main__":
    main()
