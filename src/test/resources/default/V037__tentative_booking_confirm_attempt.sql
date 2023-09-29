DROP TABLE IF EXISTS
			booking_attempt_failed_record,
			booking_attempt_room_rate,
			booking_attempt_room,
			booking_attempt,
			booking_confirmation_attempt,
			booking_date_room_type,
			room_type_date_temp_lock,
			session;

CREATE TABLE IF NOT EXISTS tentative_booking_confirm_attempt (
	id SERIAL PRIMARY KEY,
	tentative_booking_id UUID,
	payment_id INTEGER,
	is_fully_paid BOOL,
	created_at TIMESTAMP
);