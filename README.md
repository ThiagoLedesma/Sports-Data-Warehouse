# 🏟 Sports Data Warehouse — Football Analytics

Proyecto de **Data Engineering / Analytics Engineering** enfocado en construir un **Data Warehouse incremental** a partir de datos de fútbol obtenidos vía API, utilizando **DuckDB**, SQL y Python.

El objetivo principal es demostrar:

* modelado dimensional correcto (star schema)
* cargas incrementales reales (no full reloads)
* control de snapshots históricos
* detección y corrección de duplicados
* diseño defendible en entrevistas técnicas

---

## 🧱 Arquitectura general

```
raw/            → JSON crudo desde API
staging/        → normalización y limpieza
warehouse/      → modelo estrella final
```

**Tecnologías**:

* DuckDB
* SQL (MERGE, window functions)
* Python

---

## ⭐ Modelo dimensional (Star Schema)

### Dimensiones

* `dim_player`
* `dim_team`
* `dim_league`

### Hechos

* `fact_player_stats`

**Grain del fact**:

> 1 fila por **player + team + league + season**

---

## 🔄 Pipeline ETL

### 1️⃣ Ingesta RAW

Datos obtenidos desde API Football y almacenados como JSON:

```
raw/api_football/players/league=39/season=2023/snapshot=YYYY-MM-DD_page=X.json
```

Cada snapshot representa el estado completo de la API en una fecha determinada.

---

### 2️⃣ Staging

Normalización y limpieza de JSON:

* flatten de estructuras anidadas
* casteos de tipos
* extracción de `snapshot_date` desde filename

Tablas clave:

* `stg_players`
* `stg_players_clean`
* `stg_players_incremental`
* `stg_players_incremental_clean`

---

### 3️⃣ Incremental load (core del proyecto)

Se implementan cargas incrementales reales usando:

* snapshots
* tabla de control
* `MERGE INTO`

#### Tabla de control

```sql
etl_control(
  source_name,
  last_snapshot
)
```

Permite procesar **solo nuevos snapshots**.

---

### 4️⃣ Merge en dimensiones

Ejemplo: `dim_player`

* **UPDATE** si existe el player y el snapshot es más nuevo
* **INSERT** si el player no existe

Esto permite:

* mantener dimensiones actualizadas
* evitar duplicados

---

### 5️⃣ Merge en fact

`fact_player_stats` se carga incrementalmente usando:

* keys surrogate
* comparación de snapshot

Se corrigieron duplicados históricos mediante:

* `ROW_NUMBER()`
* limpieza one-time

---

## 🧪 Data Quality Checks

Algunos checks implementados:

* igualdad entre total rows y distinct grain
* detección de NULLs críticos
* control de duplicados post-merge

Ejemplo:

```sql
COUNT(*) = COUNT(DISTINCT player_key, team_key, league_key, season)
```

---

## 🧠 Decisiones de diseño

* DuckDB elegido por simplicidad y potencia analítica
* snapshots completos para garantizar consistencia
* MERGE para simular pipelines productivos
* evitar herramientas externas (Airflow) para foco conceptual

---

## 📈 Estado actual

* ✔ Dimensiones incrementales
* ✔ Fact incremental
* ✔ Control de snapshots
* ✔ Warehouse consistente

---

## 🔮 Próximos pasos

* Queries BI (top scorers, evolución temporal)
* Dockerización
* Orquestación (Airflow / Dagster)
* Tests automáticos

---

## 🎯 Objetivo del proyecto

Este proyecto está pensado para:

* entrevistas técnicas de Data Engineer / Analytics Engineer
* demostrar dominio real de ETL incremental
* servir como base para análisis BI

---

👤 Autor: *Thiago*



