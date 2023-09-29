ALTER TABLE IF EXISTS rate_group
ADD COLUMN IF NOT EXISTS template_type TEXT DEFAULT('CUSTOM');

ALTER TABLE IF EXISTS rate_group
DROP COLUMN IF EXISTS is_member;

UPDATE rate_group
SET template_type = 'EARLY_BIRD'
WHERE id = ANY(ARRAY(
	SELECT MIN(id)
	FROM rate_group
	WHERE title = 'Early Bird Rate'
	GROUP BY room_type_id
));

UPDATE rate_group
SET template_type = 'LAST_MINUTE'
WHERE id = ANY(ARRAY(
	SELECT MIN(id)
	FROM rate_group
	WHERE title = 'Last Minute Rate'
	GROUP BY room_type_id
));

UPDATE rate_group
SET template_type = 'DEFAULT'
WHERE id = ANY(ARRAY(
	SELECT MIN(id)
	FROM rate_group
	WHERE title = 'Standard Rate'
	GROUP BY room_type_id
));

DROP TABLE IF EXISTS room_type_date_rate;