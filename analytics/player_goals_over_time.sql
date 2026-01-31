-- analytics/player_goals_over_time.sql
SELECT
  p.player_name,
  f.snapshot_date,
  SUM(f.goals) AS goals
FROM fact_player_stats f
JOIN dim_player p
  ON f.player_key = p.player_key
GROUP BY
  p.player_name,
  f.snapshot_date
ORDER BY
  p.player_name,
  f.snapshot_date;
