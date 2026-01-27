INSERT INTO staging.stg_players_clean
SELECT i.*
FROM staging.stg_players_incremental i
LEFT JOIN staging.stg_players_clean c
  ON i.player_id = c.player_id
WHERE c.player_id IS NULL;
