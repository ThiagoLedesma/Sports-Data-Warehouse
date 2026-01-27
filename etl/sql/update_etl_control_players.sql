UPDATE staging.etl_control
SET last_snapshot = (
    SELECT MAX(snapshot_date)
    FROM staging.stg_players_incremental
)
WHERE source_name = 'players';
