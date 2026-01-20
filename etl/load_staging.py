import duckdb
from pathlib import Path

DUCKDB_PATH = Path("staging/staging.duckdb")
SQL_PATH = Path("etl/sql/stg_players.sql")

print("🦆 Conectando a DuckDB...")
con = duckdb.connect(DUCKDB_PATH)

print("📜 Ejecutando SQL de staging...")
sql = SQL_PATH.read_text()
con.execute(sql)

print("✅ Tabla stg_players creada")

# chequeo rápido
rows = con.execute("SELECT COUNT(*) FROM stg_players").fetchone()[0]
print(f"📊 Filas cargadas: {rows}")

con.close()
