CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

ALTER TABLE IF EXISTS hotel_promotion
ADD COLUMN IF NOT EXISTS group_id UUID DEFAULT uuid_generate_v4(),
ADD COLUMN IF NOT EXISTS is_updated BOOLEAN DEFAULT FALSE;
