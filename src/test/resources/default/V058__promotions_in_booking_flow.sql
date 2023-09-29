ALTER TABLE IF EXISTS booking_room_rate
DROP COLUMN IF EXISTS agent_promotion_applied,
ADD COLUMN IF NOT EXISTS promotion_type TEXT,
ADD COLUMN IF NOT EXISTS promotion_id INTEGER,
ADD COLUMN IF NOT EXISTS applied_discount_amount NUMERIC;

ALTER TABLE IF EXISTS tentative_booking_room_rate
DROP COLUMN IF EXISTS agent_promotion_applied,
ADD COLUMN IF NOT EXISTS promotion_type TEXT,
ADD COLUMN IF NOT EXISTS promotion_id INTEGER,
ADD COLUMN IF NOT EXISTS applied_discount_amount NUMERIC;