CREATE OR REPLACE TABLE staging.stg_players_incremental_clean AS
SELECT
    x.player.id              AS player_id,
    x.player.firstname       AS first_name,
    x.player.lastname        AS last_name,
    x.player.name            AS player_name,
    x.player.age             AS age,
    x.player.nationality     AS nationality,

    stats.team.id            AS team_id,
    stats.league.id          AS league_id,
    stats.league.season      AS season,

    stats.games.appearences  AS appearances,
    stats.games.minutes      AS minutes,
    stats.goals.total        AS goals,
    stats.goals.assists      AS assists,
    CAST(stats.games.rating AS DOUBLE) AS rating,

    r.snapshot_date
FROM staging.stg_players_incremental r
CROSS JOIN UNNEST(r.response) AS resp(x)
CROSS JOIN UNNEST(x.statistics) AS st(stats);






