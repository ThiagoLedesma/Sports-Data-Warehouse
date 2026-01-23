import duckdb
from pathlib import Path

DUCKDB_PATH = Path("staging/staging.duckdb")

SQL_FILES = [
    "etl/sql/stg_players.sql",          # base desde JSON
    "etl/sql/stg_players_clean.sql",    # dimensión jugador
    "etl/sql/stg_player_stats.sql",     # hechos
    "etl/sql/stg_player_stats_clean.sql", # hechos limpios   
]

print("🦆 Conectando a DuckDB...")
con = duckdb.connect(DUCKDB_PATH)

for sql_file in SQL_FILES:
    print(f"📜 Ejecutando {sql_file}...")
    sql = Path(sql_file).read_text()
    con.execute(sql)

print("✅ Staging separado creado")

# Checks
players = con.execute(
    "SELECT COUNT(*) FROM stg_players_clean"
).fetchone()[0]

stats = con.execute(
    "SELECT COUNT(*) FROM stg_player_stats"
).fetchone()[0]

print(f"🧍 Players únicos: {players}")
print(f"📊 Filas de stats: {stats}")

con.close()

