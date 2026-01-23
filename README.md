# ⚽ Sports Data Warehouse – API-Football

Proyecto de **Data Engineering** end‑to‑end que construye un **Data Warehouse en estrella** a partir de datos deportivos obtenidos desde **API‑Football**, aplicando buenas prácticas de **ETL, modelado dimensional, data quality y analytics SQL**.

> Objetivo: demostrar cómo pasar de una API cruda a un warehouse listo para BI y análisis, con foco en diseño y confiabilidad de datos.

---

## 🧠 Arquitectura general

```
API-Football
     ↓
Raw Layer (JSON particionado)
     ↓
Staging Layer (DuckDB)
     ↓
Warehouse (Modelo estrella)
     ↓
Analytics SQL (BI)
```

* **Fuente**: API-Football (REST)
* **Storage**: archivos JSON + DuckDB
* **Lenguaje**: Python + SQL
* **Modelo**: Star Schema

---

## 📁 Estructura del proyecto

```
Sports-Data-Warehouse/
│
├── raw/                    # JSON crudos desde la API
│   └── api_football/
│
├── staging/                # DuckDB de staging
│   └── staging.duckdb
│
├── warehouse/              # DuckDB final (analytics-ready)
│   └── warehouse.duckdb
│
├── etl/
│   ├── extract/            # Scripts de extracción API → JSON
│   ├── sql/
│   │   ├── stg_*.sql       # Transformaciones de staging
│   │   ├── dim_*.sql       # Dimensiones
│   │   └── fact_*.sql      # Tabla de hechos
│   ├── load_staging.py
│   └── load_warehouse.py
│
├── etl/checks/             # Data Quality checks
│   ├── data_quality_critical.sql
│   └── data_quality_warning.sql
│
├── analytics/              # Queries BI
│   ├── top_scorers.sql
│   ├── goals_per_90.sql
│   ├── top_rated_players.sql
│   └── team_offense.sql
│
└── README.md
```

---

## 🧱 Modelo de datos

### ⭐ Dimensiones

* **dim_player**: información del jugador
* **dim_team**: equipos
* **dim_league**: ligas
* **dim_date**: calendario (generado)

### 📊 Hechos

* **fact_player_stats**

  * Métricas: minutes, goals, assists, rating, appearances
  * Grano: *jugador – equipo – liga – temporada*

---

## 🔄 ETL Flow

### 1️⃣ Extract

* Consumo de endpoints de API‑Football (`players`, `teams`, `leagues`, `fixtures`, etc.)
* Persistencia en **JSON particionado** por league, season y snapshot

### 2️⃣ Staging

* Lectura de múltiples JSON con `read_json_auto`
* Normalización de estructuras anidadas
* Limpieza de tipos y valores inconsistentes

### 3️⃣ Warehouse

* Construcción de dimensiones con **surrogate keys**
* Hechos referenciando dimensiones
* Modelo estrella optimizado para BI

---

## 🧪 Data Quality

Se implementaron checks automáticos separados por severidad:

### ✅ Critical checks

* Claves nulas en dimensiones
* Claves foráneas huérfanas en la fact table

### ⚠️ Warning checks

* Minutos inválidos (>120 o <0)

Ejemplo de output:

```
🧪 Results from data_quality_critical.sql
fact_player_stats - orphan team_key: 0

🧪 Results from data_quality_warning.sql
fact_player_stats - invalid minutes: 8
```

---

## 📊 Analytics (BI)

Ejemplos de consultas incluidas:

* Top goleadores por temporada
* Goles por 90 minutos (eficiencia)
* Jugadores mejor calificados
* Producción ofensiva por equipo

Todas las queries viven en la carpeta `analytics/` y se ejecutan directamente sobre el warehouse.

---

## 🚀 Cómo ejecutar el proyecto

```bash
# activar entorno virtual
source .venv/bin/activate

# cargar staging
python etl/load_staging.py

# construir warehouse
python etl/load_warehouse.py

# ejecutar checks de calidad
python etl/run_quality_checks.py
```

---

## 🏁 Conclusión

Este proyecto replica un flujo real de **Data Engineering**, enfatizando:

* Diseño de datos antes que código
* Separación clara de capas
* Control de calidad
* SQL orientado a negocio

Ideal como **proyecto de portfolio** para roles de Data Engineer / Analytics Engineer.

---

📌 *Datos con pelota, pero ingeniería en serio.*

