CREATE TABLE IF NOT EXISTS force_logout (
    id SERIAL PRIMARY KEY,
	user_account_id INTEGER,
    has_been_logged_out BOOLEAN,
	created_at TIMESTAMP,
	updated_at TIMESTAMP
);