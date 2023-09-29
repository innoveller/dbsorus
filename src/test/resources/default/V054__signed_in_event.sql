CREATE TABLE IF NOT EXISTS system_user_role (
	user_account_id INTEGER REFERENCES user_account(id) PRIMARY KEY,
	role TEXT
);

CREATE TABLE IF NOT EXISTS signed_in_event (
	id SERIAL PRIMARY KEY,
	user_account_id INTEGER REFERENCES user_account(id),
	created_at TIMESTAMP
);