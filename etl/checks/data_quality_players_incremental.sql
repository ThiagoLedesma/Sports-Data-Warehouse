-- 🔴 NULL player_id
SELECT
    'players incremental - NULL player_id' AS check_name,
    COUNT(*) AS issues
FROM staging.stg_players_incremental_clean
WHERE player_id IS NULL;

-- 🔴 Duplicated player_id
SELECT
    'players incremental - duplicated player_id' AS check_name,
    COUNT(*) AS issues
FROM (
    SELECT player_id
    FROM staging.stg_players_incremental_clean
    GROUP BY player_id
    HAVING COUNT(*) > 1
);

-- 🟡 Edad inválida
SELECT
    'players incremental - invalid age' AS check_name,
    COUNT(*) AS issues
FROM staging.stg_players_incremental_clean
WHERE age < 0 OR age > 60;

-- 🟡 Nationality NULL
SELECT
    'players incremental - NULL nationality' AS check_name,
    COUNT(*) AS issues
FROM staging.stg_players_incremental_clean
WHERE nationality IS NULL;
