CREATE OR REPLACE TABLE dim_league AS
SELECT
    row_number() OVER () AS league_key,
    league_id,
    league_name
FROM (
    SELECT DISTINCT
        league_id,
        league_name
    FROM staging.stg_player_stats
);
