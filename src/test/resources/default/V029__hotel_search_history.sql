CREATE TABLE IF NOT EXISTS hotel_search_history (
    id SERIAL PRIMARY KEY,
    location_type TEXT,
    location_id INTEGER,
    check_in_date DATE,
    check_out_date DATE,
    number_of_rooms INTEGER,
    nationality TEXT,
    created_at TIMESTAMP
);