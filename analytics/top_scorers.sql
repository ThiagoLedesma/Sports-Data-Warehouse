-- Top 10 goleadores por temporada
SELECT
    p.player_name,
    l.league_name,
    f.season,
    SUM(f.goals) AS total_goals
FROM fact_player_stats f
JOIN dim_player p ON f.player_key = p.player_key
JOIN dim_league l ON f.league_key = l.league_key
GROUP BY p.player_name, l.league_name, f.season
ORDER BY total_goals DESC
LIMIT 10;
