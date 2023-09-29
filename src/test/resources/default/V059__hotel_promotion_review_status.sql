ALTER TABLE IF EXISTS hotel_promotion
ADD COLUMN IF NOT EXISTS is_reviewed BOOL;

ALTER TABLE IF EXISTS hotel_promotion
ADD COLUMN IF NOT EXISTS title_my TEXT;

ALTER TABLE IF EXISTS hotel_promotion
ADD COLUMN IF NOT EXISTS description_my TEXT;

ALTER TABLE IF EXISTS hotel_promotion
RENAME COLUMN rate_plan_ids TO rate_group_ids;