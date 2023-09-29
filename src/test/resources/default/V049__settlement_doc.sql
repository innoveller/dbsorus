CREATE TABLE IF NOT EXISTS settlement_doc (
	id SERIAL PRIMARY KEY,
	settlement_request_id INTEGER REFERENCES settlement_request(id),
	file_name TEXT,
	s3_key TEXT,
	uploaded_by INTEGER REFERENCES user_account(id),
	uploaded_on TIMESTAMP
);