CREATE TABLE IF NOT EXISTS hotel_rate_limit (
	hotel_id INTEGER PRIMARY KEY REFERENCES hotel(id),
	minimum_rate_limit NUMERIC(10, 2),
	rate_limit_type TEXT
);