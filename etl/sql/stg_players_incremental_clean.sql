CREATE OR REPLACE TABLE staging.stg_players_incremental_clean AS
SELECT
    p.id              AS player_id,
    p.name            AS player_name,
    p.age             AS age,
    p.nationality     AS nationality,
    p.height          AS height,
    p.weight          AS weight,
    r.snapshot_date
FROM staging.stg_players_incremental r,
     UNNEST(r.response) AS t(player),
     UNNEST(t.player) AS p;

