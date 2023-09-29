CREATE TABLE IF NOT EXISTS booking_cancellation (
	id SERIAL PRIMARY KEY,
	booking_id UUID REFERENCES booking(id),
	reason TEXT,
	cancelled_by TEXT,
	created_by INT REFERENCES user_account(id),
	created_at TIMESTAMP
);