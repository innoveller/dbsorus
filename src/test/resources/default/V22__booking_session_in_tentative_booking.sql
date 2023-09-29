ALTER TABLE IF EXISTS tentative_booking
ADD COLUMN IF NOT EXISTS booking_session_id UUID;