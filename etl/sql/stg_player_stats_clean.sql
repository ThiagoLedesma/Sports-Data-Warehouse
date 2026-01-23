CREATE OR REPLACE TABLE stg_player_stats_clean AS
SELECT
    *,
    CASE
        WHEN minutes < 0 THEN NULL
        WHEN minutes > 130 THEN NULL
        ELSE minutes
    END AS minutes_clean
FROM stg_player_stats;
