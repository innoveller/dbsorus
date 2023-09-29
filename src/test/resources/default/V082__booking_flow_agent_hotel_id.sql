ALTER TABLE IF EXISTS booking_session
ADD COLUMN IF NOT EXISTS agent_hotel_id INT REFERENCES agent_hotel(id);

UPDATE booking_session bs
SET agent_hotel_id = ah.id
FROM agent_hotel ah
WHERE ah.agent_id = bs.agent_id AND ah.hotel_id = bs.hotel_id;

ALTER TABLE IF EXISTS booking_session
ALTER COLUMN agent_id DROP NOT NULL;

ALTER TABLE IF EXISTS booking_session
ALTER COLUMN hotel_id DROP NOT NULL;

ALTER TABLE IF EXISTS tentative_booking
ADD COLUMN IF NOT EXISTS agent_hotel_id INT REFERENCES agent_hotel(id);

UPDATE tentative_booking bs
SET agent_hotel_id = ah.id
FROM agent_hotel ah
WHERE ah.agent_id = bs.agent_id AND ah.hotel_id = bs.hotel_id;

ALTER TABLE IF EXISTS tentative_booking
ALTER COLUMN agent_id DROP NOT NULL;

ALTER TABLE IF EXISTS tentative_booking
ALTER COLUMN hotel_id DROP NOT NULL;

ALTER TABLE IF EXISTS booking
ADD COLUMN IF NOT EXISTS agent_hotel_id INT REFERENCES agent_hotel(id);

UPDATE booking bs
SET agent_hotel_id = ah.id
FROM agent_hotel ah
WHERE ah.agent_id = bs.agent_id AND ah.hotel_id = bs.hotel_id;

ALTER TABLE IF EXISTS booking
ALTER COLUMN agent_id DROP NOT NULL;

ALTER TABLE IF EXISTS booking
ALTER COLUMN hotel_id DROP NOT NULL;