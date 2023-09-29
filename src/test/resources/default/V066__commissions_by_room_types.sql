CREATE EXTENSION IF NOT EXISTS hstore;

ALTER TABLE IF EXISTS agent_hotel_commission_version
ADD COLUMN IF NOT EXISTS commissions_by_room_types hstore;

ALTER TABLE IF EXISTS booking_room_rate
ADD COLUMN IF NOT EXISTS commissionable_amount NUMERIC(10, 2);

ALTER TABLE IF EXISTS booking_room_rate
ADD COLUMN IF NOT EXISTS commission_rate NUMERIC(10, 2);

ALTER TABLE IF EXISTS tentative_booking_room_rate
ADD COLUMN IF NOT EXISTS commissionable_amount NUMERIC(10, 2);

ALTER TABLE IF EXISTS tentative_booking_room_rate
ADD COLUMN IF NOT EXISTS commission_rate NUMERIC(10, 2);

WITH calculated_commissionable_amount AS (
	SELECT id,
		CASE
		WHEN promotion_type IS NULL THEN sell_rate
		ELSE sell_rate + applied_discount_amount
		END AS commissionable_amount
	FROM tentative_booking_room_rate
	WHERE commissionable_amount IS NULL
)
UPDATE tentative_booking_room_rate
SET commissionable_amount = cte.commissionable_amount, commission_rate = cte.commissionable_amount - net_rate
FROM calculated_commissionable_amount cte
WHERE cte.id = tentative_booking_room_rate.id;

WITH calculated_commissionable_amount AS (
	SELECT id,
		CASE
		WHEN promotion_type IS NULL THEN sell_rate
		ELSE sell_rate + applied_discount_amount
		END AS commissionable_amount
	FROM booking_room_rate
	WHERE commissionable_amount IS NULL
)
UPDATE booking_room_rate
SET commissionable_amount = cte.commissionable_amount, commission_rate = cte.commissionable_amount - net_rate
FROM calculated_commissionable_amount cte
WHERE cte.id = booking_room_rate.id;