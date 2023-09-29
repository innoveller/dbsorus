DROP VIEW IF EXISTS public.vw_room_type_availability;

ALTER TABLE IF EXISTS room_type_date_temp_lock
DROP CONSTRAINT IF EXISTS room_type_date_temp_lock_session_id_fkey;

ALTER TABLE IF EXISTS session
ALTER COLUMN id TYPE UUID USING id::UUID;

ALTER TABLE IF EXISTS room_type_date_temp_lock
ALTER COLUMN session_id TYPE UUID USING session_id::UUID;

ALTER TABLE IF EXISTS room_type_date_temp_lock
ADD CONSTRAINT room_type_date_temp_lock_session_id_fkey
FOREIGN KEY (session_id)
REFERENCES session (id);

CREATE OR REPLACE VIEW public.vw_room_type_availability
AS
    SELECT a.room_type_id,
        a.date,
        a.allotment,
        COALESCE(lt.total, 0::bigint) AS total_locked,
        COALESCE(sd.total, 0::bigint) AS total_sold,
        COALESCE(a.allotment - COALESCE(lt.total, 0::bigint) - COALESCE(sd.total, 0::bigint), 0::bigint) AS total_available
    FROM room_type_date_allotment a
    LEFT JOIN
        (
            SELECT room_type_date_temp_lock.room_type_id, room_type_date_temp_lock.date, count(*) AS total
            FROM room_type_date_temp_lock, session
            WHERE session.expiration_time > CURRENT_TIMESTAMP AND session.id = room_type_date_temp_lock.session_id
            GROUP BY room_type_date_temp_lock.room_type_id, room_type_date_temp_lock.date
        ) lt
        ON a.room_type_id = lt.room_type_id AND a.date = lt.date
    LEFT JOIN
        (
            SELECT booking_room.room_type_id, booking_room_rate.date, count(*) AS total
            FROM booking_room_rate
            LEFT JOIN booking_room ON booking_room_rate.booking_room_id = booking_room.id
            GROUP BY booking_room.room_type_id, booking_room_rate.date
        ) sd
        ON a.room_type_id = sd.room_type_id AND a.date = sd.date;


