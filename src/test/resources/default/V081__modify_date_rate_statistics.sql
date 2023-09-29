ALTER TABLE IF EXISTS date_rate_statistics
DROP COLUMN IF EXISTS maximum_local_rate_group_id;

ALTER TABLE IF EXISTS date_rate_statistics
DROP COLUMN IF EXISTS maximum_foreigner_rate_group_id;