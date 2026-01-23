SELECT
    p.player_name,
    SUM(f.minutes) AS total_minutes
FROM fact_player_stats f
JOIN dim_player p ON f.player_key = p.player_key
GROUP BY p.player_name
ORDER BY total_minutes DESC
LIMIT 10;
