CREATE OR REPLACE TABLE dim_player AS
SELECT
    row_number() OVER ()        AS player_key,
    player_id,
    player_name,
    firstname,
    lastname,
    age,
    nationality,
    height,
    weight,
    injured,

    TRUE                        AS is_current,
    current_date                AS effective_from,
    NULL                        AS effective_to

FROM staging.stg_players_clean;
