CREATE OR REPLACE TABLE dim_team AS
SELECT
    row_number() OVER () AS team_key,
    team_id,
    team_name
FROM (
    SELECT DISTINCT
        team_id,
        team_name
    FROM stg_player_stats
);
