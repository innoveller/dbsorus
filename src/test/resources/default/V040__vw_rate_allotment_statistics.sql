CREATE OR REPLACE VIEW public.vw_room_rate_allotment_statistics
 AS
WITH room_type_count AS (
	SELECT hotel.id, count(room_type.*) AS room_type_count
	FROM room_type
	RIGHT JOIN hotel ON hotel.id = room_type.hotel_id
	WHERE room_type.is_active = true
	GROUP BY hotel.id
),
allotment_count AS (
	SELECT hotel.id, count(rda.*) AS allotment_count
	FROM room_type_date_allotment rda
	RIGHT JOIN room_type rt ON rt.id = rda.room_type_id AND rt.is_active = true
	RIGHT JOIN hotel ON hotel.id = rt.hotel_id
	WHERE date >= now()::date
	GROUP BY hotel.id
),
rate_count AS (
	SELECT hotel.id, count(dr.*) AS rate_count
	FROM rate_group_date_rate dr
	RIGHT JOIN rate_group rg ON rg.id = dr.rate_group_id AND rg.is_active = true
	RIGHT JOIN room_type rt ON rt.id = rg.room_type_id AND rt.is_active = true
	RIGHT JOIN hotel ON hotel.id = rt.hotel_id
	WHERE date >= now()::date
	GROUP BY hotel.id
)
SELECT rtc.id AS hotel_id,
	CASE
		WHEN rtc.room_type_count IS NULL THEN 0
		ELSE rtc.room_type_count
	END room_type_count,
	CASE
		WHEN rc.rate_count IS NULL THEN 0
		ELSE rc.rate_count
	END rate_count,
	CASE
		WHEN alc.allotment_count IS NULL THEN 0
		ELSE alc.allotment_count
	END allotment_count
FROM room_type_count rtc
LEFT JOIN allotment_count alc ON alc.id = rtc.id
LEFT JOIN rate_count rc ON rc.id = rtc.id;