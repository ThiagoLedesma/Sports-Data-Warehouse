-- analytics/all_round_players.sql
SELECT
  p.player_name,
  SUM(f.goals)   AS goals,
  SUM(f.assists) AS assists
FROM fact_player_stats f
JOIN dim_player p ON f.player_key = p.player_key
GROUP BY p.player_name
ORDER BY (goals + assists) DESC
LIMIT 10;
