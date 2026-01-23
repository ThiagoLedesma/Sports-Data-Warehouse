-- dim_player: NULL player_id
SELECT 'dim_player - NULL player_id' AS check_name, COUNT(*) AS issues
FROM dim_player
WHERE player_id IS NULL;

-- dim_team: NULL team_id
SELECT 'dim_team - NULL team_id' AS check_name, COUNT(*) AS issues
FROM dim_team
WHERE team_id IS NULL;

-- dim_league: NULL league_id
SELECT 'dim_league - NULL league_id' AS check_name, COUNT(*) AS issues
FROM dim_league
WHERE league_id IS NULL;

-- dim_date: NULL date_key
SELECT 'dim_date - NULL date_key' AS check_name, COUNT(*) AS issues
FROM dim_date
WHERE date_key IS NULL;

-- dim_player: duplicated player_id
SELECT 'dim_player - duplicated player_id' AS check_name, COUNT(*) AS issues
FROM (
    SELECT player_id
    FROM dim_player
    GROUP BY player_id
    HAVING COUNT(*) > 1
);

-- dim_team: duplicated team_id
SELECT 'dim_team - duplicated team_id' AS check_name, COUNT(*) AS issues
FROM (
    SELECT team_id
    FROM dim_team
    GROUP BY team_id
    HAVING COUNT(*) > 1
);

-- fact -> dim_player
SELECT 'fact_player_stats - orphan player_key' AS check_name, COUNT(*) AS issues
FROM fact_player_stats f
LEFT JOIN dim_player p
    ON f.player_key = p.player_key
WHERE p.player_key IS NULL;

-- fact -> dim_team
SELECT 'fact_player_stats - orphan team_key' AS check_name, COUNT(*) AS issues
FROM fact_player_stats f
LEFT JOIN dim_team t
    ON f.team_key = t.team_key
WHERE t.team_key IS NULL;

/*
-- fact -> dim_date
SELECT 'fact_player_stats - orphan date_key' AS check_name, COUNT(*) AS issues
FROM fact_player_stats f
LEFT JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL;
*/

-- goals negativas
SELECT 'fact_player_stats - negative goals' AS check_name, COUNT(*) AS issues
FROM fact_player_stats
WHERE goals < 0;

-- minutos inválidos (ESTE TE DIO 8)
SELECT 'fact_player_stats - invalid minutes' AS check_name, COUNT(*) AS issues
FROM fact_player_stats
WHERE minutes < 0 OR minutes > 130;
