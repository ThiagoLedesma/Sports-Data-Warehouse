CREATE OR REPLACE TABLE stg_players_incremental AS
WITH raw AS (
    SELECT
        *,
        CAST(
            regexp_extract(
                filename,
                'snapshot=([0-9]{4}-[0-9]{2}-[0-9]{2})',
                1
            ) AS DATE
        ) AS snapshot_date
    FROM read_json_auto(
        'raw/api_football/players/league=*/season=*/snapshot=*.json',
        filename=true,
        union_by_name=true
    )
),
last_run AS (
    SELECT
        COALESCE(last_snapshot, DATE '1900-01-01') AS last_snapshot
    FROM etl_control
    WHERE source_name = 'players'
)
SELECT r.*
FROM raw r
CROSS JOIN last_run l
WHERE r.snapshot_date > l.last_snapshot;


