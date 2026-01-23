SELECT
    t.team_name,
    SUM(f.goals) AS goals,
    SUM(f.assists) AS assists
FROM fact_player_stats f
JOIN dim_team t ON f.team_key = t.team_key
GROUP BY t.team_name
ORDER BY goals DESC;
