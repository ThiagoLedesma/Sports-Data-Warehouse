-- analytics/top_players_by_league.sql
SELECT
  l.league_name,
  p.player_name,
  SUM(f.goals) AS goals
FROM fact_player_stats f
JOIN dim_player p ON f.player_key = p.player_key
JOIN dim_league l ON f.league_key = l.league_key
GROUP BY
  l.league_name,
  p.player_name
ORDER BY
  l.league_name,
  goals DESC;
