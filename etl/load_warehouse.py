import duckdb
from pathlib import Path

DUCKDB_PATH = Path("warehouse/warehouse.duckdb")

SQL_FILES = [
    "etl/sql/dim_date.sql",
    "etl/sql/dim_player.sql",
    "etl/sql/dim_team.sql",
    "etl/sql/dim_league.sql",
    "etl/sql/fact_player_stats.sql",
]

print("🏗️ Construyendo warehouse...")

con = duckdb.connect(DUCKDB_PATH)

# 🔗 ACA MISMO va el ATTACH (NO antes, NO después)
con.execute("""
ATTACH 'staging/staging.duckdb' AS staging;
""")

for sql_file in SQL_FILES:
    print(f"📜 Ejecutando {sql_file}...")
    sql = Path(sql_file).read_text()
    con.execute(sql)

players = con.execute("SELECT COUNT(*) FROM dim_player").fetchone()[0]
teams   = con.execute("SELECT COUNT(*) FROM dim_team").fetchone()[0]
leagues = con.execute("SELECT COUNT(*) FROM dim_league").fetchone()[0]
dates   = con.execute("SELECT COUNT(*) FROM dim_date").fetchone()[0]

print(f"🧍 Dim players: {players}")
print(f"🏟️ Dim teams: {teams}")
print(f"🏆 Dim leagues: {leagues}")
print(f"📅 Dim dates: {dates}")

facts = con.execute(
    "SELECT COUNT(*) FROM fact_player_stats"
).fetchone()[0]

print(f"📊 Fact rows: {facts}")

con.close()


