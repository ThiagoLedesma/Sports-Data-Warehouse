-- analytics/top_scorers.sql
SELECT
  p.player_name,
  f.season,
  SUM(f.goals) AS total_goals
FROM fact_player_stats f
JOIN dim_player p
  ON f.player_key = p.player_key
GROUP BY
  p.player_name,
  f.season
ORDER BY total_goals DESC;

