MERGE INTO dim_player d
USING (
    SELECT DISTINCT
        player_id,
        first_name AS player_name,
        age
    FROM staging.stg_players_incremental_clean
) s
ON d.player_id = s.player_id

WHEN NOT MATCHED THEN
INSERT (
    player_id,
    player_name,
    age
)
VALUES (
    s.player_id,
    s.player_name,
    s.age
);



