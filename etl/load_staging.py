import duckdb
from pathlib import Path

DUCKDB_PATH = Path("staging/staging.duckdb")

STAGING_BASE_SQL = [
    "etl/sql/stg_players.sql",
    "etl/sql/stg_players_clean.sql",
    "etl/sql/stg_player_stats.sql",
    "etl/sql/stg_player_stats_clean.sql",
]

STAGING_INCREMENTAL_SQL = [
    "etl/sql/stg_players_incremental.sql",
]

print("🦆 Conectando a DuckDB...")
con = duckdb.connect(DUCKDB_PATH)

print("📦 Ejecutando staging base...")
for sql_file in STAGING_BASE_SQL:
    print(f"  📜 {sql_file}")
    con.execute(Path(sql_file).read_text())

print("🔁 Ejecutando staging incremental...")
for sql_file in STAGING_INCREMENTAL_SQL:
    print(f"  📜 {sql_file}")
    con.execute(Path(sql_file).read_text())

print("✅ Staging creado correctamente")

# Checks rápidos
players = con.execute(
    "SELECT COUNT(*) FROM stg_players_clean"
).fetchone()[0]

incremental = con.execute(
    "SELECT COUNT(*) FROM stg_players_incremental"
).fetchone()[0]

print(f"🧍 Players clean: {players}")
print(f"➕ Players incrementales: {incremental}")

con.close()

