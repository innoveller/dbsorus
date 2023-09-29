ALTER TABLE IF EXISTS agent_hotel_commission_version
ADD COLUMN IF NOT EXISTS group_id UUID;

WITH uuid_generator AS (
	SELECT DISTINCT agent_hotel_id, gen_random_uuid() AS generated_uuid
	FROM agent_hotel_commission_version
	GROUP BY agent_hotel_id
)
UPDATE agent_hotel_commission_version
SET group_id = generated_uuid
FROM uuid_generator
WHERE agent_hotel_commission_version.agent_hotel_id = uuid_generator.agent_hotel_id;

ALTER TABLE IF EXISTS agent_hotel_commission_version
DROP COLUMN IF EXISTS agent_hotel_id;