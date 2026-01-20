CREATE OR REPLACE TABLE stg_players_clean AS
SELECT DISTINCT
    player_id,
    player_name,
    firstname,
    lastname,
    age,
    nationality,
    height,
    weight,
    injured
FROM stg_players;
