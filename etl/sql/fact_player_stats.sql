CREATE OR REPLACE TABLE fact_player_stats AS
SELECT
    p.player_key,
    t.team_key,
    l.league_key,
    s.season,

    -- metrics
    s.appearances,
    s.minutes_clean AS minutes,
    s.goals,
    s.assists,
    s.rating

FROM staging.stg_player_stats_clean s
JOIN dim_player p
    ON s.player_id = p.player_id
JOIN dim_team t
    ON s.team_id = t.team_id
JOIN dim_league l
    ON s.league_id = l.league_id;


