CREATE OR REPLACE TABLE stg_players AS
SELECT
    p.resp.player.id                AS player_id,
    p.resp.player.name              AS player_name,
    p.resp.player.firstname         AS firstname,
    p.resp.player.lastname          AS lastname,
    p.resp.player.age               AS age,
    p.resp.player.nationality       AS nationality,
    p.resp.player.height            AS height,
    p.resp.player.weight            AS weight,
    p.resp.player.injured           AS injured,

    s.stat.team.id                  AS team_id,
    s.stat.team.name                AS team_name,

    s.stat.league.id                AS league_id,
    s.stat.league.name              AS league_name,
    s.stat.league.season            AS season,

    s.stat.games.position           AS position,
    s.stat.games.appearences        AS appearances,
    s.stat.games.minutes            AS minutes,
    s.stat.games.rating             AS rating,

    s.stat.goals.total              AS goals,
    s.stat.goals.assists            AS assists,

    current_timestamp               AS loaded_at

FROM read_json_auto(
  'raw/api_football/players/league=*/season=*/snapshot=*.json',
  union_by_name=true
) r

CROSS JOIN UNNEST(r.response) AS p(resp)
CROSS JOIN UNNEST(p.resp.statistics) AS s(stat);

