CREATE TABLE IF NOT EXISTS api_key(
	id SERIAL PRIMARY KEY,
	agent_id INT REFERENCES agent(id),
	description TEXT UNIQUE,
	access_key TEXT UNIQUE,
	secret_key TEXT UNIQUE,
	is_active BOOLEAN,
	generated_by_id INT REFERENCES user_account(id),
	generated_at TIMESTAMP
);