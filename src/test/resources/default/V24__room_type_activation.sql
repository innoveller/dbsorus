ALTER TABLE IF EXISTS room_type
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;