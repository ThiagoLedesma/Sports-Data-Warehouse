SELECT
    p.player_name,
    ROUND(AVG(f.rating), 2) AS avg_rating,
    COUNT(*) AS matches
FROM fact_player_stats f
JOIN dim_player p ON f.player_key = p.player_key
GROUP BY p.player_name
HAVING COUNT(*) >= 10
ORDER BY avg_rating DESC
LIMIT 10;
