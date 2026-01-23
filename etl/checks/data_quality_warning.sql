-- reglas de negocio
SELECT 'fact_player_stats - negative goals' AS check_name, COUNT(*) AS issues
FROM fact_player_stats
WHERE goals < 0;

SELECT 'fact_player_stats - invalid minutes' AS check_name, COUNT(*) AS issues
FROM fact_player_stats
WHERE minutes < 0 OR minutes > 130;
