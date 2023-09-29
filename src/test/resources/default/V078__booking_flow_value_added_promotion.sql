ALTER TABLE IF EXISTS booking_session
RENAME COLUMN hotel_special_offer_id TO value_added_promotion_id;

ALTER TABLE IF EXISTS tentative_booking
RENAME COLUMN hotel_special_offer_id TO value_added_promotion_id;

ALTER TABLE IF EXISTS booking_revision
RENAME COLUMN hotel_special_offer_id TO value_added_promotion_id;