CREATE TABLE IF NOT EXISTS hotel_blackout_dates_config
(
    hotel_id integer PRIMARY KEY references hotel,
    config_type TEXT default 'NONE'
);

ALTER TABLE IF EXISTS special_day
rename to public_holiday