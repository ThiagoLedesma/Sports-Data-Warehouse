import subprocess

steps = [
    "etl/load_staging.py",
    "etl/load_warehouse.py",
]

for step in steps:
    print(f"🚀 Running {step}")
    subprocess.run(["python", step], check=True)

print("✅ ETL completed successfully")
