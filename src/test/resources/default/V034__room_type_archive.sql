ALTER TABLE IF EXISTS room_type ADD COLUMN IF NOT EXISTS is_archived boolean default false;