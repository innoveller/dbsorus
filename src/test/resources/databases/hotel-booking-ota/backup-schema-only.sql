--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8
-- Dumped by pg_dump version 14.8

--SET statement_timeout = 0;
--SET lock_timeout = 0;
--SET idle_in_transaction_session_timeout = 0;
--SET client_encoding = 'UTF8';
--SET standard_conforming_strings = on;
--SELECT pg_catalog.set_config('search_path', '', false);
--SET check_function_bodies = false;
--SET xmloption = content;
--SET client_min_messages = warning;
--SET row_security = off;

--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: transaction_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.transaction_type AS ENUM (
    'deposit',
    'booking',
    'commission'
);


--SET default_table_access_method = heap;

--
-- Name: addon_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addon_type (
    id integer NOT NULL,
    hotel_id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL
);


--
-- Name: addon_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.addon_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addon_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.addon_type_id_seq OWNED BY public.addon_type.id;


--
-- Name: agent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent (
    id integer NOT NULL,
    name text,
    domain text,
    description text,
    creator_id integer,
    modifier_id integer,
    created_date timestamp without time zone,
    modified_date timestamp without time zone,
    api_key text,
    tax_percentage numeric(4,2) DEFAULT 2.0
);


--
-- Name: agent_balance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_balance (
    agent_id integer NOT NULL,
    balance numeric(20,10),
    modified_date timestamp without time zone
);


--
-- Name: agent_balance_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_balance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_balance_id_seq OWNED BY public.agent_balance.agent_id;


--
-- Name: agent_hotel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_hotel (
    id integer NOT NULL,
    agent_id integer,
    hotel_id integer,
    commission_version_id integer,
    contract_expiration_date date
);


--
-- Name: agent_hotel_commission_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_hotel_commission_version (
    id integer NOT NULL,
    commission_type character varying(20),
    commission_percentage numeric,
    commission_flat_amount numeric,
    created_at timestamp without time zone,
    created_by integer,
    commissions_by_room_types public.hstore,
    group_id uuid
);


--
-- Name: agent_hotel_commission_version_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_hotel_commission_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_hotel_commission_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_hotel_commission_version_id_seq OWNED BY public.agent_hotel_commission_version.id;


--
-- Name: agent_hotel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_hotel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_hotel_id_seq OWNED BY public.agent_hotel.id;


--
-- Name: agent_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_id_seq OWNED BY public.agent.id;


--
-- Name: agent_promotion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_promotion (
    id integer NOT NULL,
    title text,
    description text,
    agent_id integer,
    hotel_id integer,
    minimum_check_in_date date,
    maximum_check_out_date date,
    discount_percentage numeric,
    created_by integer,
    created_at timestamp without time zone,
    updated_by integer,
    updated_at timestamp without time zone,
    is_active boolean,
    is_reviewed boolean DEFAULT true,
    title_my text,
    description_my text,
    group_id uuid DEFAULT public.uuid_generate_v4(),
    is_updated boolean DEFAULT false
);


--
-- Name: agent_promotion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_promotion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_promotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_promotion_id_seq OWNED BY public.agent_promotion.id;


--
-- Name: agent_transaction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_transaction (
    id integer NOT NULL,
    agent_id integer,
    debit_amount numeric(10,2),
    credit_amount numeric(10,2),
    created_date timestamp without time zone,
    description text,
    type public.transaction_type
);


--
-- Name: agent_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_transaction_id_seq OWNED BY public.agent_transaction.id;


--
-- Name: api_key; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_key (
    id integer NOT NULL,
    agent_id integer,
    description text,
    access_key text,
    secret_key text,
    is_active boolean,
    generated_by_id integer,
    generated_at timestamp without time zone
);


--
-- Name: api_key_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.api_key_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.api_key_id_seq OWNED BY public.api_key.id;


--
-- Name: array_testing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.array_testing (
    id integer NOT NULL,
    name text[],
    test text,
    flyway_testing character varying
);


--
-- Name: array_testing_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.array_testing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: array_testing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.array_testing_id_seq OWNED BY public.array_testing.id;


--
-- Name: attraction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attraction (
    id integer NOT NULL,
    name_en text,
    name_mm text,
    description_en text,
    description_mm text,
    image_url text,
    town_id integer,
    distance_from_town text,
    latitude double precision,
    longitude double precision,
    name_mm_soundex text,
    geohash text,
    adjacent_geohashes_csv text
);


--
-- Name: attraction_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attraction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attraction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attraction_id_seq OWNED BY public.attraction.id;


--
-- Name: bank; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bank (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    short_name character varying(10)
);


--
-- Name: bank_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bank_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bank_id_seq OWNED BY public.bank.id;


--
-- Name: bed_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bed_type (
    id integer NOT NULL,
    bed_type character varying(100)
);


--
-- Name: bed_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bed_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bed_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bed_type_id_seq OWNED BY public.bed_type.id;


--
-- Name: booker; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booker (
    id integer NOT NULL,
    name text,
    msisdn text,
    email text
);


--
-- Name: booker_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booker_id_seq OWNED BY public.booker.id;


--
-- Name: booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking (
    id uuid NOT NULL,
    reference text NOT NULL,
    hotel_id integer,
    agent_id integer,
    checkin_date date,
    checkout_date date,
    number_of_rooms integer,
    number_of_guests integer,
    primary_guest_id integer,
    booker_id integer,
    special_request text,
    commission_rate numeric(10,2),
    tax_rate numeric(10,2),
    commissionable_amount numeric(10,2),
    net_amount numeric(10,2),
    tax_amount numeric(10,2),
    total_amount numeric(10,2),
    payment_id integer,
    is_fully_paid boolean,
    created_at timestamp without time zone NOT NULL,
    commission_version_id integer,
    tentative_booking_id uuid,
    guest_type text DEFAULT 'LOCAL'::text,
    number_of_adults integer DEFAULT 1,
    number_of_children integer DEFAULT 0,
    hotel_special_offer_id integer,
    group_id uuid DEFAULT gen_random_uuid(),
    booking_revision_id uuid,
    status text,
    updated_at timestamp without time zone DEFAULT now(),
    updated_by integer,
    agent_hotel_id integer
);


--
-- Name: booking_cancellation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_cancellation (
    id integer NOT NULL,
    booking_id uuid,
    reason text,
    cancelled_by text,
    created_by integer,
    created_at timestamp without time zone
);


--
-- Name: booking_cancellation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_cancellation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booking_cancellation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_cancellation_id_seq OWNED BY public.booking_cancellation.id;


--
-- Name: booking_payment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_payment (
    id integer NOT NULL,
    booking_id uuid,
    payment_id integer
);


--
-- Name: booking_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booking_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_payment_id_seq OWNED BY public.booking_payment.id;


--
-- Name: booking_revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_revision (
    id uuid NOT NULL,
    group_id uuid,
    check_in_date date,
    check_out_date date,
    guest_type text,
    number_of_rooms integer,
    number_of_guests integer,
    number_of_adults integer,
    number_of_children integer,
    primary_guest_id integer,
    booker_id integer,
    special_request text,
    total_amount numeric,
    tax_rate numeric,
    tax_amount numeric,
    commissionable_amount numeric,
    net_amount numeric,
    commission_rate numeric,
    commission_version_id integer,
    value_added_promotion_id integer,
    created_at timestamp without time zone
);


--
-- Name: booking_revision_room; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_revision_room (
    id uuid NOT NULL,
    booking_id uuid,
    room_type_id integer,
    rate_group_id integer,
    number_of_adults integer NOT NULL,
    number_of_children integer NOT NULL,
    number_of_extra_beds integer NOT NULL,
    booking_revision_id uuid
);


--
-- Name: booking_revision_room_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_revision_room_rate (
    id integer NOT NULL,
    booking_revision_room_id uuid,
    date date,
    sell_rate numeric(10,2),
    sell_rate_room_charge numeric(10,2),
    sell_rate_extra_beds_charge numeric(10,2),
    net_rate numeric(10,2),
    promotion_type text,
    promotion_id integer,
    applied_discount_amount numeric,
    commissionable_amount numeric(10,2),
    commission_rate numeric(10,2)
);


--
-- Name: booking_room_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_room_rate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booking_room_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_room_rate_id_seq OWNED BY public.booking_revision_room_rate.id;


--
-- Name: booking_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_session (
    id uuid NOT NULL,
    hotel_id integer,
    agent_id integer,
    check_in_date date NOT NULL,
    check_out_date date NOT NULL,
    number_of_rooms integer NOT NULL,
    number_of_guests integer NOT NULL,
    room_selections json NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    guest_type text DEFAULT 'LOCAL'::text,
    value_added_promotion_id integer,
    agent_hotel_id integer
);


