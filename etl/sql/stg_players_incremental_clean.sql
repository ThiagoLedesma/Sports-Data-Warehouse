CREATE OR REPLACE TABLE stg_players_incremental_clean AS
SELECT DISTINCT
    r.unnest.player.id          AS player_id,
    r.unnest.player.name        AS player_name,
    r.unnest.player.firstname   AS first_name,
    r.unnest.player.lastname    AS last_name,
    r.unnest.player.age         AS age,
    r.unnest.player.nationality AS nationality,
    s.snapshot_date
FROM stg_players_incremental s
CROSS JOIN UNNEST(s.response) AS r;



