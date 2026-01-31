-- analytics/goals_by_nationality.sql
SELECT
  p.nationality,
  SUM(f.goals) AS goals
FROM fact_player_stats f
JOIN dim_player p ON f.player_key = p.player_key
GROUP BY p.nationality
ORDER BY goals DESC;
