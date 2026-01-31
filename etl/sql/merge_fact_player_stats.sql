MERGE INTO fact_player_stats f
USING (
    SELECT
        p.player_key,
        t.team_key,
        l.league_key,
        s.season,

        s.appearances,
        s.minutes,
        s.goals,
        s.assists,
        s.rating,
        s.snapshot_date
    FROM staging.stg_players_incremental_clean s
    JOIN dim_player p
        ON s.player_id = p.player_id
    JOIN dim_team t
        ON s.team_id = t.team_id
    JOIN dim_league l
        ON s.league_id = l.league_id
) src
ON  f.player_key = src.player_key
AND f.team_key   = src.team_key
AND f.league_key = src.league_key
AND f.season     = src.season

WHEN MATCHED
 AND src.snapshot_date > f.snapshot_date
THEN UPDATE SET
    appearances   = src.appearances,
    minutes       = src.minutes,
    goals         = src.goals,
    assists       = src.assists,
    rating        = src.rating,
    snapshot_date = src.snapshot_date

WHEN NOT MATCHED
THEN INSERT (
    player_key,
    team_key,
    league_key,
    season,
    appearances,
    minutes,
    goals,
    assists,
    rating,
    snapshot_date
)
VALUES (
    src.player_key,
    src.team_key,
    src.league_key,
    src.season,
    src.appearances,
    src.minutes,
    src.goals,
    src.assists,
    src.rating,
    src.snapshot_date
);

