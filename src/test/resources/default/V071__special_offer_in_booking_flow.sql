ALTER TABLE IF EXISTS booking_session
ADD COLUMN IF NOT EXISTS hotel_special_offer_id INTEGER REFERENCES hotel_special_offer(id);

ALTER TABLE IF EXISTS tentative_booking
ADD COLUMN IF NOT EXISTS hotel_special_offer_id INTEGER REFERENCES hotel_special_offer(id);

ALTER TABLE IF EXISTS booking
ADD COLUMN IF NOT EXISTS hotel_special_offer_id INTEGER REFERENCES hotel_special_offer(id);