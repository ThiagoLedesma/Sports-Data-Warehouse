INSERT INTO staging.etl_control (source_name, last_snapshot)
SELECT
    'players' AS source_name,
    MAX(snapshot_date) AS last_snapshot
FROM staging.stg_players_incremental_clean
ON CONFLICT (source_name)
DO UPDATE SET
    last_snapshot = EXCLUDED.last_snapshot;


