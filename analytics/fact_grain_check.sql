-- analytics/fact_grain_check.sql
-- Sanity check:
-- Verifies fact_player_stats grain uniqueness:
-- (player_key, team_key, league_key, season)

SELECT
  (SELECT COUNT(*) FROM fact_player_stats) AS total_rows,
  (
    SELECT COUNT(*)
    FROM (
      SELECT DISTINCT
        player_key,
        team_key,
        league_key,
        season
      FROM fact_player_stats
    )
  ) AS distinct_events;

