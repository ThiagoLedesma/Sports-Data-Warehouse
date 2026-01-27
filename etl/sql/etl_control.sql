CREATE TABLE IF NOT EXISTS etl_control (
    source_name VARCHAR PRIMARY KEY,
    last_snapshot DATE
);
