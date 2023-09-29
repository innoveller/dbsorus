DROP MATERIALIZED VIEW IF EXISTS public.hotel_summary;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hotel_summary
TABLESPACE pg_default
AS
 SELECT hotel.id,
    hotel.code,
    hotel.name,
    hotel.is_active AS active,
    hotel.name_mm,
    hotel.description,
    hotel.description_mm,
    hotel.amenity_codes,
    hotel.featured_amenity_codes,
    hotel.photo_url,
    hotel.banner_url,
    hotel.logo_url,
    hotel.primary_phone_number,
    hotel.secondary_phone_numbers,
    hotel.email,
    hotel.main_website,
    hotel.fax,
    hotel.address,
    hotel.address_mm,
    hotel.location_hint,
    hotel.location_hint_my,
    hotel.latitude,
    hotel.longitude,
    hotel.geohash,
    hotel.max_child_age,
    hotel.property_type,
    string_agg(DISTINCT concat(hotel_image.image_url, '>>'::text, hotel_image.priority::text), '<>'::text) AS image_urls,
    town.id AS town_id,
    town.name_en AS town_name_en,
    town.name_mm AS town_name_mm,
    town.description_en AS town_description_en,
    town.description_mm AS town_description_mm,
    town.image_url AS town_image_url,
    town.latitude AS town_latitude,
    town.longitude AS town_longitude,
    township.id AS township_id,
    township.name_en AS township_name_en,
    township.name_mm AS township_name_mm,
    township.description_en AS township_description_en,
    township.description_mm AS township_description_mm,
    township.image_url AS township_image_url,
    township.latitude AS township_latitude,
    township.longitude AS township_longitude,
    array_agg(DISTINCT hotel_to_attraction.attraction_id) AS attractions
   FROM hotel
     LEFT JOIN hotel_image ON hotel.id = hotel_image.hotel_id
     LEFT JOIN town ON town.id = hotel.town_id
     LEFT JOIN township ON township.id = hotel.township_id
     LEFT JOIN hotel_to_attraction ON hotel_to_attraction.hotel_id = hotel.id
  GROUP BY hotel.id, town.id, township.id
WITH DATA;