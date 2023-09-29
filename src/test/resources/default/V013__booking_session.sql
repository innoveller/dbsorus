CREATE TABLE IF NOT EXISTS booking_session(
	id uuid PRIMARY KEY,
	hotel_id integer NOT NULL references hotel,
	agent_id integer NOT NULL references agent,
	check_in_date date NOT NULL,
    check_out_date date NOT NULL,
    number_of_rooms integer not null,
    number_of_guests integer not null,
    room_selections json not null,

    created_at timestamp NOT NULL,
    updated_at timestamp
);