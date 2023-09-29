CREATE TABLE IF NOT EXISTS help_content(
	id SERIAL PRIMARY KEY,
	key TEXT UNIQUE,
	content TEXT,
	created_by INT REFERENCES user_account(id),
	created_on TIMESTAMP
);