MERGE INTO dim_player d
USING (
    SELECT
        player_id,
        player_name,
        first_name,
        last_name,
        age,
        nationality,
        snapshot_date
    FROM staging.stg_players_incremental_clean
) s
ON d.player_id = s.player_id

WHEN MATCHED
 AND s.snapshot_date > d.snapshot_date
THEN UPDATE SET
    player_name   = s.player_name,
    firstname     = s.first_name,
    lastname      = s.last_name,
    age           = s.age,
    nationality   = s.nationality,   -- ✅ ACÁ
    snapshot_date = s.snapshot_date

WHEN NOT MATCHED
THEN INSERT (
    player_id,
    player_name,
    firstname,
    lastname,
    age,
    nationality,      -- ✅ ACÁ
    snapshot_date
)
VALUES (
    s.player_id,
    s.player_name,
    s.first_name,
    s.last_name,
    s.age,
    s.nationality,
    s.snapshot_date
);
