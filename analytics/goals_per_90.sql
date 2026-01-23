SELECT
    p.player_name,
    SUM(f.goals) AS goals,
    SUM(f.minutes) AS minutes,
    ROUND(SUM(f.goals) * 90.0 / NULLIF(SUM(f.minutes), 0), 2) AS goals_per_90
FROM fact_player_stats f
JOIN dim_player p ON f.player_key = p.player_key
GROUP BY p.player_name
HAVING SUM(f.minutes) >= 900
ORDER BY goals_per_90 DESC
LIMIT 10;
