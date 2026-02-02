# 🏟️ Sports Data Warehouse – Football Analytics

## 📌 Overview

This project implements a **Sports Data Warehouse** for football data using a full **Raw → Staging → Warehouse** architecture. The goal is to ingest data from an external football API, model it using a **star schema**, and enable **incremental loads** and **BI-style analytics queries**.

The warehouse answers questions such as:

* Who are the top scorers?
* Which players are the most consistent?
* How do teams and nationalities perform over time?

---

## 🏗️ Architecture

```
raw/                → JSON snapshots from API Football
staging/            → Cleaned & incremental staging tables (DuckDB)
warehouse/          → Star schema (dimensions + fact)
etl/                → SQL + Python ETL logic
analytics/          → BI queries & sanity checks
```

### Data Flow

1. **Raw**: API responses stored as JSON snapshots
2. **Staging**:

   * Base staging tables (flattened JSON)
   * Incremental staging using `snapshot_date`
3. **Warehouse**:

   * Dimension tables (`dim_player`, `dim_team`, `dim_league`)
   * Fact table (`fact_player_stats`)
4. **Incremental control** via `etl_control`

---

## ⭐ Data Model (Star Schema)

### Dimensions

* **dim_player**: player attributes (name, age, nationality)
* **dim_team**: team metadata
* **dim_league**: league metadata

### Fact

* **fact_player_stats**

**Grain**:

> One row per **player – team – league – season**

This grain is enforced and validated using a sanity check.

---

## 🔄 Incremental Loads

Incremental logic is driven by the `etl_control` table:

```sql
(source_name, last_snapshot)
```

Each ETL run:

1. Reads only snapshots newer than `last_snapshot`
2. Merges data into dimensions and fact tables
3. Updates `etl_control`

This avoids full reloads and supports historical corrections.

---

## 🧪 Data Quality & Sanity Checks

A grain validation query ensures the fact table has no duplicates:

```sql
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT player_key, team_key, league_key, season) AS distinct_events
FROM fact_player_stats;
```

(Implemented via subquery due to DuckDB limitations.)

---

## 📊 Analytics

The `analytics/` folder contains example BI queries, including:

* Top scorers
* Most appearances
* Goals by team
* Goals by nationality
* All-round players (goals + assists)

These queries demonstrate how the warehouse can be used for football performance analysis.

---

## 🛠️ Tech Stack

* **DuckDB** – analytical database
* **Python** – orchestration
* **SQL** – transformations & modeling
* **API Football** – data source

---

## 🚀 Next Steps

* Dockerize the project for reproducibility
* Add automated ETL checks
* Optional BI dashboard (Power BI / Superset)

---

## Run with Docker

```bash
docker compose up


## 👤 Author

Built as a learning-focused end-to-end data engineering project.




