CREATE OR REPLACE TABLE stg_player_stats_incremental AS
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
  'raw/api_football/player_stats/league=*/season=*/snapshot=*.json',
  filename=true,
  union_by_name=true
)
WHERE snapshot_date >
    (SELECT last_snapshot
     FROM etl_control
     WHERE source_name = 'player_stats');
