CREATE TABLE IF NOT EXISTS agent_hotel_commission_version (
	id SERIAL PRIMARY KEY,
	agent_hotel_id INT REFERENCES agent_hotel(id),
	commission_type VARCHAR(20),
	commission_percentage NUMERIC,
	commission_flat_amount NUMERIC,
	created_at TIMESTAMP,
	created_by INT
);

COMMENT ON COLUMN agent_hotel_commission_version.commission_type IS 'FLAT type explanation -> flat amount per room selection';

-- For it contains commission percentage from hotel table
DROP MATERIALIZED VIEW IF EXISTS hotel_summary;

-- This does not contain commission percentage
CREATE MATERIALIZED VIEW IF NOT EXISTS hotel_summary AS
    SELECT hotel.id, hotel.code, hotel.name, hotel.is_active AS active, hotel.name_mm, hotel.description, hotel.description_mm,
            hotel.amenity_codes, hotel.featured_amenity_codes, hotel.photo_url, hotel.banner_url, hotel.logo_url, hotel.primary_phone_number,
            hotel.secondary_phone_numbers, hotel.email, hotel.main_website, hotel.fax, hotel.address, hotel.address_mm,
            hotel.latitude, hotel.longitude, hotel.max_child_age, hotel.property_type,
            string_agg(DISTINCT hotel_image.image_url, '<>'::text) AS image_urls,
            town.id AS town_id, town.name_en AS town_name_en, town.name_mm AS town_name_mm, town.description_en AS town_description_en,
            town.description_mm AS town_description_mm, town.image_url AS town_image_url, town.latitude AS town_latitude,
            town.longitude AS town_longitude,
            township.id AS township_id, township.name_en AS township_name_en, township.name_mm AS township_name_mm,
            township.description_en AS township_description_en, township.description_mm AS township_description_mm,
            township.image_url AS township_image_url, township.latitude AS township_latitude, township.longitude AS township_longitude,
            array_agg(DISTINCT hotel_to_attraction.attraction_id) AS attractions
    FROM hotel
    LEFT JOIN hotel_image ON hotel.id = hotel_image.hotel_id
    LEFT JOIN town ON town.id = hotel.town_id
    LEFT JOIN township ON township.id = hotel.township_id
    LEFT JOIN hotel_to_attraction ON hotel_to_attraction.hotel_id = hotel.id
    GROUP BY hotel.id, town.id, township.id
WITH DATA;

--Remove commission_percentage from hotel
ALTER TABLE IF EXISTS hotel
DROP COLUMN IF EXISTS commission_percentage;

--Remove commission_rate from agent_hotel
ALTER TABLE IF EXISTS agent_hotel
DROP COLUMN IF EXISTS commission_rate;

--Add latest commission version in agent_hotel
ALTER TABLE IF EXISTS agent_hotel
ADD COLUMN IF NOT EXISTS commission_version_id INT REFERENCES agent_hotel_commission_version(id);

--Add commission version of booking
ALTER TABLE IF EXISTS booking
ADD COLUMN IF NOT EXISTS commission_version_id INT REFERENCES agent_hotel_commission_version(id);

--Add commission version of tentative_booking
ALTER TABLE IF EXISTS tentative_booking
ADD COLUMN IF NOT EXISTS commission_version_id INT REFERENCES agent_hotel_commission_version(id);