ALTER TABLE IF EXISTS date_rate_statistics
ADD COLUMN IF NOT EXISTS minimum_local_rate_group_id INTEGER,
ADD COLUMN IF NOT EXISTS maximum_local_rate_group_id INTEGER,
ADD COLUMN IF NOT EXISTS minimum_foreigner_rate_group_id INTEGER,
ADD COLUMN IF NOT EXISTS maximum_foreigner_rate_group_id INTEGER;