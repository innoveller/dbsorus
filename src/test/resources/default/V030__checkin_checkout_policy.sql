ALTER TABLE IF EXISTS hotel_content
ADD COLUMN IF NOT EXISTS check_in TEXT DEFAULT '2 PM',
ADD COLUMN IF NOT EXISTS check_out TEXT DEFAULT '12 PM';