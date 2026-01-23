-- NULLs en dimensiones
SELECT 'dim_player - NULL player_id' AS check_name, COUNT(*) AS issues
FROM dim_player
WHERE player_id IS NULL;

SELECT 'dim_team - NULL team_id' AS check_name, COUNT(*) AS issues
FROM dim_team
WHERE team_id IS NULL;

SELECT 'dim_league - NULL league_id' AS check_name, COUNT(*) AS issues
FROM dim_league
WHERE league_id IS NULL;

-- duplicados
SELECT 'dim_player - duplicated player_id' AS check_name, COUNT(*) AS issues
FROM (
    SELECT player_id
    FROM dim_player
    GROUP BY player_id
    HAVING COUNT(*) > 1
);

SELECT 'dim_team - duplicated team_id' AS check_name, COUNT(*) AS issues
FROM (
    SELECT team_id
    FROM dim_team
    GROUP BY team_id
    HAVING COUNT(*) > 1
);

-- foreign keys
SELECT 'fact_player_stats - orphan player_key' AS check_name, COUNT(*) AS issues
FROM fact_player_stats f
LEFT JOIN dim_player p
    ON f.player_key = p.player_key
WHERE p.player_key IS NULL;

SELECT 'fact_player_stats - orphan team_key' AS check_name, COUNT(*) AS issues
FROM fact_player_stats f
LEFT JOIN dim_team t
    ON f.team_key = t.team_key
WHERE t.team_key IS NULL;
