import duckdb
from pathlib import Path
import sys

con = duckdb.connect("warehouse/warehouse.duckdb")

def run_checks(sql_file, fail_on_issues=False):
    sql = Path(sql_file).read_text()
    results = con.execute(sql).fetchall()

    print(f"\n🧪 Results from {sql_file}")
    for check, issues in results:
        print(f"  {check}: {issues}")
        if fail_on_issues and issues > 0:
            print("❌ Critical data quality check failed")
            sys.exit(1)

# críticos → rompen pipeline
run_checks("etl/checks/data_quality_critical.sql", fail_on_issues=True)

# warnings → solo informan
run_checks("etl/checks/data_quality_warning.sql", fail_on_issues=False)

print("\n✅ Data quality checks passed")
con.close()
