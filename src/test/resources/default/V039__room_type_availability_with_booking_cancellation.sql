CREATE OR REPLACE VIEW public.vw_room_type_availability
 AS
SELECT a.room_type_id,
    a.date,
    a.allotment,
    COALESCE(lt.total, 0::bigint) AS total_locked,
    COALESCE(sd.total, 0::bigint) AS total_sold,
    COALESCE(a.allotment - COALESCE(lt.total, 0::bigint) - COALESCE(sd.total, 0::bigint), 0::bigint) AS total_available
   FROM room_type_date_allotment a
     LEFT JOIN ( SELECT generate_series(tentative_booking.checkin_date::timestamp with time zone, (tentative_booking.checkout_date - 1)::timestamp with time zone, '1 day'::interval)::date AS date,
            tentative_booking_room.room_type_id,
            count(tentative_booking_room.room_type_id) AS total
           FROM tentative_booking
             LEFT JOIN tentative_booking_room ON tentative_booking.id = tentative_booking_room.tentative_booking_id
          WHERE tentative_booking.expiration_time > CURRENT_TIMESTAMP
          GROUP BY (generate_series(tentative_booking.checkin_date::timestamp with time zone, (tentative_booking.checkout_date - 1)::timestamp with time zone, '1 day'::interval)::date), tentative_booking_room.room_type_id) lt ON a.room_type_id = lt.room_type_id AND a.date = lt.date
     LEFT JOIN (
		 SELECT generate_series(booking.checkin_date::timestamp with time zone, (booking.checkout_date - 1)::timestamp with time zone, '1 day'::interval)::date AS date,
            booking_room.room_type_id,
            count(booking_room.room_type_id) AS total
         FROM booking
         LEFT JOIN booking_room ON booking.id = booking_room.booking_id
		 RIGHT JOIN booking_cancellation ON booking.id <> booking_cancellation.booking_id
         GROUP BY (generate_series(booking.checkin_date::timestamp with time zone, (booking.checkout_date - 1)::timestamp with time zone, '1 day'::interval)::date),
		 	booking_room.room_type_id
	 ) sd ON a.room_type_id = sd.room_type_id AND a.date = sd.date
  ORDER BY a.date;