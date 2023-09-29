CREATE TABLE IF NOT EXISTS date_rate_statistics
(
    hotel_id INTEGER REFERENCES hotel(id),
	date DATE,
	minimum_amount_for_local NUMERIC,
	maximum_amount_for_local NUMERIC,
	total_amount_for_local NUMERIC,
	minimum_amount_for_foreigner NUMERIC,
	maximum_amount_for_foreigner NUMERIC,
	total_amount_for_foreigner NUMERIC,
	PRIMARY KEY (hotel_id, date)
);

DROP VIEW IF EXISTS public.vw_date_rate_statistics;