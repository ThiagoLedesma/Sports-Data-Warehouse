CREATE OR REPLACE TABLE stg_player_stats AS
SELECT
    player_id,
    team_id,
    team_name,
    league_id,
    league_name,
    season,
    position,
    appearances,
    minutes,
    rating,
    goals,
    assists,
    loaded_at
FROM stg_players;
