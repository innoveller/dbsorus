ALTER TABLE IF EXISTS tentative_booking ADD COLUMN IF NOT EXISTS number_of_adults int default 1;
ALTER TABLE IF EXISTS tentative_booking ADD COLUMN IF NOT EXISTS number_of_children int default 0;

ALTER TABLE IF EXISTS booking ADD COLUMN IF NOT EXISTS number_of_adults int default 1;
ALTER TABLE IF EXISTS booking ADD COLUMN IF NOT EXISTS number_of_children int default 0;
