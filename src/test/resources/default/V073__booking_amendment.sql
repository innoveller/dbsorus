CREATE TABLE IF NOT EXISTS booking_revision (
    id UUID PRIMARY KEY,
    group_id UUID,
    check_in_date DATE,
    check_out_date DATE,
    guest_type TEXT,
    number_of_rooms INTEGER,
    number_of_guests INTEGER,
    number_of_adults INTEGER,
    number_of_children INTEGER,
    primary_guest_id INTEGER REFERENCES guest(id),
    booker_id INTEGER REFERENCES booker(id),
    special_request TEXT,
    total_amount NUMERIC,
    tax_rate NUMERIC,
    tax_amount NUMERIC,
    commissionable_amount NUMERIC,
    net_amount NUMERIC,
    commission_rate NUMERIC,
    commission_version_id INTEGER,
    hotel_special_offer_id INTEGER REFERENCES hotel_special_offer(id),
    created_at TIMESTAMP
);

ALTER TABLE IF EXISTS booking
ADD COLUMN IF NOT EXISTS group_id UUID DEFAULT (gen_random_uuid());

ALTER TABLE IF EXISTS booking
ADD COLUMN IF NOT EXISTS booking_revision_id UUID REFERENCES booking_revision(id);

ALTER TABLE IF EXISTS booking
ADD COLUMN IF NOT EXISTS status TEXT;

ALTER TABLE IF EXISTS booking
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT NOW();

ALTER TABLE IF EXISTS booking_room
ADD COLUMN IF NOT EXISTS booking_revision_id UUID REFERENCES booking_revision(id);

ALTER TABLE IF EXISTS booking_room
RENAME TO booking_revision_room;

ALTER TABLE IF EXISTS booking_room_rate
RENAME TO booking_revision_room_rate;

-- Unfortunately that PostgreSQL does not provide the IF EXISTS option for the RENAME clause.
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-column/
ALTER TABLE IF EXISTS booking_revision_room_rate
RENAME COLUMN booking_room_id TO booking_revision_room_id;

CREATE TABLE IF NOT EXISTS booking_payment(
    id SERIAL PRIMARY KEY,
    booking_id UUID REFERENCES booking(id),
    payment_id INTEGER REFERENCES payment(id)
);



INSERT INTO booking_payment(booking_id, payment_id)
	SELECT id, payment_id FROM booking;

INSERT INTO booking_revision
	SELECT gen_random_uuid(), group_id, checkin_date, checkout_date, guest_type, number_of_rooms, number_of_guests,
		   number_of_adults, number_of_children, primary_guest_id, booker_id, special_request, total_amount,
		   tax_rate, tax_amount, commissionable_amount, net_amount, commission_rate, commission_version_id, hotel_special_offer_id,
		   created_at
	FROM booking;

UPDATE booking
SET status = 'CANCELLED'
FROM booking_cancellation
WHERE booking.id = booking_cancellation.booking_id;

UPDATE booking
SET status = 'CONFIRMED'
WHERE status IS NULL;

UPDATE booking
SET booking_revision_id = booking_revision.id
FROM booking_revision
WHERE booking.group_id = booking_revision.group_id;

UPDATE booking_revision_room
SET booking_revision_id = booking.booking_revision_id
FROM booking
WHERE booking.id = booking_revision_room.booking_id;