INSERT INTO staging.stg_players_incremental
SELECT *
FROM staging.stg_players
WHERE snapshot_date >
    (SELECT last_snapshot
     FROM etl_control
     WHERE source_name = 'players');
