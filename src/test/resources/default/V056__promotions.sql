DROP TABLE IF EXISTS promotion;

CREATE TABLE IF NOT EXISTS agent_promotion (
	id SERIAL PRIMARY KEY,
	title TEXT,
	description TEXT,
	agent_id INT REFERENCES agent(id),
	hotel_id INT REFERENCES hotel(id),
	minimum_check_in_date DATE,
	maximum_check_out_date DATE,
	discount_percentage NUMERIC,
	created_by INT REFERENCES user_account(id),
	created_at TIMESTAMP,
	updated_by INT REFERENCES user_account(id),
	updated_at TIMESTAMP,
	is_active BOOL
);

CREATE TABLE IF NOT EXISTS hotel_promotion (
	id SERIAL PRIMARY KEY,
	title TEXT,
	description TEXT,
	hotel_id INT REFERENCES hotel(id),
	rate_plan_ids INT[],
	minimum_check_in_date DATE,
	maximum_check_out_date DATE,
	start_booking_date DATE,
	end_booking_date DATE,
	discount_percentage NUMERIC,
	minimum_advance_days INT,
	minimum_number_of_nights INT,
	maximum_number_of_nights INT,
	created_by INT REFERENCES user_account(id),
	created_at TIMESTAMP,
	updated_by INT REFERENCES user_account(id),
	updated_at TIMESTAMP,
    is_active BOOL
);

ALTER TABLE IF EXISTS booking_room_rate
ADD COLUMN IF NOT EXISTS agent_promotion_applied JSON;

ALTER TABLE IF EXISTS tentative_booking_room_rate
ADD COLUMN IF NOT EXISTS agent_promotion_applied JSON;

