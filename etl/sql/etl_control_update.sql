UPDATE etl_control
SET last_snapshot = (
    SELECT MAX(snapshot_date)
    FROM staging.stg_players
)
WHERE source_name = 'players';
