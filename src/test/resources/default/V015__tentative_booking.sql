CREATE TABLE IF NOT EXISTS public.booker (
    id                      serial PRIMARY KEY,
    name                    text,
    msisdn                  text,
    email                   text
);

ALTER TABLE public.guest add column if not exists msisdn text;
ALTER TABLE public.guest drop column if exists phone_number;
ALTER TABLE public.guest drop column if exists country_code;

drop table if exists tentative_booking_room_rate cascade;
drop table if exists tentative_booking_room cascade;
drop table if exists tentative_booking cascade;

CREATE TABLE IF NOT EXISTS public.tentative_booking (
    id                      uuid PRIMARY KEY,
    hotel_id                integer NOT NULL references hotel,
    agent_id                integer NOT NULL references agent,
    checkin_date            date NOT NULL,
    checkout_date           date NOT NULL,
    number_of_rooms         integer,
    number_of_guests        integer,

    primary_guest_id        integer NOT NULL references guest,
    booker_id               integer NOT NULL references booker,
    special_request         text,

    commission_rate         numeric(10,2),
    tax_rate                numeric(10,2),

    commissionable_amount   numeric(10,2),
    net_amount              numeric(10,2),
    tax_amount              numeric(10,2),
    total_amount            numeric(10,2),

    created_at              timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS public.tentative_booking_room (
    id                      uuid PRIMARY KEY,
    tentative_booking_id    uuid references tentative_booking,
    room_type_id            integer references room_type,
    rate_group_id           integer references rate_group,
    number_of_adults        integer not null,
    number_of_children      integer not null,
    number_of_extra_beds    integer not null
);

CREATE TABLE IF NOT EXISTS public.tentative_booking_room_rate (
    id                              serial PRIMARY KEY NOT NULL,
    tentative_booking_room_id       uuid references tentative_booking_room,
    date                            date,
    sell_rate                       numeric(10,2),
    sell_rate_room_charge           numeric(10,2),
    sell_rate_extra_beds_charge     numeric(10,2),
    net_rate                        numeric(10,2)
);