--
-- Name: date_rate_statistics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.date_rate_statistics (
    hotel_id integer NOT NULL,
    date date NOT NULL,
    minimum_amount_for_local numeric,
    maximum_amount_for_local numeric,
    total_amount_for_local numeric,
    minimum_amount_for_foreigner numeric,
    maximum_amount_for_foreigner numeric,
    total_amount_for_foreigner numeric,
    minimum_local_rate_group_id integer,
    minimum_foreigner_rate_group_id integer
);


--
-- Name: financial_institution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.financial_institution (
    financial_institution_id integer NOT NULL,
    institution_type text NOT NULL,
    name text NOT NULL,
    abbreviation text
);


--
-- Name: financial_institution_financial_institution_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.financial_institution_financial_institution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: financial_institution_financial_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.financial_institution_financial_institution_id_seq OWNED BY public.financial_institution.financial_institution_id;


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- Name: force_logout; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.force_logout (
    id integer NOT NULL,
    user_account_id integer,
    has_been_logged_out boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: force_logout_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.force_logout_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: force_logout_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.force_logout_id_seq OWNED BY public.force_logout.id;


--
-- Name: gateway_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gateway_type (
    id integer NOT NULL,
    name text NOT NULL,
    code text
);


--
-- Name: gateway_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gateway_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gateway_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gateway_type_id_seq OWNED BY public.gateway_type.id;


--
-- Name: guest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guest (
    id integer NOT NULL,
    name text,
    gender character varying(10),
    nationality character varying(50),
    msisdn text,
    email text
);


--
-- Name: guest_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.guest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.guest_id_seq OWNED BY public.guest.id;


--
-- Name: help_content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.help_content (
    id integer NOT NULL,
    key text,
    content text,
    created_by integer,
    created_on timestamp without time zone
);


--
-- Name: help_content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.help_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: help_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.help_content_id_seq OWNED BY public.help_content.id;


--
-- Name: hotel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel (
    id integer NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    description text,
    logo_url text,
    address text NOT NULL,
    email text,
    fax text,
    primary_phone_number text,
    banner_url text,
    theme text,
    photo_url text,
    main_website text,
    town_id integer,
    is_active boolean,
    amenity_codes text[],
    latitude double precision,
    longitude double precision,
    township_id integer,
    max_child_age integer,
    name_mm text,
    description_mm text,
    address_mm text,
    featured_amenity_codes text[],
    created_by integer,
    created_on timestamp without time zone,
    secondary_phone_numbers text,
    property_type character varying(20),
    is_tax_excluded boolean,
    is_partial_payment_allowed boolean,
    oidc_org_id uuid,
    location_hint text,
    location_hint_my text,
    geohash text,
    status_details text DEFAULT ''::text,
    is_archived boolean DEFAULT false
);


--
-- Name: hotel_amenity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_amenity (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    label_en character varying(200) NOT NULL,
    icon text,
    label_my text
);


--
-- Name: hotel_amenity_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_amenity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_amenity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_amenity_id_seq OWNED BY public.hotel_amenity.id;


--
-- Name: hotel_blackout_dates_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_blackout_dates_config (
    hotel_id integer NOT NULL,
    config_type text DEFAULT 'NONE'::text
);


--
-- Name: hotel_contact_person; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_contact_person (
    id integer NOT NULL,
    hotel_id integer,
    name text,
    designation text,
    nrc_number text,
    phone_number text,
    email text,
    address text
);


--
-- Name: hotel_contact_person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_contact_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_contact_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_contact_person_id_seq OWNED BY public.hotel_contact_person.id;


--
-- Name: hotel_content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_content (
    hotel_id integer NOT NULL,
    language text NOT NULL,
    terms text,
    policy text,
    cancellation text,
    child_policy text,
    check_in text DEFAULT '2 PM'::text,
    check_out text DEFAULT '12 PM'::text,
    check_in_details text DEFAULT ''::text,
    check_out_details text DEFAULT ''::text
);


--
-- Name: hotel_content_hotel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_content_hotel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_content_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_content_hotel_id_seq OWNED BY public.hotel_content.hotel_id;


--
-- Name: hotel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_id_seq OWNED BY public.hotel.id;


--
-- Name: hotel_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_image (
    id integer NOT NULL,
    hotel_id integer NOT NULL,
    priority integer,
    image_url text NOT NULL
);


--
-- Name: hotel_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_image_id_seq OWNED BY public.hotel_image.id;


--
-- Name: hotel_initial_approval; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_initial_approval (
    hotel_id integer NOT NULL,
    super_admin_id integer,
    approved_on timestamp without time zone
);


--
-- Name: hotel_notification_subscriber; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_notification_subscriber (
    hotel_notification_subscriber_id integer NOT NULL,
    hotel_id integer,
    email text NOT NULL,
    display_name text NOT NULL,
    created_by integer,
    created_at timestamp without time zone,
    updated_by integer,
    updated_at timestamp without time zone
);


--
-- Name: hotel_notification_subscriber_hotel_notification_subscriber_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_notification_subscriber_hotel_notification_subscriber_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_notification_subscriber_hotel_notification_subscriber_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_notification_subscriber_hotel_notification_subscriber_seq OWNED BY public.hotel_notification_subscriber.hotel_notification_subscriber_id;


--
-- Name: hotel_payment_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_payment_account (
    hotel_payment_account_id integer NOT NULL,
    hotel_id integer,
    account_type text NOT NULL,
    account_holder_name character varying(100),
    account_number character varying(50),
    financial_institution_id integer,
    branch_name text,
    created_by integer,
    created_on timestamp without time zone,
    updated_by integer,
    updated_on timestamp without time zone,
    account_holder_contact text
);


--
-- Name: hotel_payment_account_approval; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_payment_account_approval (
    hotel_payment_account_id integer NOT NULL,
    approved_by integer NOT NULL,
    approved_on timestamp without time zone
);


--
-- Name: hotel_payment_account_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_payment_account_doc (
    hotel_payment_account_doc_id integer NOT NULL,
    hotel_payment_account_id integer,
    file_name text,
    s3_key text,
    created_by integer,
    created_on timestamp without time zone
);


--
-- Name: hotel_payment_account_doc_hotel_payment_account_doc_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_payment_account_doc_hotel_payment_account_doc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_payment_account_doc_hotel_payment_account_doc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_payment_account_doc_hotel_payment_account_doc_id_seq OWNED BY public.hotel_payment_account_doc.hotel_payment_account_doc_id;


--
-- Name: hotel_payment_account_hotel_payment_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_payment_account_hotel_payment_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_payment_account_hotel_payment_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_payment_account_hotel_payment_account_id_seq OWNED BY public.hotel_payment_account.hotel_payment_account_id;


--
-- Name: hotel_promotion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_promotion (
    id integer NOT NULL,
    title text,
    description text,
    hotel_id integer,
    rate_group_ids integer[],
    minimum_check_in_date date,
    maximum_check_out_date date,
    start_booking_date date,
    end_booking_date date,
    discount_percentage numeric,
    minimum_advance_days integer,
    minimum_number_of_nights integer,
    maximum_number_of_nights integer,
    created_by integer,
    created_at timestamp without time zone,
    updated_by integer,
    updated_at timestamp without time zone,
    is_active boolean,
    is_reviewed boolean,
    title_my text,
    description_my text,
    group_id uuid DEFAULT public.uuid_generate_v4(),
    is_updated boolean DEFAULT false
);


--
-- Name: hotel_promotion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_promotion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_promotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_promotion_id_seq OWNED BY public.hotel_promotion.id;


--
-- Name: hotel_rate_limit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_rate_limit (
    hotel_id integer NOT NULL,
    minimum_rate_limit numeric(10,2),
    rate_limit_type text
);


--
-- Name: hotel_search_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_search_history (
    id integer NOT NULL,
    location_type text,
    location_id integer,
    check_in_date date,
    check_out_date date,
    number_of_rooms integer,
    nationality text,
    created_at timestamp without time zone
);


--
-- Name: hotel_search_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_search_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_search_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_search_history_id_seq OWNED BY public.hotel_search_history.id;


--
-- Name: value_added_promotion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.value_added_promotion (
    id integer NOT NULL,
    hotel_id integer,
    title text,
    description text,
    minimum_check_in_date date,
    maximum_check_out_date date,
    start_booking_date date,
    end_booking_date date,
    is_active boolean,
    is_reviewed boolean,
    short_message_en text,
    short_message_my text,
    full_message_en text,
    full_message_my text,
    applied_room_type_ids integer[],
    messages_by_room_types json,
    created_by integer,
    created_at timestamp without time zone,
    updated_by integer,
    updated_at timestamp without time zone,
    group_id uuid DEFAULT public.uuid_generate_v4(),
    is_updated boolean DEFAULT false
);


--
-- Name: hotel_special_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_special_offer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_special_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_special_offer_id_seq OWNED BY public.value_added_promotion.id;


--
-- Name: hotel_to_attraction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_to_attraction (
    id integer NOT NULL,
    hotel_id integer,
    attraction_id integer,
    distance_between text
);


--
-- Name: hotel_to_attraction_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_to_attraction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_to_attraction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_to_attraction_id_seq OWNED BY public.hotel_to_attraction.id;


--
-- Name: hotel_user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_user_role (
    hotel_id integer NOT NULL,
    user_id integer NOT NULL,
    role character varying(50) NOT NULL
);


--
-- Name: message; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message (
    id integer NOT NULL,
    parent_message_id integer,
    message text NOT NULL,
    message_type character varying(15) NOT NULL,
    hotel_id integer,
    creator_id integer NOT NULL,
    creator_type character varying(20) NOT NULL,
    sent_on timestamp without time zone,
    booking_id integer,
    extra_url text
);


--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.message.id;


--
-- Name: message_read; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message_read (
    id integer NOT NULL,
    message_id integer,
    hotel_id integer,
    reader_id integer NOT NULL,
    read_on timestamp without time zone,
    reader_type character varying(20) NOT NULL
);


--
-- Name: message_read_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.message_read_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: message_read_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.message_read_id_seq OWNED BY public.message_read.id;


--
-- Name: payment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment (
    id integer NOT NULL,
    payment_method_code text NOT NULL,
    currency text NOT NULL,
    amount numeric(10,2),
    transaction_reference text NOT NULL,
    memo text,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: payment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;


--
-- Name: payment_migs_gateway; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_migs_gateway (
    hotel_id integer NOT NULL,
    merchant_code text NOT NULL,
    access_code text NOT NULL,
    secrect_key text NOT NULL
);


--
-- Name: public_holiday; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.public_holiday (
    id integer NOT NULL,
    date date,
    description_en text,
    description_my text
);


--
-- Name: rate_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_group (
    id integer NOT NULL,
    guest_type character varying(100) NOT NULL,
    room_type_id integer,
    minimum_advance_days integer,
    maximum_advance_days integer,
    title text,
    currency character varying(5),
    is_active boolean,
    based_on_plan_id integer,
    additional_percentage numeric(4,2),
    description text,
    dependent_rate_type character varying(20),
    additional_flat_amount numeric(10,2),
    template_type text DEFAULT 'CUSTOM'::text
);


--
-- Name: rate_group_date_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_group_date_rate (
    rate_group_id integer NOT NULL,
    date date NOT NULL,
    rate numeric(10,2)
);


--
-- Name: rate_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rate_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rate_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rate_group_id_seq OWNED BY public.rate_group.id;


--
-- Name: rate_message; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_message (
    id integer NOT NULL,
    message text NOT NULL
);


--
-- Name: rate_message_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rate_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rate_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rate_message_id_seq OWNED BY public.rate_message.id;


--
-- Name: reference_block_starter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reference_block_starter (
    id integer DEFAULT 1 NOT NULL,
    next_block_first_value integer,
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT single_row_table CHECK ((id = 1))
);


--
-- Name: room_bed_count; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_bed_count (
    room_type_id integer,
    bed_type_id integer,
    number_of_bed integer
);


--
-- Name: room_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type (
    id integer NOT NULL,
    hotel_id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    max_adults_without_extra_bed integer,
    max_guests_without_extra_bed integer,
    max_adults_with_extra_bed integer,
    max_guests_with_extra_bed integer,
    number_of_extra_bed integer,
    facility_codes text[],
    name_mm text,
    description_mm text,
    number_of_room integer,
    is_active boolean DEFAULT true,
    is_archived boolean DEFAULT false,
    priority integer DEFAULT '-1'::integer
);


--
-- Name: room_type_date_allotment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_date_allotment (
    room_type_id integer NOT NULL,
    date date NOT NULL,
    allotment integer NOT NULL
);


--
-- Name: room_type_extra_bed_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_extra_bed_rate (
    room_type_id integer NOT NULL,
    rate numeric(10,2),
    rate_group_id integer
);


--
-- Name: room_type_facility; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_facility (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    label_en character varying(200) NOT NULL,
    icon_url character varying(100),
    icon text,
    label_my text
);


--
-- Name: room_type_facility_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.room_type_facility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: room_type_facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_type_facility_id_seq OWNED BY public.room_type_facility.id;


--
-- Name: room_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.room_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: room_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_type_id_seq OWNED BY public.room_type.id;


--
-- Name: room_type_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_image (
    id integer NOT NULL,
    room_type_id integer NOT NULL,
    priority integer,
    image_url text NOT NULL
);


--
-- Name: room_type_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.room_type_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: room_type_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_type_image_id_seq OWNED BY public.room_type_image.id;


--
-- Name: room_type_promotion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_promotion (
    room_type_id integer NOT NULL,
    promotion_id integer NOT NULL
);


--
-- Name: settlement_booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settlement_booking (
    settlement_request_id integer NOT NULL,
    booking_id uuid NOT NULL
);


--
-- Name: settlement_confirmation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settlement_confirmation (
    id integer NOT NULL,
    settlement_request_id integer,
    modifier_id integer,
    modified_date_time timestamp without time zone,
    status character varying(50)
);


--
-- Name: settlement_confirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settlement_confirmation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settlement_confirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settlement_confirmation_id_seq OWNED BY public.settlement_confirmation.id;


--
-- Name: settlement_doc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settlement_doc (
    id integer NOT NULL,
    settlement_request_id integer,
    file_name text,
    s3_key text,
    uploaded_by integer,
    uploaded_on timestamp without time zone
);


--
-- Name: settlement_doc_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settlement_doc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settlement_doc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settlement_doc_id_seq OWNED BY public.settlement_doc.id;


--
-- Name: settlement_request; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settlement_request (
    id integer NOT NULL,
    reference_number character varying(20),
    creator_id integer,
    hotel_id integer,
    number_of_booking integer,
    total_amount numeric(10,2),
    created_date_time timestamp without time zone,
    hotel_payment_account_id integer
);


--
-- Name: settlement_request_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settlement_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settlement_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settlement_request_id_seq OWNED BY public.settlement_request.id;


--
-- Name: signed_in_event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.signed_in_event (
    id integer NOT NULL,
    user_account_id integer,
    created_at timestamp without time zone
);


--
-- Name: signed_in_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.signed_in_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: signed_in_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.signed_in_event_id_seq OWNED BY public.signed_in_event.id;


--
-- Name: special_day_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.special_day_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: special_day_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.special_day_id_seq OWNED BY public.public_holiday.id;


--
-- Name: support_team; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.support_team (
    id integer NOT NULL,
    address text DEFAULT 'Pyay Rd 270, 1B Sanchaung Yangon MM 11111, Pyay Rd, Yangon'::text,
    phone_number text DEFAULT '09 42197 3663'::text
);


--
-- Name: support_team_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.support_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: support_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.support_team_id_seq OWNED BY public.support_team.id;


--
-- Name: system_user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_user_role (
    user_account_id integer NOT NULL,
    role text
);


--
-- Name: tentative_booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tentative_booking (
    id uuid NOT NULL,
    hotel_id integer,
    agent_id integer,
    checkin_date date NOT NULL,
    checkout_date date NOT NULL,
    number_of_rooms integer,
    number_of_guests integer,
    primary_guest_id integer NOT NULL,
    booker_id integer NOT NULL,
    special_request text,
    commission_rate numeric(10,2),
    tax_rate numeric(10,2),
    commissionable_amount numeric(10,2),
    net_amount numeric(10,2),
    tax_amount numeric(10,2),
    total_amount numeric(10,2),
    created_at timestamp without time zone NOT NULL,
    expiration_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    booking_session_id uuid,
    commission_version_id integer,
    guest_type text DEFAULT 'LOCAL'::text,
    number_of_adults integer DEFAULT 1,
    number_of_children integer DEFAULT 0,
    value_added_promotion_id integer,
    agent_hotel_id integer
);


--
-- Name: tentative_booking_confirm_attempt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tentative_booking_confirm_attempt (
    id integer NOT NULL,
    tentative_booking_id uuid,
    payment_id integer,
    is_fully_paid boolean,
    created_at timestamp without time zone
);


--
-- Name: tentative_booking_confirm_attempt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tentative_booking_confirm_attempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tentative_booking_confirm_attempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tentative_booking_confirm_attempt_id_seq OWNED BY public.tentative_booking_confirm_attempt.id;


--
-- Name: tentative_booking_room; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tentative_booking_room (
    id uuid NOT NULL,
    tentative_booking_id uuid,
    room_type_id integer,
    rate_group_id integer,
    number_of_adults integer NOT NULL,
    number_of_children integer NOT NULL,
    number_of_extra_beds integer NOT NULL
);


--
-- Name: tentative_booking_room_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tentative_booking_room_rate (
    id integer NOT NULL,
    tentative_booking_room_id uuid,
    date date,
    sell_rate numeric(10,2),
    sell_rate_room_charge numeric(10,2),
    sell_rate_extra_beds_charge numeric(10,2),
    net_rate numeric(10,2),
    promotion_type text,
    promotion_id integer,
    applied_discount_amount numeric,
    commissionable_amount numeric(10,2),
    commission_rate numeric(10,2)
);


--
-- Name: tentative_booking_room_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tentative_booking_room_rate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tentative_booking_room_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tentative_booking_room_rate_id_seq OWNED BY public.tentative_booking_room_rate.id;


--
-- Name: town; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.town (
    id integer NOT NULL,
    name_en text,
    name_mm text,
    description_en text,
    description_mm text,
    image_url text,
    latitude double precision,
    longitude double precision,
    name_mm_soundex text
);


--
-- Name: town_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.town_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: town_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.town_id_seq OWNED BY public.town.id;


--
-- Name: township; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.township (
    id integer NOT NULL,
    name_en text,
    name_mm text,
    description_en text,
    description_mm text,
    image_url text,
    town_id integer,
    latitude double precision,
    longitude double precision,
    name_mm_soundex text
);


--
-- Name: township_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.township_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: township_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.township_id_seq OWNED BY public.township.id;


--
-- Name: user_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_account (
    id integer NOT NULL,
    email text NOT NULL,
    display_name text NOT NULL,
    is_system_user boolean,
    is_active boolean,
    preferred_language character varying(7),
    oidc_id uuid,
    oidc_version text DEFAULT 'To be updated'::text,
    get_notified boolean DEFAULT false
);


--
-- Name: user_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_account_id_seq OWNED BY public.user_account.id;


--
-- Name: user_activity_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_activity_log (
    id integer NOT NULL,
    hotel_id integer NOT NULL,
    user_id integer NOT NULL,
    message text,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: user_activity_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_activity_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_activity_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_activity_log_id_seq OWNED BY public.user_activity_log.id;


--
-- Name: vw_room_rate_allotment_statistics; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_room_rate_allotment_statistics AS
 WITH room_type_count AS (
         SELECT hotel.id,
            count(room_type.*) AS room_type_count
           FROM (public.room_type
             RIGHT JOIN public.hotel ON ((hotel.id = room_type.hotel_id)))
          WHERE (room_type.is_active = true)
          GROUP BY hotel.id
        ), allotment_count AS (
         SELECT hotel.id,
            count(rda.*) AS allotment_count
           FROM ((public.room_type_date_allotment rda
             RIGHT JOIN public.room_type rt ON (((rt.id = rda.room_type_id) AND (rt.is_active = true))))
             RIGHT JOIN public.hotel ON ((hotel.id = rt.hotel_id)))
          WHERE (rda.date >= (now())::date)
          GROUP BY hotel.id
        ), rate_count AS (
         SELECT hotel.id,
            count(dr.*) AS rate_count
           FROM (((public.rate_group_date_rate dr
             RIGHT JOIN public.rate_group rg ON (((rg.id = dr.rate_group_id) AND (rg.is_active = true))))
             RIGHT JOIN public.room_type rt ON (((rt.id = rg.room_type_id) AND (rt.is_active = true))))
             RIGHT JOIN public.hotel ON ((hotel.id = rt.hotel_id)))
          WHERE (dr.date >= (now())::date)
          GROUP BY hotel.id
        )
 SELECT rtc.id AS hotel_id,
        CASE
            WHEN (rtc.room_type_count IS NULL) THEN (0)::bigint
            ELSE rtc.room_type_count
        END AS room_type_count,
        CASE
            WHEN (rc.rate_count IS NULL) THEN (0)::bigint
            ELSE rc.rate_count
        END AS rate_count,
        CASE
            WHEN (alc.allotment_count IS NULL) THEN (0)::bigint
            ELSE alc.allotment_count
        END AS allotment_count
   FROM ((room_type_count rtc
     LEFT JOIN allotment_count alc ON ((alc.id = rtc.id)))
     LEFT JOIN rate_count rc ON ((rc.id = rtc.id)));


--
-- Name: vw_room_type_availability; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_room_type_availability AS
 SELECT a.room_type_id,
    room_type.hotel_id,
    room_type.max_adults_without_extra_bed AS number_of_guests_allowed,
    room_type.is_active,
    a.date,
    a.allotment,
    COALESCE(lt.total, (0)::bigint) AS total_locked,
    COALESCE(sd.total, (0)::bigint) AS total_sold,
    COALESCE(((a.allotment - COALESCE(lt.total, (0)::bigint)) - COALESCE(sd.total, (0)::bigint)), (0)::bigint) AS total_available
   FROM (((public.room_type_date_allotment a
     LEFT JOIN ( SELECT (generate_series((tentative_booking.checkin_date)::timestamp with time zone, ((tentative_booking.checkout_date - 1))::timestamp with time zone, '1 day'::interval))::date AS date,
            tentative_booking_room.room_type_id,
            count(tentative_booking_room.room_type_id) AS total
           FROM (public.tentative_booking
             LEFT JOIN public.tentative_booking_room ON ((tentative_booking.id = tentative_booking_room.tentative_booking_id)))
          WHERE (tentative_booking.expiration_time > CURRENT_TIMESTAMP)
          GROUP BY ((generate_series((tentative_booking.checkin_date)::timestamp with time zone, ((tentative_booking.checkout_date - 1))::timestamp with time zone, '1 day'::interval))::date), tentative_booking_room.room_type_id) lt ON (((a.room_type_id = lt.room_type_id) AND (a.date = lt.date))))
     LEFT JOIN ( SELECT (generate_series((booking_revision.check_in_date)::timestamp with time zone, ((booking_revision.check_out_date - 1))::timestamp with time zone, '1 day'::interval))::date AS date,
            booking_revision_room.room_type_id,
            count(booking_revision_room.room_type_id) AS total
           FROM (((public.booking
             LEFT JOIN public.booking_revision ON ((booking.booking_revision_id = booking_revision.id)))
             LEFT JOIN public.booking_revision_room ON ((booking_revision.id = booking_revision_room.booking_revision_id)))
             LEFT JOIN public.booking_cancellation ON ((booking.id = booking_cancellation.booking_id)))
          WHERE (booking_cancellation.id IS NULL)
          GROUP BY ((generate_series((booking_revision.check_in_date)::timestamp with time zone, ((booking_revision.check_out_date - 1))::timestamp with time zone, '1 day'::interval))::date), booking_revision_room.room_type_id) sd ON (((a.room_type_id = sd.room_type_id) AND (a.date = sd.date))))
     LEFT JOIN public.room_type ON ((room_type.id = a.room_type_id)))
  ORDER BY a.date;


--
-- Name: addon_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addon_type ALTER COLUMN id SET DEFAULT nextval('public.addon_type_id_seq'::regclass);


--
-- Name: agent id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent ALTER COLUMN id SET DEFAULT nextval('public.agent_id_seq'::regclass);


--
-- Name: agent_balance agent_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_balance ALTER COLUMN agent_id SET DEFAULT nextval('public.agent_balance_id_seq'::regclass);


--
-- Name: agent_hotel id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel ALTER COLUMN id SET DEFAULT nextval('public.agent_hotel_id_seq'::regclass);


--
-- Name: agent_hotel_commission_version id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel_commission_version ALTER COLUMN id SET DEFAULT nextval('public.agent_hotel_commission_version_id_seq'::regclass);


--
-- Name: agent_promotion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_promotion ALTER COLUMN id SET DEFAULT nextval('public.agent_promotion_id_seq'::regclass);


--
-- Name: agent_transaction id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_transaction ALTER COLUMN id SET DEFAULT nextval('public.agent_transaction_id_seq'::regclass);


--
-- Name: api_key id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_key ALTER COLUMN id SET DEFAULT nextval('public.api_key_id_seq'::regclass);


--
-- Name: array_testing id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.array_testing ALTER COLUMN id SET DEFAULT nextval('public.array_testing_id_seq'::regclass);


--
-- Name: attraction id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attraction ALTER COLUMN id SET DEFAULT nextval('public.attraction_id_seq'::regclass);


--
-- Name: bank id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank ALTER COLUMN id SET DEFAULT nextval('public.bank_id_seq'::regclass);


--
-- Name: bed_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bed_type ALTER COLUMN id SET DEFAULT nextval('public.bed_type_id_seq'::regclass);


--
-- Name: booker id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booker ALTER COLUMN id SET DEFAULT nextval('public.booker_id_seq'::regclass);


--
-- Name: booking_cancellation id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_cancellation ALTER COLUMN id SET DEFAULT nextval('public.booking_cancellation_id_seq'::regclass);


--
-- Name: booking_payment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_payment ALTER COLUMN id SET DEFAULT nextval('public.booking_payment_id_seq'::regclass);


--
-- Name: booking_revision_room_rate id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision_room_rate ALTER COLUMN id SET DEFAULT nextval('public.booking_room_rate_id_seq'::regclass);


--
-- Name: financial_institution financial_institution_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.financial_institution ALTER COLUMN financial_institution_id SET DEFAULT nextval('public.financial_institution_financial_institution_id_seq'::regclass);


--
-- Name: force_logout id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.force_logout ALTER COLUMN id SET DEFAULT nextval('public.force_logout_id_seq'::regclass);


--
-- Name: gateway_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gateway_type ALTER COLUMN id SET DEFAULT nextval('public.gateway_type_id_seq'::regclass);


--
-- Name: guest id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guest ALTER COLUMN id SET DEFAULT nextval('public.guest_id_seq'::regclass);


--
-- Name: help_content id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.help_content ALTER COLUMN id SET DEFAULT nextval('public.help_content_id_seq'::regclass);


--
-- Name: hotel id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel ALTER COLUMN id SET DEFAULT nextval('public.hotel_id_seq'::regclass);


--
-- Name: hotel_amenity id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_amenity ALTER COLUMN id SET DEFAULT nextval('public.hotel_amenity_id_seq'::regclass);


--
-- Name: hotel_contact_person id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_contact_person ALTER COLUMN id SET DEFAULT nextval('public.hotel_contact_person_id_seq'::regclass);


--
-- Name: hotel_content hotel_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_content ALTER COLUMN hotel_id SET DEFAULT nextval('public.hotel_content_hotel_id_seq'::regclass);


--
-- Name: hotel_image id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_image ALTER COLUMN id SET DEFAULT nextval('public.hotel_image_id_seq'::regclass);


--
-- Name: hotel_notification_subscriber hotel_notification_subscriber_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_notification_subscriber ALTER COLUMN hotel_notification_subscriber_id SET DEFAULT nextval('public.hotel_notification_subscriber_hotel_notification_subscriber_seq'::regclass);


--
-- Name: hotel_payment_account hotel_payment_account_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account ALTER COLUMN hotel_payment_account_id SET DEFAULT nextval('public.hotel_payment_account_hotel_payment_account_id_seq'::regclass);


--
-- Name: hotel_payment_account_doc hotel_payment_account_doc_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account_doc ALTER COLUMN hotel_payment_account_doc_id SET DEFAULT nextval('public.hotel_payment_account_doc_hotel_payment_account_doc_id_seq'::regclass);


--
-- Name: hotel_promotion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_promotion ALTER COLUMN id SET DEFAULT nextval('public.hotel_promotion_id_seq'::regclass);


--
-- Name: hotel_search_history id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_search_history ALTER COLUMN id SET DEFAULT nextval('public.hotel_search_history_id_seq'::regclass);


--
-- Name: hotel_to_attraction id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction ALTER COLUMN id SET DEFAULT nextval('public.hotel_to_attraction_id_seq'::regclass);


--
-- Name: message id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- Name: message_read id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read ALTER COLUMN id SET DEFAULT nextval('public.message_read_id_seq'::regclass);


--
-- Name: payment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment ALTER COLUMN id SET DEFAULT nextval('public.payment_id_seq'::regclass);


--
-- Name: public_holiday id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.public_holiday ALTER COLUMN id SET DEFAULT nextval('public.special_day_id_seq'::regclass);


--
-- Name: rate_group id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_group ALTER COLUMN id SET DEFAULT nextval('public.rate_group_id_seq'::regclass);


--
-- Name: rate_message id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_message ALTER COLUMN id SET DEFAULT nextval('public.rate_message_id_seq'::regclass);


--
-- Name: room_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type ALTER COLUMN id SET DEFAULT nextval('public.room_type_id_seq'::regclass);


--
-- Name: room_type_facility id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_facility ALTER COLUMN id SET DEFAULT nextval('public.room_type_facility_id_seq'::regclass);


--
-- Name: room_type_image id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_image ALTER COLUMN id SET DEFAULT nextval('public.room_type_image_id_seq'::regclass);


--
-- Name: settlement_confirmation id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_confirmation ALTER COLUMN id SET DEFAULT nextval('public.settlement_confirmation_id_seq'::regclass);


--
-- Name: settlement_doc id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_doc ALTER COLUMN id SET DEFAULT nextval('public.settlement_doc_id_seq'::regclass);


--
-- Name: settlement_request id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_request ALTER COLUMN id SET DEFAULT nextval('public.settlement_request_id_seq'::regclass);


--
-- Name: signed_in_event id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.signed_in_event ALTER COLUMN id SET DEFAULT nextval('public.signed_in_event_id_seq'::regclass);


--
-- Name: support_team id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_team ALTER COLUMN id SET DEFAULT nextval('public.support_team_id_seq'::regclass);


--
-- Name: tentative_booking_confirm_attempt id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking_confirm_attempt ALTER COLUMN id SET DEFAULT nextval('public.tentative_booking_confirm_attempt_id_seq'::regclass);


--
-- Name: tentative_booking_room_rate id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking_room_rate ALTER COLUMN id SET DEFAULT nextval('public.tentative_booking_room_rate_id_seq'::regclass);


--
-- Name: town id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.town ALTER COLUMN id SET DEFAULT nextval('public.town_id_seq'::regclass);


--
-- Name: township id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.township ALTER COLUMN id SET DEFAULT nextval('public.township_id_seq'::regclass);


--
-- Name: user_account id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account ALTER COLUMN id SET DEFAULT nextval('public.user_account_id_seq'::regclass);


--
-- Name: user_activity_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_activity_log ALTER COLUMN id SET DEFAULT nextval('public.user_activity_log_id_seq'::regclass);


--
-- Name: value_added_promotion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.value_added_promotion ALTER COLUMN id SET DEFAULT nextval('public.hotel_special_offer_id_seq'::regclass);


--
-- Data for Name: addon_type; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: agent; Type: TABLE DATA; Schema: public; Owner: -
--


--
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (id);


--
-- Name: town town_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.town
    ADD CONSTRAINT town_pkey PRIMARY KEY (id);


--
-- Name: township township_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.township
    ADD CONSTRAINT township_pkey PRIMARY KEY (id);


--
-- Name: hotel_summary; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.hotel_summary AS
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
    string_agg(DISTINCT concat(hotel_image.image_url, '>>'::text, (hotel_image.priority)::text), '<>'::text) AS image_urls,
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
   FROM ((((public.hotel
     LEFT JOIN public.hotel_image ON ((hotel.id = hotel_image.hotel_id)))
     LEFT JOIN public.town ON ((town.id = hotel.town_id)))
     LEFT JOIN public.township ON ((township.id = hotel.township_id)))
     LEFT JOIN public.hotel_to_attraction ON ((hotel_to_attraction.hotel_id = hotel.id)))
  GROUP BY hotel.id, town.id, township.id
  WITH NO DATA;


--
-- Name: hotel_content ID_PKEY; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_content
    ADD CONSTRAINT "ID_PKEY" PRIMARY KEY (hotel_id, language);


--
-- Name: addon_type addon_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addon_type
    ADD CONSTRAINT addon_type_pkey PRIMARY KEY (id);


--
-- Name: agent_balance agent_balance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_balance
    ADD CONSTRAINT agent_balance_pkey PRIMARY KEY (agent_id);


--
-- Name: agent_hotel agent_hotel_agent_id_hotel_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel
    ADD CONSTRAINT agent_hotel_agent_id_hotel_id_key UNIQUE (agent_id, hotel_id);


--
-- Name: agent_hotel_commission_version agent_hotel_commission_version_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel_commission_version
    ADD CONSTRAINT agent_hotel_commission_version_pkey PRIMARY KEY (id);


--
-- Name: agent_hotel agent_hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel
    ADD CONSTRAINT agent_hotel_pkey PRIMARY KEY (id);


--
-- Name: agent agent_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_pkey PRIMARY KEY (id);


--
-- Name: agent_promotion agent_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_promotion
    ADD CONSTRAINT agent_promotion_pkey PRIMARY KEY (id);


--
-- Name: agent_transaction agent_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_transaction
    ADD CONSTRAINT agent_transaction_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_access_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_access_key_key UNIQUE (access_key);


--
-- Name: api_key api_key_description_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_description_key UNIQUE (description);


--
-- Name: api_key api_key_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_secret_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_secret_key_key UNIQUE (secret_key);


--
-- Name: array_testing array_testing_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.array_testing
    ADD CONSTRAINT array_testing_pkey PRIMARY KEY (id);


--
-- Name: attraction attraction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attraction
    ADD CONSTRAINT attraction_pkey PRIMARY KEY (id);


--
-- Name: bank bank_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank
    ADD CONSTRAINT bank_name_key UNIQUE (full_name);


--
-- Name: bank bank_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank
    ADD CONSTRAINT bank_pkey PRIMARY KEY (id);


--
-- Name: bed_type bed_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bed_type
    ADD CONSTRAINT bed_type_pkey PRIMARY KEY (id);


--
-- Name: booker booker_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booker
    ADD CONSTRAINT booker_pkey PRIMARY KEY (id);


--
-- Name: booking_cancellation booking_cancellation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_cancellation
    ADD CONSTRAINT booking_cancellation_pkey PRIMARY KEY (id);


--
-- Name: booking_payment booking_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_payment
    ADD CONSTRAINT booking_payment_pkey PRIMARY KEY (id);


--
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- Name: booking_revision booking_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision
    ADD CONSTRAINT booking_revision_pkey PRIMARY KEY (id);


--
-- Name: booking_revision_room booking_room_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision_room
    ADD CONSTRAINT booking_room_pkey PRIMARY KEY (id);


--
-- Name: booking_revision_room_rate booking_room_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision_room_rate
    ADD CONSTRAINT booking_room_rate_pkey PRIMARY KEY (id);


--
-- Name: booking_session booking_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_session
    ADD CONSTRAINT booking_session_pkey PRIMARY KEY (id);


--
-- Name: date_rate_statistics date_rate_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date_rate_statistics
    ADD CONSTRAINT date_rate_statistics_pkey PRIMARY KEY (hotel_id, date);


--
-- Name: financial_institution financial_institution_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.financial_institution
    ADD CONSTRAINT financial_institution_pkey PRIMARY KEY (financial_institution_id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: force_logout force_logout_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.force_logout
    ADD CONSTRAINT force_logout_pkey PRIMARY KEY (id);


--
-- Name: gateway_type gateway_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gateway_type
    ADD CONSTRAINT gateway_type_pkey PRIMARY KEY (id);


--
-- Name: guest guest_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_pkey PRIMARY KEY (id);


--
-- Name: help_content help_content_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.help_content
    ADD CONSTRAINT help_content_key_key UNIQUE (key);


--
-- Name: help_content help_content_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.help_content
    ADD CONSTRAINT help_content_pkey PRIMARY KEY (id);


--
-- Name: hotel_amenity hotel_amenity_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_amenity
    ADD CONSTRAINT hotel_amenity_code_key UNIQUE (code);


--
-- Name: hotel_amenity hotel_amenity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_amenity
    ADD CONSTRAINT hotel_amenity_pkey PRIMARY KEY (id);


--
-- Name: hotel_blackout_dates_config hotel_blackout_dates_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_blackout_dates_config
    ADD CONSTRAINT hotel_blackout_dates_config_pkey PRIMARY KEY (hotel_id);


--
-- Name: hotel hotel_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_code_key UNIQUE (code);


--
-- Name: hotel_contact_person hotel_contact_person_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_contact_person
    ADD CONSTRAINT hotel_contact_person_pkey PRIMARY KEY (id);


--
-- Name: hotel_image hotel_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_image
    ADD CONSTRAINT hotel_image_pkey PRIMARY KEY (id);


--
-- Name: hotel_initial_approval hotel_initial_approval_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_initial_approval
    ADD CONSTRAINT hotel_initial_approval_pkey PRIMARY KEY (hotel_id);


--
-- Name: hotel_notification_subscriber hotel_notification_subscriber_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_notification_subscriber
    ADD CONSTRAINT hotel_notification_subscriber_pkey PRIMARY KEY (hotel_notification_subscriber_id);


--
-- Name: hotel_payment_account_approval hotel_payment_account_approval_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account_approval
    ADD CONSTRAINT hotel_payment_account_approval_pkey PRIMARY KEY (hotel_payment_account_id, approved_by);


--
-- Name: hotel_payment_account_doc hotel_payment_account_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account_doc
    ADD CONSTRAINT hotel_payment_account_doc_pkey PRIMARY KEY (hotel_payment_account_doc_id);


--
-- Name: hotel_payment_account hotel_payment_account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account
    ADD CONSTRAINT hotel_payment_account_pkey PRIMARY KEY (hotel_payment_account_id);


--
-- Name: hotel_promotion hotel_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_promotion
    ADD CONSTRAINT hotel_promotion_pkey PRIMARY KEY (id);


--
-- Name: hotel_rate_limit hotel_rate_limit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_rate_limit
    ADD CONSTRAINT hotel_rate_limit_pkey PRIMARY KEY (hotel_id);


--
-- Name: hotel_search_history hotel_search_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_search_history
    ADD CONSTRAINT hotel_search_history_pkey PRIMARY KEY (id);


--
-- Name: value_added_promotion hotel_special_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.value_added_promotion
    ADD CONSTRAINT hotel_special_offer_pkey PRIMARY KEY (id);


--
-- Name: hotel_to_attraction hotel_to_attraction_hotel_id_attraction_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction
    ADD CONSTRAINT hotel_to_attraction_hotel_id_attraction_id_key UNIQUE (hotel_id, attraction_id);


--
-- Name: hotel_to_attraction hotel_to_attraction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction
    ADD CONSTRAINT hotel_to_attraction_pkey PRIMARY KEY (id);


--
-- Name: hotel_user_role hotel_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_user_role
    ADD CONSTRAINT hotel_user_role_pkey PRIMARY KEY (hotel_id, user_id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: message_read message_read_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read
    ADD CONSTRAINT message_read_pkey PRIMARY KEY (id);


--
-- Name: payment_migs_gateway payment_migs_gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_migs_gateway
    ADD CONSTRAINT payment_migs_gateway_pkey PRIMARY KEY (hotel_id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- Name: rate_group_date_rate rate_group_date_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_group_date_rate
    ADD CONSTRAINT rate_group_date_rate_pkey PRIMARY KEY (rate_group_id, date);


--
-- Name: rate_group rate_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_group
    ADD CONSTRAINT rate_group_pkey PRIMARY KEY (id);


--
-- Name: rate_message rate_message_message_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_message
    ADD CONSTRAINT rate_message_message_key UNIQUE (message);


--
-- Name: rate_message rate_message_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_message
    ADD CONSTRAINT rate_message_pkey PRIMARY KEY (id);


--
-- Name: reference_block_starter reference_block_starter_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reference_block_starter
    ADD CONSTRAINT reference_block_starter_pkey PRIMARY KEY (id);


--
-- Name: room_type_date_allotment room_type_date_allotment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_allotment
    ADD CONSTRAINT room_type_date_allotment_pkey PRIMARY KEY (room_type_id, date);


--
-- Name: room_type_facility room_type_facility_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_facility
    ADD CONSTRAINT room_type_facility_code_key UNIQUE (code);


--
-- Name: room_type_facility room_type_facility_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_facility
    ADD CONSTRAINT room_type_facility_pkey PRIMARY KEY (id);


--
-- Name: room_type_image room_type_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_image
    ADD CONSTRAINT room_type_image_pkey PRIMARY KEY (id);


--
-- Name: room_type room_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type
    ADD CONSTRAINT room_type_pkey PRIMARY KEY (id);


--
-- Name: room_type_promotion room_type_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_promotion
    ADD CONSTRAINT room_type_promotion_pkey PRIMARY KEY (room_type_id, promotion_id);


--
-- Name: settlement_booking settlement_booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_booking
    ADD CONSTRAINT settlement_booking_pkey PRIMARY KEY (settlement_request_id, booking_id);


--
-- Name: settlement_confirmation settlement_confirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_confirmation
    ADD CONSTRAINT settlement_confirmation_pkey PRIMARY KEY (id);


--
-- Name: settlement_doc settlement_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_doc
    ADD CONSTRAINT settlement_doc_pkey PRIMARY KEY (id);


--
-- Name: settlement_request settlement_request_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_request
    ADD CONSTRAINT settlement_request_pkey PRIMARY KEY (id);


--
-- Name: signed_in_event signed_in_event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.signed_in_event
    ADD CONSTRAINT signed_in_event_pkey PRIMARY KEY (id);


--
-- Name: public_holiday special_day_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.public_holiday
    ADD CONSTRAINT special_day_pkey PRIMARY KEY (id);


--
-- Name: support_team support_team_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_team
    ADD CONSTRAINT support_team_pkey PRIMARY KEY (id);


--
-- Name: system_user_role system_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_user_role
    ADD CONSTRAINT system_user_role_pkey PRIMARY KEY (user_account_id);


--
-- Name: tentative_booking_confirm_attempt tentative_booking_confirm_attempt_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking_confirm_attempt
    ADD CONSTRAINT tentative_booking_confirm_attempt_pkey PRIMARY KEY (id);


--
-- Name: tentative_booking tentative_booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking
    ADD CONSTRAINT tentative_booking_pkey PRIMARY KEY (id);


--
-- Name: tentative_booking_room tentative_booking_room_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking_room
    ADD CONSTRAINT tentative_booking_room_pkey PRIMARY KEY (id);


--
-- Name: tentative_booking_room_rate tentative_booking_room_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking_room_rate
    ADD CONSTRAINT tentative_booking_room_rate_pkey PRIMARY KEY (id);


--
-- Name: user_account user_account_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_email_key UNIQUE (email);


--
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);


--
-- Name: user_activity_log user_activity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_activity_log
    ADD CONSTRAINT user_activity_log_pkey PRIMARY KEY (id);


--
-- Name: booking_room_booking_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX booking_room_booking_id ON public.booking_revision_room USING btree (booking_id);


--
-- Name: booking_room_rate_booking_room_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX booking_room_rate_booking_room_id ON public.booking_revision_room_rate USING btree (booking_revision_room_id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: tentative_booking_room_rate_tentative_booking_room_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tentative_booking_room_rate_tentative_booking_room_id ON public.tentative_booking_room_rate USING btree (tentative_booking_room_id);


--
-- Name: tentative_booking_room_tentative_booking_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tentative_booking_room_tentative_booking_id ON public.tentative_booking_room USING btree (tentative_booking_id);


--
-- Name: reference_block_starter reference_block_no_delete_constraint; Type: RULE; Schema: public; Owner: -
--

CREATE RULE reference_block_no_delete_constraint AS
    ON DELETE TO public.reference_block_starter DO INSTEAD NOTHING;


--
-- Name: addon_type addon_type_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addon_type
    ADD CONSTRAINT addon_type_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: agent agent_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.user_account(id);


--
-- Name: agent_hotel agent_hotel_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel
    ADD CONSTRAINT agent_hotel_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(id);


--
-- Name: agent_hotel agent_hotel_commission_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel
    ADD CONSTRAINT agent_hotel_commission_version_id_fkey FOREIGN KEY (commission_version_id) REFERENCES public.agent_hotel_commission_version(id);


--
-- Name: agent_hotel agent_hotel_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel
    ADD CONSTRAINT agent_hotel_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: agent agent_modifier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_modifier_id_fkey FOREIGN KEY (modifier_id) REFERENCES public.user_account(id);


--
-- Name: agent_promotion agent_promotion_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_promotion
    ADD CONSTRAINT agent_promotion_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(id);


--
-- Name: agent_promotion agent_promotion_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_promotion
    ADD CONSTRAINT agent_promotion_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- Name: agent_promotion agent_promotion_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_promotion
    ADD CONSTRAINT agent_promotion_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: agent_promotion agent_promotion_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_promotion
    ADD CONSTRAINT agent_promotion_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.user_account(id);


--
-- Name: agent_transaction agent_transaction_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_transaction
    ADD CONSTRAINT agent_transaction_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(id);


--
-- Name: api_key api_key_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(id);


--
-- Name: api_key api_key_generated_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_generated_by_id_fkey FOREIGN KEY (generated_by_id) REFERENCES public.user_account(id);


--
-- Name: attraction attraction_town_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attraction
    ADD CONSTRAINT attraction_town_id_fkey FOREIGN KEY (town_id) REFERENCES public.town(id);


--
-- Name: booking booking_agent_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_agent_hotel_id_fkey FOREIGN KEY (agent_hotel_id) REFERENCES public.agent_hotel(id);


--
-- Name: booking booking_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(id);


--
-- Name: booking booking_booker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_booker_id_fkey FOREIGN KEY (booker_id) REFERENCES public.booker(id);


--
-- Name: booking booking_booking_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_booking_revision_id_fkey FOREIGN KEY (booking_revision_id) REFERENCES public.booking_revision(id);


--
-- Name: booking_cancellation booking_cancellation_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_cancellation
    ADD CONSTRAINT booking_cancellation_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id);


--
-- Name: booking_cancellation booking_cancellation_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_cancellation
    ADD CONSTRAINT booking_cancellation_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- Name: booking booking_commission_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_commission_version_id_fkey FOREIGN KEY (commission_version_id) REFERENCES public.agent_hotel_commission_version(id);


--
-- Name: booking booking_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: booking booking_hotel_special_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_hotel_special_offer_id_fkey FOREIGN KEY (hotel_special_offer_id) REFERENCES public.value_added_promotion(id);


--
-- Name: booking_payment booking_payment_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_payment
    ADD CONSTRAINT booking_payment_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id);


--
-- Name: booking booking_payment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.payment(id);


--
-- Name: booking_payment booking_payment_payment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_payment
    ADD CONSTRAINT booking_payment_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.payment(id);


--
-- Name: booking booking_primary_guest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_primary_guest_id_fkey FOREIGN KEY (primary_guest_id) REFERENCES public.guest(id);


--
-- Name: booking_revision booking_revision_booker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision
    ADD CONSTRAINT booking_revision_booker_id_fkey FOREIGN KEY (booker_id) REFERENCES public.booker(id);


--
-- Name: booking_revision booking_revision_hotel_special_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision
    ADD CONSTRAINT booking_revision_hotel_special_offer_id_fkey FOREIGN KEY (value_added_promotion_id) REFERENCES public.value_added_promotion(id);


--
-- Name: booking_revision booking_revision_primary_guest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision
    ADD CONSTRAINT booking_revision_primary_guest_id_fkey FOREIGN KEY (primary_guest_id) REFERENCES public.guest(id);


--
-- Name: booking_revision_room booking_room_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision_room
    ADD CONSTRAINT booking_room_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id);


--
-- Name: booking_revision_room booking_room_booking_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision_room
    ADD CONSTRAINT booking_room_booking_revision_id_fkey FOREIGN KEY (booking_revision_id) REFERENCES public.booking_revision(id);


--
-- Name: booking_revision_room_rate booking_room_rate_booking_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision_room_rate
    ADD CONSTRAINT booking_room_rate_booking_room_id_fkey FOREIGN KEY (booking_revision_room_id) REFERENCES public.booking_revision_room(id);


--
-- Name: booking_revision_room booking_room_rate_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision_room
    ADD CONSTRAINT booking_room_rate_group_id_fkey FOREIGN KEY (rate_group_id) REFERENCES public.rate_group(id);


--
-- Name: booking_revision_room booking_room_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_revision_room
    ADD CONSTRAINT booking_room_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- Name: booking_session booking_session_agent_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_session
    ADD CONSTRAINT booking_session_agent_hotel_id_fkey FOREIGN KEY (agent_hotel_id) REFERENCES public.agent_hotel(id);


--
-- Name: booking_session booking_session_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_session
    ADD CONSTRAINT booking_session_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(id);


--
-- Name: booking_session booking_session_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_session
    ADD CONSTRAINT booking_session_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: booking_session booking_session_hotel_special_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_session
    ADD CONSTRAINT booking_session_hotel_special_offer_id_fkey FOREIGN KEY (value_added_promotion_id) REFERENCES public.value_added_promotion(id);


--
-- Name: booking booking_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.user_account(id);


--
-- Name: date_rate_statistics date_rate_statistics_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date_rate_statistics
    ADD CONSTRAINT date_rate_statistics_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel fk_townid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT fk_townid FOREIGN KEY (town_id) REFERENCES public.town(id);


--
-- Name: help_content help_content_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.help_content
    ADD CONSTRAINT help_content_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- Name: hotel_blackout_dates_config hotel_blackout_dates_config_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_blackout_dates_config
    ADD CONSTRAINT hotel_blackout_dates_config_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel_contact_person hotel_contact_person_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_contact_person
    ADD CONSTRAINT hotel_contact_person_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel hotel_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- Name: hotel_image hotel_image_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_image
    ADD CONSTRAINT hotel_image_fk FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel_initial_approval hotel_initial_approval_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_initial_approval
    ADD CONSTRAINT hotel_initial_approval_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel_initial_approval hotel_initial_approval_super_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_initial_approval
    ADD CONSTRAINT hotel_initial_approval_super_admin_id_fkey FOREIGN KEY (super_admin_id) REFERENCES public.user_account(id);


--
-- Name: hotel_notification_subscriber hotel_notification_subscriber_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_notification_subscriber
    ADD CONSTRAINT hotel_notification_subscriber_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- Name: hotel_notification_subscriber hotel_notification_subscriber_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_notification_subscriber
    ADD CONSTRAINT hotel_notification_subscriber_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel_notification_subscriber hotel_notification_subscriber_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_notification_subscriber
    ADD CONSTRAINT hotel_notification_subscriber_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.user_account(id);


--
-- Name: hotel_payment_account_approval hotel_payment_account_approval_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account_approval
    ADD CONSTRAINT hotel_payment_account_approval_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.user_account(id);


--
-- Name: hotel_payment_account_approval hotel_payment_account_approval_hotel_payment_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account_approval
    ADD CONSTRAINT hotel_payment_account_approval_hotel_payment_account_id_fkey FOREIGN KEY (hotel_payment_account_id) REFERENCES public.hotel_payment_account(hotel_payment_account_id);


--
-- Name: hotel_payment_account hotel_payment_account_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account
    ADD CONSTRAINT hotel_payment_account_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- Name: hotel_payment_account_doc hotel_payment_account_doc_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account_doc
    ADD CONSTRAINT hotel_payment_account_doc_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- Name: hotel_payment_account_doc hotel_payment_account_doc_hotel_payment_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account_doc
    ADD CONSTRAINT hotel_payment_account_doc_hotel_payment_account_id_fkey FOREIGN KEY (hotel_payment_account_id) REFERENCES public.hotel_payment_account(hotel_payment_account_id);


--
-- Name: hotel_payment_account hotel_payment_account_financial_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account
    ADD CONSTRAINT hotel_payment_account_financial_institution_id_fkey FOREIGN KEY (financial_institution_id) REFERENCES public.financial_institution(financial_institution_id);


--
-- Name: hotel_payment_account hotel_payment_account_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account
    ADD CONSTRAINT hotel_payment_account_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel_payment_account hotel_payment_account_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_payment_account
    ADD CONSTRAINT hotel_payment_account_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.user_account(id);


--
-- Name: hotel_promotion hotel_promotion_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_promotion
    ADD CONSTRAINT hotel_promotion_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- Name: hotel_promotion hotel_promotion_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_promotion
    ADD CONSTRAINT hotel_promotion_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel_promotion hotel_promotion_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_promotion
    ADD CONSTRAINT hotel_promotion_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.user_account(id);


--
-- Name: hotel_rate_limit hotel_rate_limit_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_rate_limit
    ADD CONSTRAINT hotel_rate_limit_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: value_added_promotion hotel_special_offer_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.value_added_promotion
    ADD CONSTRAINT hotel_special_offer_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- Name: value_added_promotion hotel_special_offer_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.value_added_promotion
    ADD CONSTRAINT hotel_special_offer_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: value_added_promotion hotel_special_offer_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.value_added_promotion
    ADD CONSTRAINT hotel_special_offer_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.user_account(id);


--
-- Name: hotel_to_attraction hotel_to_attraction_attraction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction
    ADD CONSTRAINT hotel_to_attraction_attraction_id_fkey FOREIGN KEY (attraction_id) REFERENCES public.attraction(id);


--
-- Name: hotel_to_attraction hotel_to_attraction_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction
    ADD CONSTRAINT hotel_to_attraction_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel hotel_township_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_township_id_fkey FOREIGN KEY (township_id) REFERENCES public.township(id);


--
-- Name: hotel_user_role hotel_user_role_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_user_role
    ADD CONSTRAINT hotel_user_role_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: hotel_user_role hotel_user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_user_role
    ADD CONSTRAINT hotel_user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_account(id);


--
-- Name: message message_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.user_account(id);


--
-- Name: message message_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: message_read message_read_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read
    ADD CONSTRAINT message_read_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: message_read message_read_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read
    ADD CONSTRAINT message_read_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.message(id);


--
-- Name: message_read message_read_reader_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read
    ADD CONSTRAINT message_read_reader_id_fkey FOREIGN KEY (reader_id) REFERENCES public.user_account(id);


--
-- Name: payment_migs_gateway payment_migs_gateway_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_migs_gateway
    ADD CONSTRAINT payment_migs_gateway_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: rate_group rate_group_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_group
    ADD CONSTRAINT rate_group_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- Name: room_bed_count room_bed_count_bed_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_bed_count
    ADD CONSTRAINT room_bed_count_bed_type_id_fkey FOREIGN KEY (bed_type_id) REFERENCES public.bed_type(id);


--
-- Name: room_bed_count room_bed_count_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_bed_count
    ADD CONSTRAINT room_bed_count_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- Name: room_type_date_allotment room_type_date_allotment_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_allotment
    ADD CONSTRAINT room_type_date_allotment_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- Name: room_type_extra_bed_rate room_type_extra_bed_rate_rate_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_extra_bed_rate
    ADD CONSTRAINT room_type_extra_bed_rate_rate_group_id_fkey FOREIGN KEY (rate_group_id) REFERENCES public.rate_group(id);


--
-- Name: room_type_extra_bed_rate room_type_extra_bed_rate_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_extra_bed_rate
    ADD CONSTRAINT room_type_extra_bed_rate_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- Name: room_type_promotion room_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_promotion
    ADD CONSTRAINT room_type_fk FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- Name: room_type room_type_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type
    ADD CONSTRAINT room_type_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: room_type_image room_type_image_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_image
    ADD CONSTRAINT room_type_image_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- Name: settlement_booking settlement_booking_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_booking
    ADD CONSTRAINT settlement_booking_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id);


--
-- Name: settlement_booking settlement_booking_settlement_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_booking
    ADD CONSTRAINT settlement_booking_settlement_request_id_fkey FOREIGN KEY (settlement_request_id) REFERENCES public.settlement_request(id);


--
-- Name: settlement_confirmation settlement_confirmation_modifier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_confirmation
    ADD CONSTRAINT settlement_confirmation_modifier_id_fkey FOREIGN KEY (modifier_id) REFERENCES public.user_account(id);


--
-- Name: settlement_confirmation settlement_confirmation_settlement_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_confirmation
    ADD CONSTRAINT settlement_confirmation_settlement_request_id_fkey FOREIGN KEY (settlement_request_id) REFERENCES public.settlement_request(id);


--
-- Name: settlement_doc settlement_doc_settlement_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_doc
    ADD CONSTRAINT settlement_doc_settlement_request_id_fkey FOREIGN KEY (settlement_request_id) REFERENCES public.settlement_request(id);


--
-- Name: settlement_doc settlement_doc_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_doc
    ADD CONSTRAINT settlement_doc_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES public.user_account(id);


--
-- Name: settlement_request settlement_request_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_request
    ADD CONSTRAINT settlement_request_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.user_account(id);


--
-- Name: settlement_request settlement_request_hotel_payment_account_id_fkyey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_request
    ADD CONSTRAINT settlement_request_hotel_payment_account_id_fkyey FOREIGN KEY (hotel_payment_account_id) REFERENCES public.hotel_payment_account(hotel_payment_account_id);


--
-- Name: signed_in_event signed_in_event_user_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.signed_in_event
    ADD CONSTRAINT signed_in_event_user_account_id_fkey FOREIGN KEY (user_account_id) REFERENCES public.user_account(id);


--
-- Name: system_user_role system_user_role_user_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_user_role
    ADD CONSTRAINT system_user_role_user_account_id_fkey FOREIGN KEY (user_account_id) REFERENCES public.user_account(id);


--
-- Name: tentative_booking tentative_booking_agent_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking
    ADD CONSTRAINT tentative_booking_agent_hotel_id_fkey FOREIGN KEY (agent_hotel_id) REFERENCES public.agent_hotel(id);


--
-- Name: tentative_booking tentative_booking_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking
    ADD CONSTRAINT tentative_booking_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(id);


--
-- Name: tentative_booking tentative_booking_booker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking
    ADD CONSTRAINT tentative_booking_booker_id_fkey FOREIGN KEY (booker_id) REFERENCES public.booker(id);


--
-- Name: tentative_booking tentative_booking_commission_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking
    ADD CONSTRAINT tentative_booking_commission_version_id_fkey FOREIGN KEY (commission_version_id) REFERENCES public.agent_hotel_commission_version(id);


--
-- Name: tentative_booking tentative_booking_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking
    ADD CONSTRAINT tentative_booking_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: tentative_booking tentative_booking_hotel_special_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking
    ADD CONSTRAINT tentative_booking_hotel_special_offer_id_fkey FOREIGN KEY (value_added_promotion_id) REFERENCES public.value_added_promotion(id);


--
-- Name: tentative_booking tentative_booking_primary_guest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking
    ADD CONSTRAINT tentative_booking_primary_guest_id_fkey FOREIGN KEY (primary_guest_id) REFERENCES public.guest(id);


--
-- Name: tentative_booking_room tentative_booking_room_rate_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking_room
    ADD CONSTRAINT tentative_booking_room_rate_group_id_fkey FOREIGN KEY (rate_group_id) REFERENCES public.rate_group(id);


--
-- Name: tentative_booking_room_rate tentative_booking_room_rate_tentative_booking_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking_room_rate
    ADD CONSTRAINT tentative_booking_room_rate_tentative_booking_room_id_fkey FOREIGN KEY (tentative_booking_room_id) REFERENCES public.tentative_booking_room(id);


--
-- Name: tentative_booking_room tentative_booking_room_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking_room
    ADD CONSTRAINT tentative_booking_room_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- Name: tentative_booking_room tentative_booking_room_tentative_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tentative_booking_room
    ADD CONSTRAINT tentative_booking_room_tentative_booking_id_fkey FOREIGN KEY (tentative_booking_id) REFERENCES public.tentative_booking(id);


--
-- Name: township township_town_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.township
    ADD CONSTRAINT township_town_id_fkey FOREIGN KEY (town_id) REFERENCES public.town(id);


--
-- Name: user_activity_log user_activity_log_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_activity_log
    ADD CONSTRAINT user_activity_log_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- Name: user_activity_log user_activity_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_activity_log
    ADD CONSTRAINT user_activity_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_account(id);


--
-- Name: hotel_summary; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: -
--

REFRESH MATERIALIZED VIEW public.hotel_summary;


--
-- PostgreSQL database dump complete
--

