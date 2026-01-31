-- analytics/most_appearances.sql
SELECT
  p.player_name,
  SUM(f.appearances) AS appearances
FROM fact_player_stats f
JOIN dim_player p ON f.player_key = p.player_key
GROUP BY p.player_name
ORDER BY appearances DESC
LIMIT 10;
