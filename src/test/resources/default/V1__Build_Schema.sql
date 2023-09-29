--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3
-- Dumped by pg_dump version 11.3

-- Started on 2021-01-06 16:09:26

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 54947)
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- TOC entry 992 (class 1247 OID 37296)
-- Name: guest_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.guest_type AS ENUM (
    'local',
    'foreigner',
    'default'
);


--
-- TOC entry 881 (class 1247 OID 18220)
-- Name: transaction_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.transaction_type AS ENUM (
    'deposit',
    'booking',
    'commission'
);


SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 17690)
-- Name: addon_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addon_type (
    id integer NOT NULL,
    hotel_id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL
);


--
-- TOC entry 198 (class 1259 OID 17696)
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
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 198
-- Name: addon_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.addon_type_id_seq OWNED BY public.addon_type.id;


--
-- TOC entry 230 (class 1259 OID 18122)
-- Name: agent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent (
    id integer NOT NULL,
    name text,
    domain text,
    description text,
    commission_rate numeric,
    creator_id integer,
    modifier_id integer,
    created_date timestamp without time zone,
    modified_date timestamp without time zone,
    api_key character varying(50)
);


--
-- TOC entry 234 (class 1259 OID 18158)
-- Name: agent_balance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_balance (
    agent_id integer NOT NULL,
    balance numeric(10,2),
    modified_date timestamp without time zone
);


--
-- TOC entry 233 (class 1259 OID 18156)
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
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 233
-- Name: agent_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_balance_id_seq OWNED BY public.agent_balance.agent_id;


--
-- TOC entry 236 (class 1259 OID 18173)
-- Name: agent_hotel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_hotel (
    id integer NOT NULL,
    agent_id integer,
    hotel_id integer,
    commission_rate numeric
);


--
-- TOC entry 235 (class 1259 OID 18171)
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
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 235
-- Name: agent_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_hotel_id_seq OWNED BY public.agent_hotel.id;


--
-- TOC entry 229 (class 1259 OID 18120)
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
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 229
-- Name: agent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_id_seq OWNED BY public.agent.id;


--
-- TOC entry 232 (class 1259 OID 18143)
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
-- TOC entry 231 (class 1259 OID 18141)
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
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 231
-- Name: agent_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_transaction_id_seq OWNED BY public.agent_transaction.id;


--
-- TOC entry 241 (class 1259 OID 18353)
-- Name: array_testing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.array_testing (
    id integer NOT NULL,
    name text[],
    test text,
    date date
);


--
-- TOC entry 240 (class 1259 OID 18351)
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
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 240
-- Name: array_testing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.array_testing_id_seq OWNED BY public.array_testing.id;


--
-- TOC entry 199 (class 1259 OID 17698)
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
    name_mm_soundex text
);


--
-- TOC entry 200 (class 1259 OID 17704)
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
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 200
-- Name: attraction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attraction_id_seq OWNED BY public.attraction.id;


--
-- TOC entry 281 (class 1259 OID 37621)
-- Name: bank; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bank (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    short_name character varying(10)
);


--
-- TOC entry 280 (class 1259 OID 37619)
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
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 280
-- Name: bank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bank_id_seq OWNED BY public.bank.id;


--
-- TOC entry 285 (class 1259 OID 39531)
-- Name: bed_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bed_type (
    id integer NOT NULL,
    bed_type character varying(100)
);


--
-- TOC entry 284 (class 1259 OID 39529)
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
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 284
-- Name: bed_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bed_type_id_seq OWNED BY public.bed_type.id;


--
-- TOC entry 201 (class 1259 OID 17706)
-- Name: booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking (
    id integer NOT NULL,
    customer_id integer,
    hotel_id integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    checkin_date date NOT NULL,
    checkout_date date NOT NULL,
    note text,
    total_amount numeric(10,2) NOT NULL,
    number_of_room integer,
    number_of_guest integer,
    transaction_id text,
    primary_guest_id integer,
    reference character varying(10),
    payment_id integer,
    total_net_amount numeric(10,2),
    commission_percentage numeric(5,2),
    tax_percentage numeric,
    tax_amount numeric(10,2),
    is_fully_paid boolean
);


--
-- TOC entry 202 (class 1259 OID 17712)
-- Name: booking_attempt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_attempt (
    id integer NOT NULL,
    hotel_id integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    checkin_date date NOT NULL,
    checkout_date date NOT NULL,
    total_amount numeric(10,2),
    number_of_room integer,
    number_of_guest integer,
    code character varying(37),
    total_net_amount numeric(10,2),
    tax_amount numeric(10,2)
);


--
-- TOC entry 259 (class 1259 OID 26718)
-- Name: booking_attempt_room_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_attempt_room_rate (
    id integer NOT NULL,
    booking_attempt_room_id integer,
    date date,
    standard_rate numeric(10,2),
    net_rate numeric(10,2),
    extra_bed_rate numeric(10,2),
    effective_rate numeric(10,2)
);


--
-- TOC entry 258 (class 1259 OID 26716)
-- Name: booking_attempt_date_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_attempt_date_rate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 258
-- Name: booking_attempt_date_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_attempt_date_rate_id_seq OWNED BY public.booking_attempt_room_rate.id;


--
-- TOC entry 303 (class 1259 OID 55185)
-- Name: booking_attempt_failed_record; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_attempt_failed_record (
    id integer NOT NULL,
    booking_attempt_id integer,
    failed_date_time timestamp without time zone
);


--
-- TOC entry 302 (class 1259 OID 55183)
-- Name: booking_attempt_failed_record_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_attempt_failed_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 302
-- Name: booking_attempt_failed_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_attempt_failed_record_id_seq OWNED BY public.booking_attempt_failed_record.id;


--
-- TOC entry 203 (class 1259 OID 17724)
-- Name: booking_attempt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_attempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 203
-- Name: booking_attempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_attempt_id_seq OWNED BY public.booking_attempt.id;


--
-- TOC entry 257 (class 1259 OID 26695)
-- Name: booking_attempt_room; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_attempt_room (
    id integer NOT NULL,
    booking_attempt_id integer,
    room_type_id integer,
    rate_group_id integer,
    number_of_adult integer,
    number_of_child integer,
    number_of_extra_bed integer
);


--
-- TOC entry 256 (class 1259 OID 26693)
-- Name: booking_attempt_room_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_attempt_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 256
-- Name: booking_attempt_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_attempt_room_id_seq OWNED BY public.booking_attempt_room.id;


--
-- TOC entry 288 (class 1259 OID 40413)
-- Name: booking_confirmation_attempt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_confirmation_attempt (
    id integer NOT NULL,
    booking_attempt_id integer,
    payment_date timestamp without time zone,
    payment_amount numeric(10,2),
    payment_currency character varying(5),
    payment_type character varying(10),
    customer_name character varying(100),
    customer_phone_number character varying(20),
    customer_email character varying(50),
    customer_nationality character varying(20),
    customer_special_request character varying(100),
    guest_name character varying(100),
    guest_gender character varying(20),
    guest_phone_number character varying(20),
    guest_nationality character varying(20)
);


--
-- TOC entry 287 (class 1259 OID 40411)
-- Name: booking_confirmation_attempt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_confirmation_attempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 287
-- Name: booking_confirmation_attempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_confirmation_attempt_id_seq OWNED BY public.booking_confirmation_attempt.id;


--
-- TOC entry 262 (class 1259 OID 26737)
-- Name: booking_date_room_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_date_room_type (
    id integer NOT NULL,
    booking_id integer NOT NULL,
    date date NOT NULL,
    room_type_id integer NOT NULL,
    num_adult integer,
    num_children integer,
    rate numeric(7,2) NOT NULL,
    number_of_extra_bed integer NOT NULL,
    room_index integer,
    extra_bed_rate numeric(7,2),
    effective_rate numeric(7,2)
);


--
-- TOC entry 204 (class 1259 OID 17737)
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 204
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;


--
-- TOC entry 261 (class 1259 OID 26731)
-- Name: booking_room; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_room (
    id integer NOT NULL,
    booking_id integer,
    room_type_id integer,
    rate_group_id integer,
    number_of_adult integer,
    number_of_child integer,
    number_of_extra_bed integer,
    guest_id integer
);


--
-- TOC entry 253 (class 1259 OID 26649)
-- Name: booking_room_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_room_rate (
    id integer NOT NULL,
    booking_room_id integer NOT NULL,
    date date NOT NULL,
    standard_rate numeric(10,2) NOT NULL,
    net_rate numeric(10,2),
    extra_bed_rate numeric(10,2),
    effective_rate numeric(10,2)
);


--
-- TOC entry 252 (class 1259 OID 26647)
-- Name: booking_room_date_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_room_date_rate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 252
-- Name: booking_room_date_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_room_date_rate_id_seq OWNED BY public.booking_room_rate.id;


--
-- TOC entry 260 (class 1259 OID 26729)
-- Name: booking_room_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 260
-- Name: booking_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_room_id_seq OWNED BY public.booking_room.id;


--
-- TOC entry 205 (class 1259 OID 17739)
-- Name: customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone_number character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    nationality text,
    special_request text,
    country_code text
);


--
-- TOC entry 206 (class 1259 OID 17745)
-- Name: customer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 206
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_id_seq OWNED BY public.customer.id;


--
-- TOC entry 271 (class 1259 OID 37227)
-- Name: promotion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promotion (
    id integer NOT NULL,
    title character varying(100),
    description text,
    is_active boolean,
    maximum_advance_days integer,
    minimum_advance_days integer,
    start_date date,
    end_date date,
    discount_percentage numeric(4,2),
    creator_id integer,
    modifier_id integer,
    created_date timestamp without time zone,
    modified_date timestamp without time zone,
    hotel_id integer
);


--
-- TOC entry 270 (class 1259 OID 37225)
-- Name: date_range_promotion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.date_range_promotion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 270
-- Name: date_range_promotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.date_range_promotion_id_seq OWNED BY public.promotion.id;


--
-- TOC entry 207 (class 1259 OID 17747)
-- Name: gateway_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gateway_type (
    id integer NOT NULL,
    name text NOT NULL,
    code text
);


--
-- TOC entry 208 (class 1259 OID 17753)
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
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 208
-- Name: gateway_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gateway_type_id_seq OWNED BY public.gateway_type.id;


--
-- TOC entry 255 (class 1259 OID 26662)
-- Name: guest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guest (
    id integer NOT NULL,
    name text,
    gender character varying(10),
    phone_number character varying(20),
    nationality character varying(50),
    country_code character varying(10)
);


--
-- TOC entry 254 (class 1259 OID 26660)
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
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 254
-- Name: guest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.guest_id_seq OWNED BY public.guest.id;


--
-- TOC entry 209 (class 1259 OID 17755)
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
    primary_phone_number text NOT NULL,
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
    commission_percentage numeric(4,2),
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
    is_partial_payment_allowed boolean
);


--
-- TOC entry 243 (class 1259 OID 18364)
-- Name: hotel_amenity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_amenity (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    amenity character varying(200) NOT NULL,
    icon text
);


--
-- TOC entry 242 (class 1259 OID 18362)
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
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 242
-- Name: hotel_amenity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_amenity_id_seq OWNED BY public.hotel_amenity.id;


--
-- TOC entry 279 (class 1259 OID 37611)
-- Name: hotel_bank_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_bank_account (
    id integer NOT NULL,
    hotel_id integer,
    account_holder character varying(100),
    account_number character varying(50),
    bank_id integer,
    created_by integer,
    created_on timestamp without time zone,
    photo_url character varying(200),
    bank_branch_name text,
    updated_by integer,
    updated_on timestamp without time zone
);


--
-- TOC entry 290 (class 1259 OID 40534)
-- Name: hotel_bank_account_approvement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_bank_account_approvement (
    id integer NOT NULL,
    hotel_bank_account_id integer,
    approved_by integer,
    approved_on timestamp without time zone
);


--
-- TOC entry 289 (class 1259 OID 40532)
-- Name: hotel_bank_account_approvement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_bank_account_approvement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 289
-- Name: hotel_bank_account_approvement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_bank_account_approvement_id_seq OWNED BY public.hotel_bank_account_approvement.id;


--
-- TOC entry 310 (class 1259 OID 56172)
-- Name: hotel_bank_account_docs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_bank_account_docs (
    id integer NOT NULL,
    bank_account_id integer,
    file_name text,
    s3_key text,
    created_by integer,
    created_on timestamp without time zone
);


--
-- TOC entry 309 (class 1259 OID 56170)
-- Name: hotel_bank_account_docs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_bank_account_docs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 309
-- Name: hotel_bank_account_docs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_bank_account_docs_id_seq OWNED BY public.hotel_bank_account_docs.id;


--
-- TOC entry 278 (class 1259 OID 37609)
-- Name: hotel_bank_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotel_bank_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 278
-- Name: hotel_bank_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_bank_account_id_seq OWNED BY public.hotel_bank_account.id;


--
-- TOC entry 306 (class 1259 OID 55366)
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
-- TOC entry 305 (class 1259 OID 55364)
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
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 305
-- Name: hotel_contact_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_contact_person_id_seq OWNED BY public.hotel_contact_person.id;


--
-- TOC entry 249 (class 1259 OID 26590)
-- Name: hotel_content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_content (
    hotel_id integer NOT NULL,
    language text NOT NULL,
    terms text,
    policy text,
    cancellation text,
    child_policy text
);


--
-- TOC entry 248 (class 1259 OID 26588)
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
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 248
-- Name: hotel_content_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_content_hotel_id_seq OWNED BY public.hotel_content.hotel_id;


--
-- TOC entry 210 (class 1259 OID 17761)
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
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 210
-- Name: hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_id_seq OWNED BY public.hotel.id;


--
-- TOC entry 251 (class 1259 OID 26601)
-- Name: hotel_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_image (
    id integer NOT NULL,
    hotel_id integer NOT NULL,
    priority integer,
    image_url text NOT NULL
);


--
-- TOC entry 250 (class 1259 OID 26599)
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
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 250
-- Name: hotel_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_image_id_seq OWNED BY public.hotel_image.id;


--
-- TOC entry 292 (class 1259 OID 40919)
-- Name: hotel_initial_approval; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_initial_approval (
    hotel_id integer NOT NULL,
    super_admin_id integer,
    approved_on timestamp without time zone
);


--
-- TOC entry 228 (class 1259 OID 18097)
-- Name: hotel_to_attraction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_to_attraction (
    id integer NOT NULL,
    hotel_id integer,
    attraction_id integer,
    distance_between text
);


--
-- TOC entry 227 (class 1259 OID 18095)
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
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 227
-- Name: hotel_to_attraction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotel_to_attraction_id_seq OWNED BY public.hotel_to_attraction.id;


--
-- TOC entry 283 (class 1259 OID 38324)
-- Name: hotel_user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotel_user_role (
    hotel_id integer NOT NULL,
    user_id integer NOT NULL,
    role character varying(50) NOT NULL
);


--
-- TOC entry 308 (class 1259 OID 55430)
-- Name: login_record; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.login_record (
    id integer NOT NULL,
    email character varying(100),
    is_success boolean,
    logged_in_date_time timestamp without time zone
);


--
-- TOC entry 307 (class 1259 OID 55428)
-- Name: login_record_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.login_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 307
-- Name: login_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.login_record_id_seq OWNED BY public.login_record.id;


--
-- TOC entry 296 (class 1259 OID 52867)
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
-- TOC entry 295 (class 1259 OID 52865)
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
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 295
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.message.id;


--
-- TOC entry 298 (class 1259 OID 52888)
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
-- TOC entry 297 (class 1259 OID 52886)
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
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 297
-- Name: message_read_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.message_read_id_seq OWNED BY public.message_read.id;


--
-- TOC entry 294 (class 1259 OID 51241)
-- Name: password_setter_token_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_setter_token_status (
    id integer NOT NULL,
    token text,
    token_creator integer,
    token_user integer,
    created_on timestamp without time zone,
    used_on timestamp without time zone,
    is_used boolean
);


--
-- TOC entry 293 (class 1259 OID 51239)
-- Name: password_setting_token_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.password_setting_token_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 293
-- Name: password_setting_token_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.password_setting_token_log_id_seq OWNED BY public.password_setter_token_status.id;


--
-- TOC entry 264 (class 1259 OID 34836)
-- Name: payment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment (
    id integer NOT NULL,
    created_on timestamp without time zone,
    amount numeric(10,2),
    gateway_type_id integer,
    currency character varying(10)
);


--
-- TOC entry 263 (class 1259 OID 34834)
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
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 263
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;


--
-- TOC entry 211 (class 1259 OID 17769)
-- Name: payment_migs_gateway; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_migs_gateway (
    hotel_id integer NOT NULL,
    merchant_code text NOT NULL,
    access_code text NOT NULL,
    secrect_key text NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 26570)
-- Name: rate_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_group (
    id integer NOT NULL,
    guest_type text NOT NULL,
    room_type_id integer,
    minimum_advance_days integer,
    maximum_advance_days integer,
    is_member boolean,
    title text,
    currency character varying(5),
    is_active boolean,
    based_on_plan_id integer,
    additional_percentage numeric(4,2),
    description text,
    dependent_rate_type character varying(20),
    additional_flat_amount numeric(10,2)
);


--
-- TOC entry 273 (class 1259 OID 37331)
-- Name: rate_group_date_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_group_date_rate (
    rate_group_id integer NOT NULL,
    date date NOT NULL,
    rate numeric(10,2)
);


--
-- TOC entry 246 (class 1259 OID 26568)
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
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 246
-- Name: rate_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rate_group_id_seq OWNED BY public.rate_group.id;


--
-- TOC entry 269 (class 1259 OID 37209)
-- Name: rate_message; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_message (
    id integer NOT NULL,
    message text NOT NULL
);


--
-- TOC entry 268 (class 1259 OID 37207)
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
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 268
-- Name: rate_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rate_message_id_seq OWNED BY public.rate_message.id;


--
-- TOC entry 267 (class 1259 OID 34894)
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
-- TOC entry 266 (class 1259 OID 34892)
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 266
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.region_id_seq OWNED BY public.township.id;


--
-- TOC entry 286 (class 1259 OID 39537)
-- Name: room_bed_count; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_bed_count (
    room_type_id integer,
    bed_type_id integer,
    number_of_bed integer
);


--
-- TOC entry 212 (class 1259 OID 17775)
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
    number_of_room integer
);


--
-- TOC entry 213 (class 1259 OID 17782)
-- Name: room_type_date_allotment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_date_allotment (
    room_type_id integer NOT NULL,
    date date NOT NULL,
    allotment integer NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 17785)
-- Name: room_type_date_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_date_rate (
    date date NOT NULL,
    rate numeric(10,2),
    extra_bed_rate numeric(10,2),
    net_rate numeric(10,2),
    rate_group_id integer NOT NULL,
    markup_percentage numeric(4,2),
    rate_message_id integer,
    commission_percentage numeric(4,2)
);


--
-- TOC entry 239 (class 1259 OID 18337)
-- Name: room_type_date_temp_lock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_date_temp_lock (
    id integer NOT NULL,
    room_type_id integer NOT NULL,
    session_id text NOT NULL,
    date date NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 17791)
-- Name: room_type_date_temp_lock1; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_date_temp_lock1 (
    id integer NOT NULL,
    room_type_id integer NOT NULL,
    booking_attempt_id integer NOT NULL,
    date date NOT NULL,
    lock_start timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    lock_end timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 216 (class 1259 OID 17796)
-- Name: room_type_date_temp_lock_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.room_type_date_temp_lock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 216
-- Name: room_type_date_temp_lock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_type_date_temp_lock_id_seq OWNED BY public.room_type_date_temp_lock1.id;


--
-- TOC entry 238 (class 1259 OID 18335)
-- Name: room_type_date_temp_lock_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.room_type_date_temp_lock_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 238
-- Name: room_type_date_temp_lock_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_type_date_temp_lock_id_seq1 OWNED BY public.room_type_date_temp_lock.id;


--
-- TOC entry 217 (class 1259 OID 17800)
-- Name: room_type_extra_bed_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_extra_bed_rate (
    room_type_id integer NOT NULL,
    rate numeric(10,2),
    rate_group_id integer NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 26545)
-- Name: room_type_facility; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_facility (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    facility character varying(200) NOT NULL,
    icon_url character varying(100),
    icon text
);


--
-- TOC entry 244 (class 1259 OID 26543)
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
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 244
-- Name: room_type_facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_type_facility_id_seq OWNED BY public.room_type_facility.id;


--
-- TOC entry 218 (class 1259 OID 17803)
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
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 218
-- Name: room_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_type_id_seq OWNED BY public.room_type.id;


--
-- TOC entry 219 (class 1259 OID 17805)
-- Name: room_type_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_image (
    id integer NOT NULL,
    room_type_id integer NOT NULL,
    priority integer,
    image_url text NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 17811)
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
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 220
-- Name: room_type_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_type_image_id_seq OWNED BY public.room_type_image.id;


--
-- TOC entry 272 (class 1259 OID 37326)
-- Name: room_type_promotion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type_promotion (
    room_type_id integer NOT NULL,
    promotion_id integer NOT NULL
);


--
-- TOC entry 237 (class 1259 OID 18314)
-- Name: session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session (
    id text NOT NULL,
    expiration_time timestamp without time zone,
    client_ip_address text,
    end_user_ip_address text,
    hotel_id integer
);


--
-- TOC entry 282 (class 1259 OID 37629)
-- Name: settlement_booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settlement_booking (
    settlement_request_id integer NOT NULL,
    booking_id integer NOT NULL
);


--
-- TOC entry 277 (class 1259 OID 37580)
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
-- TOC entry 276 (class 1259 OID 37578)
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
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 276
-- Name: settlement_confirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settlement_confirmation_id_seq OWNED BY public.settlement_confirmation.id;


--
-- TOC entry 275 (class 1259 OID 37567)
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
    hotel_bank_account_id integer
);


--
-- TOC entry 274 (class 1259 OID 37565)
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
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 274
-- Name: settlement_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settlement_request_id_seq OWNED BY public.settlement_request.id;


--
-- TOC entry 300 (class 1259 OID 54909)
-- Name: support_team; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.support_team (
    id integer NOT NULL,
    contact_info text
);


--
-- TOC entry 299 (class 1259 OID 54907)
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
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 299
-- Name: support_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.support_team_id_seq OWNED BY public.support_team.id;


--
-- TOC entry 221 (class 1259 OID 17822)
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
-- TOC entry 222 (class 1259 OID 17828)
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
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 222
-- Name: town_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.town_id_seq OWNED BY public.town.id;


--
-- TOC entry 223 (class 1259 OID 17830)
-- Name: user_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_account (
    id integer NOT NULL,
    email character varying(30) NOT NULL,
    password text,
    display_name text NOT NULL,
    is_super_admin boolean,
    is_active boolean,
    preferred_language character varying(7)
);


--
-- TOC entry 224 (class 1259 OID 17836)
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
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_account_id_seq OWNED BY public.user_account.id;


--
-- TOC entry 225 (class 1259 OID 17838)
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
-- TOC entry 226 (class 1259 OID 17845)
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
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 226
-- Name: user_activity_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_activity_log_id_seq OWNED BY public.user_activity_log.id;


--
-- TOC entry 301 (class 1259 OID 55163)
-- Name: vw_date_rate_statistics; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_date_rate_statistics AS
 WITH for_local AS (
         SELECT hotel.id AS hotel_id,
            rate_group_date_rate.date,
            min(
                CASE
                    WHEN ((rate_group.based_on_plan_id IS NULL) AND (rate_group_date_rate.rate IS NOT NULL)) THEN rate_group_date_rate.rate
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_percentage IS NOT NULL)) THEN round((rate_group_date_rate.rate + (rate_group_date_rate.rate * (rate_group.additional_percentage / (100)::numeric))), 2)
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_flat_amount IS NOT NULL)) THEN round((rate_group_date_rate.rate + rate_group.additional_flat_amount), 2)
                    ELSE NULL::numeric
                END) AS min_local,
            max(
                CASE
                    WHEN ((rate_group.based_on_plan_id IS NULL) AND (rate_group_date_rate.rate IS NOT NULL)) THEN rate_group_date_rate.rate
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_percentage IS NOT NULL)) THEN round((rate_group_date_rate.rate + (rate_group_date_rate.rate * (rate_group.additional_percentage / (100)::numeric))), 2)
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_flat_amount IS NOT NULL)) THEN round((rate_group_date_rate.rate + rate_group.additional_flat_amount), 2)
                    ELSE NULL::numeric
                END) AS max_local,
            sum(
                CASE
                    WHEN ((rate_group.based_on_plan_id IS NULL) AND (rate_group_date_rate.rate IS NOT NULL)) THEN rate_group_date_rate.rate
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_percentage IS NOT NULL)) THEN round((rate_group_date_rate.rate + (rate_group_date_rate.rate * (rate_group.additional_percentage / (100)::numeric))), 2)
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_flat_amount IS NOT NULL)) THEN round((rate_group_date_rate.rate + rate_group.additional_flat_amount), 2)
                    ELSE NULL::numeric
                END) AS sum_local
           FROM (((public.hotel
             LEFT JOIN public.room_type ON ((room_type.hotel_id = hotel.id)))
             LEFT JOIN public.rate_group ON (((rate_group.room_type_id = room_type.id) AND ((rate_group.guest_type = 'local'::text) OR (rate_group.guest_type = 'any'::text)))))
             LEFT JOIN public.rate_group_date_rate ON (
                CASE
                    WHEN ((rate_group.based_on_plan_id IS NULL) AND (rate_group_date_rate.rate IS NOT NULL)) THEN (rate_group_date_rate.rate_group_id = rate_group.id)
                    WHEN (rate_group.based_on_plan_id IS NOT NULL) THEN (rate_group_date_rate.rate_group_id = rate_group.based_on_plan_id)
                    ELSE NULL::boolean
                END))
          WHERE (rate_group_date_rate.date IS NOT NULL)
          GROUP BY hotel.id, rate_group_date_rate.date
          ORDER BY hotel.id, rate_group_date_rate.date
        ), for_foreigner AS (
         SELECT hotel.id AS hotel_id,
            rate_group_date_rate.date,
            min(
                CASE
                    WHEN ((rate_group.based_on_plan_id IS NULL) AND (rate_group_date_rate.rate IS NOT NULL)) THEN rate_group_date_rate.rate
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_percentage IS NOT NULL)) THEN round((rate_group_date_rate.rate + (rate_group_date_rate.rate * (rate_group.additional_percentage / (100)::numeric))), 2)
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_flat_amount IS NOT NULL)) THEN round((rate_group_date_rate.rate + rate_group.additional_flat_amount), 2)
                    ELSE NULL::numeric
                END) AS min_foreigner,
            max(
                CASE
                    WHEN ((rate_group.based_on_plan_id IS NULL) AND (rate_group_date_rate.rate IS NOT NULL)) THEN rate_group_date_rate.rate
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_percentage IS NOT NULL)) THEN round((rate_group_date_rate.rate + (rate_group_date_rate.rate * (rate_group.additional_percentage / (100)::numeric))), 2)
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_flat_amount IS NOT NULL)) THEN round((rate_group_date_rate.rate + rate_group.additional_flat_amount), 2)
                    ELSE NULL::numeric
                END) AS max_foreigner,
            sum(
                CASE
                    WHEN ((rate_group.based_on_plan_id IS NULL) AND (rate_group_date_rate.rate IS NOT NULL)) THEN rate_group_date_rate.rate
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_percentage IS NOT NULL)) THEN round((rate_group_date_rate.rate + (rate_group_date_rate.rate * (rate_group.additional_percentage / (100)::numeric))), 2)
                    WHEN ((rate_group.based_on_plan_id IS NOT NULL) AND (rate_group.additional_flat_amount IS NOT NULL)) THEN round((rate_group_date_rate.rate + rate_group.additional_flat_amount), 2)
                    ELSE NULL::numeric
                END) AS sum_foreigner
           FROM (((public.hotel
             LEFT JOIN public.room_type ON ((room_type.hotel_id = hotel.id)))
             LEFT JOIN public.rate_group ON (((rate_group.room_type_id = room_type.id) AND ((rate_group.guest_type = 'foreigner'::text) OR (rate_group.guest_type = 'any'::text)))))
             LEFT JOIN public.rate_group_date_rate ON (
                CASE
                    WHEN ((rate_group.based_on_plan_id IS NULL) AND (rate_group_date_rate.rate IS NOT NULL)) THEN (rate_group_date_rate.rate_group_id = rate_group.id)
                    WHEN (rate_group.based_on_plan_id IS NOT NULL) THEN (rate_group_date_rate.rate_group_id = rate_group.based_on_plan_id)
                    ELSE NULL::boolean
                END))
          WHERE (rate_group_date_rate.date IS NOT NULL)
          GROUP BY hotel.id, rate_group_date_rate.date
          ORDER BY hotel.id, rate_group_date_rate.date
        )
 SELECT
        CASE
            WHEN (fg.hotel_id IS NOT NULL) THEN fg.hotel_id
            WHEN (lc.hotel_id IS NOT NULL) THEN lc.hotel_id
            ELSE NULL::integer
        END AS hotel_id,
        CASE
            WHEN (lc.date IS NOT NULL) THEN lc.date
            WHEN (fg.date IS NOT NULL) THEN fg.date
            ELSE NULL::date
        END AS date,
    lc.min_local,
    lc.max_local,
    lc.sum_local,
    fg.min_foreigner,
    fg.max_foreigner,
    fg.sum_foreigner
   FROM (for_foreigner fg
     FULL JOIN for_local lc ON (((lc.hotel_id = fg.hotel_id) AND (lc.date = fg.date))));


--
-- TOC entry 291 (class 1259 OID 40730)
-- Name: vw_room_rate_allotment_statistics; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_room_rate_allotment_statistics AS
 WITH room_type_count AS (
         SELECT hotel.id,
            count(room_type.*) AS room_type_count
           FROM (public.room_type
             RIGHT JOIN public.hotel ON ((hotel.id = room_type.hotel_id)))
          GROUP BY hotel.id
        ), allotment_count AS (
         SELECT hotel.id,
            count(rda.*) AS allotment_count
           FROM ((public.room_type_date_allotment rda
             RIGHT JOIN public.room_type rt ON ((rt.id = rda.room_type_id)))
             RIGHT JOIN public.hotel ON ((hotel.id = rt.hotel_id)))
          GROUP BY hotel.id
        ), rate_count AS (
         SELECT hotel.id,
            count(dr.*) AS rate_count
           FROM (((public.rate_group_date_rate dr
             RIGHT JOIN public.rate_group rg ON ((rg.id = dr.rate_group_id)))
             RIGHT JOIN public.room_type rt ON ((rt.id = rg.room_type_id)))
             RIGHT JOIN public.hotel ON ((hotel.id = rt.hotel_id)))
          GROUP BY hotel.id
        )
 SELECT rtc.id AS hotel_id,
    rtc.room_type_count,
    rc.rate_count,
    alc.allotment_count
   FROM ((room_type_count rtc
     LEFT JOIN allotment_count alc ON ((alc.id = rtc.id)))
     LEFT JOIN rate_count rc ON ((rc.id = rtc.id)));


--
-- TOC entry 265 (class 1259 OID 34857)
-- Name: vw_room_type_availability; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_room_type_availability AS
 SELECT a.room_type_id,
    a.date,
    a.allotment,
    COALESCE(lt.total, (0)::bigint) AS total_locked,
    COALESCE(sd.total, (0)::bigint) AS total_sold,
    COALESCE(((a.allotment - COALESCE(lt.total, (0)::bigint)) - COALESCE(sd.total, (0)::bigint)), (0)::bigint) AS total_available
   FROM ((public.room_type_date_allotment a
     LEFT JOIN ( SELECT room_type_date_temp_lock.room_type_id,
            room_type_date_temp_lock.date,
            count(*) AS total
           FROM public.room_type_date_temp_lock,
            public.session
          WHERE ((session.expiration_time > CURRENT_TIMESTAMP) AND (session.id = room_type_date_temp_lock.session_id))
          GROUP BY room_type_date_temp_lock.room_type_id, room_type_date_temp_lock.date) lt ON (((a.room_type_id = lt.room_type_id) AND (a.date = lt.date))))
     LEFT JOIN ( SELECT booking_room.room_type_id,
            booking_room_rate.date,
            count(*) AS total
           FROM (public.booking_room_rate
             LEFT JOIN public.booking_room ON ((booking_room_rate.booking_room_id = booking_room.id)))
          GROUP BY booking_room.room_type_id, booking_room_rate.date) sd ON (((a.room_type_id = sd.room_type_id) AND (a.date = sd.date))));


--
-- TOC entry 3175 (class 2604 OID 17847)
-- Name: addon_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addon_type ALTER COLUMN id SET DEFAULT nextval('public.addon_type_id_seq'::regclass);


--
-- TOC entry 3192 (class 2604 OID 18125)
-- Name: agent id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent ALTER COLUMN id SET DEFAULT nextval('public.agent_id_seq'::regclass);


--
-- TOC entry 3194 (class 2604 OID 18161)
-- Name: agent_balance agent_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_balance ALTER COLUMN agent_id SET DEFAULT nextval('public.agent_balance_id_seq'::regclass);


--
-- TOC entry 3195 (class 2604 OID 18176)
-- Name: agent_hotel id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel ALTER COLUMN id SET DEFAULT nextval('public.agent_hotel_id_seq'::regclass);


--
-- TOC entry 3193 (class 2604 OID 18146)
-- Name: agent_transaction id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_transaction ALTER COLUMN id SET DEFAULT nextval('public.agent_transaction_id_seq'::regclass);


--
-- TOC entry 3197 (class 2604 OID 18356)
-- Name: array_testing id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.array_testing ALTER COLUMN id SET DEFAULT nextval('public.array_testing_id_seq'::regclass);


--
-- TOC entry 3176 (class 2604 OID 17848)
-- Name: attraction id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attraction ALTER COLUMN id SET DEFAULT nextval('public.attraction_id_seq'::regclass);


--
-- TOC entry 3215 (class 2604 OID 37624)
-- Name: bank id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank ALTER COLUMN id SET DEFAULT nextval('public.bank_id_seq'::regclass);


--
-- TOC entry 3216 (class 2604 OID 39534)
-- Name: bed_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bed_type ALTER COLUMN id SET DEFAULT nextval('public.bed_type_id_seq'::regclass);


--
-- TOC entry 3177 (class 2604 OID 17849)
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- TOC entry 3178 (class 2604 OID 17850)
-- Name: booking_attempt id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt ALTER COLUMN id SET DEFAULT nextval('public.booking_attempt_id_seq'::regclass);


--
-- TOC entry 3223 (class 2604 OID 55188)
-- Name: booking_attempt_failed_record id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_failed_record ALTER COLUMN id SET DEFAULT nextval('public.booking_attempt_failed_record_id_seq'::regclass);


--
-- TOC entry 3205 (class 2604 OID 26698)
-- Name: booking_attempt_room id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_room ALTER COLUMN id SET DEFAULT nextval('public.booking_attempt_room_id_seq'::regclass);


--
-- TOC entry 3206 (class 2604 OID 26721)
-- Name: booking_attempt_room_rate id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_room_rate ALTER COLUMN id SET DEFAULT nextval('public.booking_attempt_date_rate_id_seq'::regclass);


--
-- TOC entry 3217 (class 2604 OID 40416)
-- Name: booking_confirmation_attempt id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_confirmation_attempt ALTER COLUMN id SET DEFAULT nextval('public.booking_confirmation_attempt_id_seq'::regclass);


--
-- TOC entry 3207 (class 2604 OID 26734)
-- Name: booking_room id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_room ALTER COLUMN id SET DEFAULT nextval('public.booking_room_id_seq'::regclass);


--
-- TOC entry 3203 (class 2604 OID 26652)
-- Name: booking_room_rate id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_room_rate ALTER COLUMN id SET DEFAULT nextval('public.booking_room_date_rate_id_seq'::regclass);


--
-- TOC entry 3179 (class 2604 OID 17854)
-- Name: customer id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer ALTER COLUMN id SET DEFAULT nextval('public.customer_id_seq'::regclass);


--
-- TOC entry 3180 (class 2604 OID 17855)
-- Name: gateway_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gateway_type ALTER COLUMN id SET DEFAULT nextval('public.gateway_type_id_seq'::regclass);


--
-- TOC entry 3204 (class 2604 OID 26665)
-- Name: guest id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guest ALTER COLUMN id SET DEFAULT nextval('public.guest_id_seq'::regclass);


--
-- TOC entry 3181 (class 2604 OID 17856)
-- Name: hotel id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel ALTER COLUMN id SET DEFAULT nextval('public.hotel_id_seq'::regclass);


--
-- TOC entry 3198 (class 2604 OID 18367)
-- Name: hotel_amenity id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_amenity ALTER COLUMN id SET DEFAULT nextval('public.hotel_amenity_id_seq'::regclass);


--
-- TOC entry 3214 (class 2604 OID 37614)
-- Name: hotel_bank_account id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account ALTER COLUMN id SET DEFAULT nextval('public.hotel_bank_account_id_seq'::regclass);


--
-- TOC entry 3218 (class 2604 OID 40537)
-- Name: hotel_bank_account_approvement id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account_approvement ALTER COLUMN id SET DEFAULT nextval('public.hotel_bank_account_approvement_id_seq'::regclass);


--
-- TOC entry 3226 (class 2604 OID 56175)
-- Name: hotel_bank_account_docs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account_docs ALTER COLUMN id SET DEFAULT nextval('public.hotel_bank_account_docs_id_seq'::regclass);


--
-- TOC entry 3224 (class 2604 OID 55369)
-- Name: hotel_contact_person id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_contact_person ALTER COLUMN id SET DEFAULT nextval('public.hotel_contact_person_id_seq'::regclass);


--
-- TOC entry 3201 (class 2604 OID 26593)
-- Name: hotel_content hotel_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_content ALTER COLUMN hotel_id SET DEFAULT nextval('public.hotel_content_hotel_id_seq'::regclass);


--
-- TOC entry 3202 (class 2604 OID 26604)
-- Name: hotel_image id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_image ALTER COLUMN id SET DEFAULT nextval('public.hotel_image_id_seq'::regclass);


--
-- TOC entry 3191 (class 2604 OID 18100)
-- Name: hotel_to_attraction id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction ALTER COLUMN id SET DEFAULT nextval('public.hotel_to_attraction_id_seq'::regclass);


--
-- TOC entry 3225 (class 2604 OID 55433)
-- Name: login_record id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_record ALTER COLUMN id SET DEFAULT nextval('public.login_record_id_seq'::regclass);


--
-- TOC entry 3220 (class 2604 OID 52870)
-- Name: message id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- TOC entry 3221 (class 2604 OID 52891)
-- Name: message_read id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read ALTER COLUMN id SET DEFAULT nextval('public.message_read_id_seq'::regclass);


--
-- TOC entry 3219 (class 2604 OID 51244)
-- Name: password_setter_token_status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_setter_token_status ALTER COLUMN id SET DEFAULT nextval('public.password_setting_token_log_id_seq'::regclass);


--
-- TOC entry 3208 (class 2604 OID 34839)
-- Name: payment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment ALTER COLUMN id SET DEFAULT nextval('public.payment_id_seq'::regclass);


--
-- TOC entry 3211 (class 2604 OID 37230)
-- Name: promotion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion ALTER COLUMN id SET DEFAULT nextval('public.date_range_promotion_id_seq'::regclass);


--
-- TOC entry 3200 (class 2604 OID 26573)
-- Name: rate_group id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_group ALTER COLUMN id SET DEFAULT nextval('public.rate_group_id_seq'::regclass);


--
-- TOC entry 3210 (class 2604 OID 37212)
-- Name: rate_message id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_message ALTER COLUMN id SET DEFAULT nextval('public.rate_message_id_seq'::regclass);


--
-- TOC entry 3182 (class 2604 OID 17857)
-- Name: room_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type ALTER COLUMN id SET DEFAULT nextval('public.room_type_id_seq'::regclass);


--
-- TOC entry 3196 (class 2604 OID 18340)
-- Name: room_type_date_temp_lock id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_temp_lock ALTER COLUMN id SET DEFAULT nextval('public.room_type_date_temp_lock_id_seq1'::regclass);


--
-- TOC entry 3185 (class 2604 OID 17859)
-- Name: room_type_date_temp_lock1 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_temp_lock1 ALTER COLUMN id SET DEFAULT nextval('public.room_type_date_temp_lock_id_seq'::regclass);


--
-- TOC entry 3199 (class 2604 OID 26548)
-- Name: room_type_facility id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_facility ALTER COLUMN id SET DEFAULT nextval('public.room_type_facility_id_seq'::regclass);


--
-- TOC entry 3186 (class 2604 OID 17860)
-- Name: room_type_image id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_image ALTER COLUMN id SET DEFAULT nextval('public.room_type_image_id_seq'::regclass);


--
-- TOC entry 3213 (class 2604 OID 37583)
-- Name: settlement_confirmation id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_confirmation ALTER COLUMN id SET DEFAULT nextval('public.settlement_confirmation_id_seq'::regclass);


--
-- TOC entry 3212 (class 2604 OID 37570)
-- Name: settlement_request id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_request ALTER COLUMN id SET DEFAULT nextval('public.settlement_request_id_seq'::regclass);


--
-- TOC entry 3222 (class 2604 OID 54912)
-- Name: support_team id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_team ALTER COLUMN id SET DEFAULT nextval('public.support_team_id_seq'::regclass);


--
-- TOC entry 3187 (class 2604 OID 17862)
-- Name: town id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.town ALTER COLUMN id SET DEFAULT nextval('public.town_id_seq'::regclass);


--
-- TOC entry 3209 (class 2604 OID 34897)
-- Name: township id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.township ALTER COLUMN id SET DEFAULT nextval('public.region_id_seq'::regclass);


--
-- TOC entry 3188 (class 2604 OID 17863)
-- Name: user_account id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account ALTER COLUMN id SET DEFAULT nextval('public.user_account_id_seq'::regclass);


--
-- TOC entry 3190 (class 2604 OID 17864)
-- Name: user_activity_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_activity_log ALTER COLUMN id SET DEFAULT nextval('public.user_activity_log_id_seq'::regclass);


--
-- TOC entry 3244 (class 2606 OID 17886)
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (id);


--
-- TOC entry 3314 (class 2606 OID 34902)
-- Name: township region_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.township
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- TOC entry 3258 (class 2606 OID 17908)
-- Name: town town_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.town
    ADD CONSTRAINT town_pkey PRIMARY KEY (id);


--
-- TOC entry 304 (class 1259 OID 55324)
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
    hotel.latitude,
    hotel.longitude,
    hotel.commission_percentage,
    hotel.max_child_age,
    hotel.property_type,
    string_agg(DISTINCT hotel_image.image_url, '<>'::text) AS image_urls,
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
-- TOC entry 3296 (class 2606 OID 26598)
-- Name: hotel_content ID_PKEY; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_content
    ADD CONSTRAINT "ID_PKEY" PRIMARY KEY (hotel_id, language);


--
-- TOC entry 3228 (class 2606 OID 17866)
-- Name: addon_type addon_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addon_type
    ADD CONSTRAINT addon_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3274 (class 2606 OID 18163)
-- Name: agent_balance agent_balance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_balance
    ADD CONSTRAINT agent_balance_pkey PRIMARY KEY (agent_id);


--
-- TOC entry 3276 (class 2606 OID 18218)
-- Name: agent_hotel agent_hotel_agent_id_hotel_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel
    ADD CONSTRAINT agent_hotel_agent_id_hotel_id_key UNIQUE (agent_id, hotel_id);


--
-- TOC entry 3278 (class 2606 OID 18181)
-- Name: agent_hotel agent_hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel
    ADD CONSTRAINT agent_hotel_pkey PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 18130)
-- Name: agent agent_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_pkey PRIMARY KEY (id);


--
-- TOC entry 3272 (class 2606 OID 18148)
-- Name: agent_transaction agent_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_transaction
    ADD CONSTRAINT agent_transaction_pkey PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 18361)
-- Name: array_testing array_testing_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.array_testing
    ADD CONSTRAINT array_testing_pkey PRIMARY KEY (id);


--
-- TOC entry 3230 (class 2606 OID 17868)
-- Name: attraction attraction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attraction
    ADD CONSTRAINT attraction_pkey PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 37628)
-- Name: bank bank_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank
    ADD CONSTRAINT bank_name_key UNIQUE (full_name);


--
-- TOC entry 3336 (class 2606 OID 37626)
-- Name: bank bank_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank
    ADD CONSTRAINT bank_pkey PRIMARY KEY (id);


--
-- TOC entry 3342 (class 2606 OID 39536)
-- Name: bed_type bed_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bed_type
    ADD CONSTRAINT bed_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 26723)
-- Name: booking_attempt_room_rate booking_attempt_date_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_room_rate
    ADD CONSTRAINT booking_attempt_date_rate_pkey PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 55190)
-- Name: booking_attempt_failed_record booking_attempt_failed_record_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_failed_record
    ADD CONSTRAINT booking_attempt_failed_record_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 17872)
-- Name: booking_attempt booking_attempt_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt
    ADD CONSTRAINT booking_attempt_pkey PRIMARY KEY (id);


--
-- TOC entry 3304 (class 2606 OID 26700)
-- Name: booking_attempt_room booking_attempt_room_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_room
    ADD CONSTRAINT booking_attempt_room_pkey PRIMARY KEY (id);


--
-- TOC entry 3344 (class 2606 OID 40418)
-- Name: booking_confirmation_attempt booking_confirmation_attempt_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_confirmation_attempt
    ADD CONSTRAINT booking_confirmation_attempt_pkey PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 26741)
-- Name: booking_date_room_type booking_date_room_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_date_room_type
    ADD CONSTRAINT booking_date_room_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 17878)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- TOC entry 3300 (class 2606 OID 26654)
-- Name: booking_room_rate booking_room_date_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_room_rate
    ADD CONSTRAINT booking_room_date_rate_pkey PRIMARY KEY (id);


--
-- TOC entry 3308 (class 2606 OID 26736)
-- Name: booking_room booking_room_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_room
    ADD CONSTRAINT booking_room_pkey PRIMARY KEY (id);


--
-- TOC entry 3238 (class 2606 OID 17880)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- TOC entry 3320 (class 2606 OID 37235)
-- Name: promotion date_range_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promotion
    ADD CONSTRAINT date_range_promotion_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 17882)
-- Name: gateway_type gateway_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gateway_type
    ADD CONSTRAINT gateway_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 26670)
-- Name: guest guest_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_pkey PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 18371)
-- Name: hotel_amenity hotel_amenity_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_amenity
    ADD CONSTRAINT hotel_amenity_code_key UNIQUE (code);


--
-- TOC entry 3288 (class 2606 OID 18369)
-- Name: hotel_amenity hotel_amenity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_amenity
    ADD CONSTRAINT hotel_amenity_pkey PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 40539)
-- Name: hotel_bank_account_approvement hotel_bank_account_approvement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account_approvement
    ADD CONSTRAINT hotel_bank_account_approvement_pkey PRIMARY KEY (id);


--
-- TOC entry 3366 (class 2606 OID 56180)
-- Name: hotel_bank_account_docs hotel_bank_account_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account_docs
    ADD CONSTRAINT hotel_bank_account_docs_pkey PRIMARY KEY (id);


--
-- TOC entry 3330 (class 2606 OID 37618)
-- Name: hotel_bank_account hotel_bank_account_hotel_id_account_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account
    ADD CONSTRAINT hotel_bank_account_hotel_id_account_number_key UNIQUE (hotel_id, account_number);


--
-- TOC entry 3332 (class 2606 OID 37616)
-- Name: hotel_bank_account hotel_bank_account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account
    ADD CONSTRAINT hotel_bank_account_pkey PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 17884)
-- Name: hotel hotel_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_code_key UNIQUE (code);


--
-- TOC entry 3362 (class 2606 OID 55374)
-- Name: hotel_contact_person hotel_contact_person_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_contact_person
    ADD CONSTRAINT hotel_contact_person_pkey PRIMARY KEY (id);


--
-- TOC entry 3298 (class 2606 OID 26609)
-- Name: hotel_image hotel_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_image
    ADD CONSTRAINT hotel_image_pkey PRIMARY KEY (id);


--
-- TOC entry 3348 (class 2606 OID 40923)
-- Name: hotel_initial_approval hotel_initial_approval_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_initial_approval
    ADD CONSTRAINT hotel_initial_approval_pkey PRIMARY KEY (hotel_id);


--
-- TOC entry 3266 (class 2606 OID 18107)
-- Name: hotel_to_attraction hotel_to_attraction_hotel_id_attraction_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction
    ADD CONSTRAINT hotel_to_attraction_hotel_id_attraction_id_key UNIQUE (hotel_id, attraction_id);


--
-- TOC entry 3268 (class 2606 OID 18105)
-- Name: hotel_to_attraction hotel_to_attraction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction
    ADD CONSTRAINT hotel_to_attraction_pkey PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 38340)
-- Name: hotel_user_role hotel_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_user_role
    ADD CONSTRAINT hotel_user_role_pkey PRIMARY KEY (hotel_id, user_id);


--
-- TOC entry 3364 (class 2606 OID 55435)
-- Name: login_record login_record_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_record
    ADD CONSTRAINT login_record_pkey PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 52875)
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- TOC entry 3356 (class 2606 OID 52893)
-- Name: message_read message_read_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read
    ADD CONSTRAINT message_read_pkey PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2606 OID 51249)
-- Name: password_setter_token_status password_setting_token_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_setter_token_status
    ADD CONSTRAINT password_setting_token_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3352 (class 2606 OID 51251)
-- Name: password_setter_token_status password_setting_token_log_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_setter_token_status
    ADD CONSTRAINT password_setting_token_log_token_key UNIQUE (token);


--
-- TOC entry 3246 (class 2606 OID 17888)
-- Name: payment_migs_gateway payment_migs_gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_migs_gateway
    ADD CONSTRAINT payment_migs_gateway_pkey PRIMARY KEY (hotel_id);


--
-- TOC entry 3312 (class 2606 OID 34841)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 3324 (class 2606 OID 37335)
-- Name: rate_group_date_rate rate_group_date_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_group_date_rate
    ADD CONSTRAINT rate_group_date_rate_pkey PRIMARY KEY (rate_group_id, date);


--
-- TOC entry 3294 (class 2606 OID 26575)
-- Name: rate_group rate_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_group
    ADD CONSTRAINT rate_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3316 (class 2606 OID 37219)
-- Name: rate_message rate_message_message_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_message
    ADD CONSTRAINT rate_message_message_key UNIQUE (message);


--
-- TOC entry 3318 (class 2606 OID 37217)
-- Name: rate_message rate_message_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_message
    ADD CONSTRAINT rate_message_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 2606 OID 17892)
-- Name: room_type_date_allotment room_type_date_allotment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_allotment
    ADD CONSTRAINT room_type_date_allotment_pkey PRIMARY KEY (room_type_id, date);


--
-- TOC entry 3252 (class 2606 OID 17896)
-- Name: room_type_date_temp_lock1 room_type_date_temp_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_temp_lock1
    ADD CONSTRAINT room_type_date_temp_lock_pkey PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 18345)
-- Name: room_type_date_temp_lock room_type_date_temp_lock_pkey1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_temp_lock
    ADD CONSTRAINT room_type_date_temp_lock_pkey1 PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 34919)
-- Name: room_type_extra_bed_rate room_type_extra_bed_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_extra_bed_rate
    ADD CONSTRAINT room_type_extra_bed_rate_pkey PRIMARY KEY (room_type_id, rate_group_id);


--
-- TOC entry 3290 (class 2606 OID 26552)
-- Name: room_type_facility room_type_facility_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_facility
    ADD CONSTRAINT room_type_facility_code_key UNIQUE (code);


--
-- TOC entry 3292 (class 2606 OID 26550)
-- Name: room_type_facility room_type_facility_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_facility
    ADD CONSTRAINT room_type_facility_pkey PRIMARY KEY (id);


--
-- TOC entry 3256 (class 2606 OID 17902)
-- Name: room_type_image room_type_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_image
    ADD CONSTRAINT room_type_image_pkey PRIMARY KEY (id);


--
-- TOC entry 3248 (class 2606 OID 17904)
-- Name: room_type room_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type
    ADD CONSTRAINT room_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3322 (class 2606 OID 37330)
-- Name: room_type_promotion room_type_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_promotion
    ADD CONSTRAINT room_type_promotion_pkey PRIMARY KEY (room_type_id, promotion_id);


--
-- TOC entry 3280 (class 2606 OID 18321)
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 37633)
-- Name: settlement_booking settlement_booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_booking
    ADD CONSTRAINT settlement_booking_pkey PRIMARY KEY (settlement_request_id, booking_id);


--
-- TOC entry 3328 (class 2606 OID 37585)
-- Name: settlement_confirmation settlement_confirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_confirmation
    ADD CONSTRAINT settlement_confirmation_pkey PRIMARY KEY (id);


--
-- TOC entry 3326 (class 2606 OID 37572)
-- Name: settlement_request settlement_request_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_request
    ADD CONSTRAINT settlement_request_pkey PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 54917)
-- Name: support_team support_team_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_team
    ADD CONSTRAINT support_team_pkey PRIMARY KEY (id);


--
-- TOC entry 3260 (class 2606 OID 17910)
-- Name: user_account user_account_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_email_key UNIQUE (email);


--
-- TOC entry 3262 (class 2606 OID 17912)
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);


--
-- TOC entry 3264 (class 2606 OID 17914)
-- Name: user_activity_log user_activity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_activity_log
    ADD CONSTRAINT user_activity_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3233 (class 1259 OID 37688)
-- Name: checkin_date_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX checkin_date_index ON public.booking USING btree (checkin_date);


--
-- TOC entry 3234 (class 1259 OID 40791)
-- Name: created_date_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX created_date_index ON public.booking USING btree (created_date);


--
-- TOC entry 3367 (class 2606 OID 17915)
-- Name: addon_type addon_type_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addon_type
    ADD CONSTRAINT addon_type_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3390 (class 2606 OID 18131)
-- Name: agent agent_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.user_account(id);


--
-- TOC entry 3393 (class 2606 OID 18182)
-- Name: agent_hotel agent_hotel_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel
    ADD CONSTRAINT agent_hotel_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(id);


--
-- TOC entry 3394 (class 2606 OID 18187)
-- Name: agent_hotel agent_hotel_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_hotel
    ADD CONSTRAINT agent_hotel_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3391 (class 2606 OID 18136)
-- Name: agent agent_modifier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_modifier_id_fkey FOREIGN KEY (modifier_id) REFERENCES public.user_account(id);


--
-- TOC entry 3392 (class 2606 OID 18149)
-- Name: agent_transaction agent_transaction_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_transaction
    ADD CONSTRAINT agent_transaction_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(id);


--
-- TOC entry 3368 (class 2606 OID 17920)
-- Name: attraction attraction_town_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attraction
    ADD CONSTRAINT attraction_town_id_fkey FOREIGN KEY (town_id) REFERENCES public.town(id);


--
-- TOC entry 3404 (class 2606 OID 26742)
-- Name: booking_date_room_type booking_attempt_and_booking_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_date_room_type
    ADD CONSTRAINT booking_attempt_and_booking_fk FOREIGN KEY (booking_id) REFERENCES public.booking(id);


--
-- TOC entry 3434 (class 2606 OID 55191)
-- Name: booking_attempt_failed_record booking_attempt_failed_record_booking_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_failed_record
    ADD CONSTRAINT booking_attempt_failed_record_booking_attempt_id_fkey FOREIGN KEY (booking_attempt_id) REFERENCES public.booking_attempt(id) ON DELETE CASCADE;


--
-- TOC entry 3372 (class 2606 OID 17940)
-- Name: booking_attempt booking_attempt_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt
    ADD CONSTRAINT booking_attempt_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3399 (class 2606 OID 26701)
-- Name: booking_attempt_room booking_attempt_room_booking_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_room
    ADD CONSTRAINT booking_attempt_room_booking_attempt_id_fkey FOREIGN KEY (booking_attempt_id) REFERENCES public.booking_attempt(id);


--
-- TOC entry 3401 (class 2606 OID 26711)
-- Name: booking_attempt_room booking_attempt_room_rate_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_room
    ADD CONSTRAINT booking_attempt_room_rate_group_id_fkey FOREIGN KEY (rate_group_id) REFERENCES public.rate_group(id);


--
-- TOC entry 3400 (class 2606 OID 26706)
-- Name: booking_attempt_room booking_attempt_room_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_room
    ADD CONSTRAINT booking_attempt_room_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3402 (class 2606 OID 37560)
-- Name: booking_attempt_room booking_attempt_room_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_attempt_room
    ADD CONSTRAINT booking_attempt_room_type_fk FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3421 (class 2606 OID 40419)
-- Name: booking_confirmation_attempt booking_confirmation_attempt_booking_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_confirmation_attempt
    ADD CONSTRAINT booking_confirmation_attempt_booking_attempt_id_fkey FOREIGN KEY (booking_attempt_id) REFERENCES public.booking_attempt(id);


--
-- TOC entry 3369 (class 2606 OID 17950)
-- Name: booking booking_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- TOC entry 3370 (class 2606 OID 17970)
-- Name: booking booking_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3371 (class 2606 OID 34847)
-- Name: booking booking_payment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.payment(id);


--
-- TOC entry 3403 (class 2606 OID 37555)
-- Name: booking_room booking_room_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_room
    ADD CONSTRAINT booking_room_type_fk FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3373 (class 2606 OID 17975)
-- Name: hotel fk_townid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT fk_townid FOREIGN KEY (town_id) REFERENCES public.town(id);


--
-- TOC entry 3423 (class 2606 OID 40545)
-- Name: hotel_bank_account_approvement hotel_bank_account_approvement_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account_approvement
    ADD CONSTRAINT hotel_bank_account_approvement_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.user_account(id);


--
-- TOC entry 3422 (class 2606 OID 40540)
-- Name: hotel_bank_account_approvement hotel_bank_account_approvement_hotel_bank_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account_approvement
    ADD CONSTRAINT hotel_bank_account_approvement_hotel_bank_account_id_fkey FOREIGN KEY (hotel_bank_account_id) REFERENCES public.hotel_bank_account(id);


--
-- TOC entry 3412 (class 2606 OID 37646)
-- Name: hotel_bank_account hotel_bank_account_bank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account
    ADD CONSTRAINT hotel_bank_account_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES public.bank(id);


--
-- TOC entry 3413 (class 2606 OID 40550)
-- Name: hotel_bank_account hotel_bank_account_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account
    ADD CONSTRAINT hotel_bank_account_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- TOC entry 3436 (class 2606 OID 56181)
-- Name: hotel_bank_account_docs hotel_bank_account_docs_bank_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account_docs
    ADD CONSTRAINT hotel_bank_account_docs_bank_account_id_fkey FOREIGN KEY (bank_account_id) REFERENCES public.hotel_bank_account(id);


--
-- TOC entry 3437 (class 2606 OID 56186)
-- Name: hotel_bank_account_docs hotel_bank_account_docs_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account_docs
    ADD CONSTRAINT hotel_bank_account_docs_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- TOC entry 3414 (class 2606 OID 56116)
-- Name: hotel_bank_account hotel_bank_account_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_bank_account
    ADD CONSTRAINT hotel_bank_account_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.user_account(id);


--
-- TOC entry 3435 (class 2606 OID 55375)
-- Name: hotel_contact_person hotel_contact_person_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_contact_person
    ADD CONSTRAINT hotel_contact_person_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3375 (class 2606 OID 52672)
-- Name: hotel hotel_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- TOC entry 3398 (class 2606 OID 26610)
-- Name: hotel_image hotel_image_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_image
    ADD CONSTRAINT hotel_image_fk FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3424 (class 2606 OID 40924)
-- Name: hotel_initial_approval hotel_initial_approval_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_initial_approval
    ADD CONSTRAINT hotel_initial_approval_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3425 (class 2606 OID 40929)
-- Name: hotel_initial_approval hotel_initial_approval_super_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_initial_approval
    ADD CONSTRAINT hotel_initial_approval_super_admin_id_fkey FOREIGN KEY (super_admin_id) REFERENCES public.user_account(id);


--
-- TOC entry 3374 (class 2606 OID 34908)
-- Name: hotel hotel_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_region_id_fkey FOREIGN KEY (township_id) REFERENCES public.township(id);


--
-- TOC entry 3395 (class 2606 OID 26621)
-- Name: session hotel_session_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT hotel_session_fk FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3389 (class 2606 OID 18113)
-- Name: hotel_to_attraction hotel_to_attraction_attraction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction
    ADD CONSTRAINT hotel_to_attraction_attraction_id_fkey FOREIGN KEY (attraction_id) REFERENCES public.attraction(id);


--
-- TOC entry 3388 (class 2606 OID 18108)
-- Name: hotel_to_attraction hotel_to_attraction_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_to_attraction
    ADD CONSTRAINT hotel_to_attraction_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3417 (class 2606 OID 38329)
-- Name: hotel_user_role hotel_user_role_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_user_role
    ADD CONSTRAINT hotel_user_role_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3418 (class 2606 OID 38334)
-- Name: hotel_user_role hotel_user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotel_user_role
    ADD CONSTRAINT hotel_user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_account(id);


--
-- TOC entry 3430 (class 2606 OID 52909)
-- Name: message message_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id);


--
-- TOC entry 3429 (class 2606 OID 52881)
-- Name: message message_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.user_account(id);


--
-- TOC entry 3428 (class 2606 OID 52876)
-- Name: message message_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3432 (class 2606 OID 52899)
-- Name: message_read message_read_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read
    ADD CONSTRAINT message_read_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3431 (class 2606 OID 52894)
-- Name: message_read message_read_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read
    ADD CONSTRAINT message_read_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.message(id);


--
-- TOC entry 3433 (class 2606 OID 52904)
-- Name: message_read message_read_reader_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_read
    ADD CONSTRAINT message_read_reader_id_fkey FOREIGN KEY (reader_id) REFERENCES public.user_account(id);


--
-- TOC entry 3426 (class 2606 OID 51252)
-- Name: password_setter_token_status password_setting_token_log_token_creator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_setter_token_status
    ADD CONSTRAINT password_setting_token_log_token_creator_fkey FOREIGN KEY (token_creator) REFERENCES public.user_account(id);


--
-- TOC entry 3427 (class 2606 OID 51257)
-- Name: password_setter_token_status password_setting_token_log_token_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_setter_token_status
    ADD CONSTRAINT password_setting_token_log_token_user_fkey FOREIGN KEY (token_user) REFERENCES public.user_account(id);


--
-- TOC entry 3405 (class 2606 OID 34842)
-- Name: payment payment_gateway_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_gateway_type_id_fkey FOREIGN KEY (gateway_type_id) REFERENCES public.gateway_type(id);


--
-- TOC entry 3376 (class 2606 OID 17990)
-- Name: payment_migs_gateway payment_migs_gateway_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_migs_gateway
    ADD CONSTRAINT payment_migs_gateway_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3397 (class 2606 OID 37241)
-- Name: rate_group rate_group_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_group
    ADD CONSTRAINT rate_group_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3406 (class 2606 OID 34903)
-- Name: township region_town_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.township
    ADD CONSTRAINT region_town_id_fkey FOREIGN KEY (town_id) REFERENCES public.town(id);


--
-- TOC entry 3420 (class 2606 OID 39545)
-- Name: room_bed_count room_bed_count_bed_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_bed_count
    ADD CONSTRAINT room_bed_count_bed_type_id_fkey FOREIGN KEY (bed_type_id) REFERENCES public.bed_type(id);


--
-- TOC entry 3419 (class 2606 OID 39540)
-- Name: room_bed_count room_bed_count_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_bed_count
    ADD CONSTRAINT room_bed_count_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3378 (class 2606 OID 17995)
-- Name: room_type_date_allotment room_type_date_allotment_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_allotment
    ADD CONSTRAINT room_type_date_allotment_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3379 (class 2606 OID 26580)
-- Name: room_type_date_rate room_type_date_rate_rate_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_rate
    ADD CONSTRAINT room_type_date_rate_rate_group_fkey FOREIGN KEY (rate_group_id) REFERENCES public.rate_group(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3380 (class 2606 OID 37220)
-- Name: room_type_date_rate room_type_date_rate_rate_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_rate
    ADD CONSTRAINT room_type_date_rate_rate_message_id_fkey FOREIGN KEY (rate_message_id) REFERENCES public.rate_message(id);


--
-- TOC entry 3381 (class 2606 OID 18005)
-- Name: room_type_date_temp_lock1 room_type_date_temp_lock_booking_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_temp_lock1
    ADD CONSTRAINT room_type_date_temp_lock_booking_attempt_id_fkey FOREIGN KEY (booking_attempt_id) REFERENCES public.booking_attempt(id);


--
-- TOC entry 3382 (class 2606 OID 18010)
-- Name: room_type_date_temp_lock1 room_type_date_temp_lock_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_temp_lock1
    ADD CONSTRAINT room_type_date_temp_lock_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3396 (class 2606 OID 18346)
-- Name: room_type_date_temp_lock room_type_date_temp_lock_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_date_temp_lock
    ADD CONSTRAINT room_type_date_temp_lock_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.session(id);


--
-- TOC entry 3384 (class 2606 OID 34913)
-- Name: room_type_extra_bed_rate room_type_extra_bed_rate_rate_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_extra_bed_rate
    ADD CONSTRAINT room_type_extra_bed_rate_rate_group_id_fkey FOREIGN KEY (rate_group_id) REFERENCES public.rate_group(id);


--
-- TOC entry 3383 (class 2606 OID 18025)
-- Name: room_type_extra_bed_rate room_type_extra_bed_rate_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_extra_bed_rate
    ADD CONSTRAINT room_type_extra_bed_rate_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3407 (class 2606 OID 37336)
-- Name: room_type_promotion room_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_promotion
    ADD CONSTRAINT room_type_fk FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3377 (class 2606 OID 18030)
-- Name: room_type room_type_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type
    ADD CONSTRAINT room_type_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3385 (class 2606 OID 18035)
-- Name: room_type_image room_type_image_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type_image
    ADD CONSTRAINT room_type_image_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(id);


--
-- TOC entry 3416 (class 2606 OID 37639)
-- Name: settlement_booking settlement_booking_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_booking
    ADD CONSTRAINT settlement_booking_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id);


--
-- TOC entry 3415 (class 2606 OID 37634)
-- Name: settlement_booking settlement_booking_settlement_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_booking
    ADD CONSTRAINT settlement_booking_settlement_request_id_fkey FOREIGN KEY (settlement_request_id) REFERENCES public.settlement_request(id);


--
-- TOC entry 3411 (class 2606 OID 37591)
-- Name: settlement_confirmation settlement_confirmation_modifier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_confirmation
    ADD CONSTRAINT settlement_confirmation_modifier_id_fkey FOREIGN KEY (modifier_id) REFERENCES public.user_account(id);


--
-- TOC entry 3410 (class 2606 OID 37586)
-- Name: settlement_confirmation settlement_confirmation_settlement_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_confirmation
    ADD CONSTRAINT settlement_confirmation_settlement_request_id_fkey FOREIGN KEY (settlement_request_id) REFERENCES public.settlement_request(id);


--
-- TOC entry 3408 (class 2606 OID 37573)
-- Name: settlement_request settlement_request_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_request
    ADD CONSTRAINT settlement_request_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.user_account(id);


--
-- TOC entry 3409 (class 2606 OID 37651)
-- Name: settlement_request settlement_request_hotel_bank_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlement_request
    ADD CONSTRAINT settlement_request_hotel_bank_account_id_fkey FOREIGN KEY (hotel_bank_account_id) REFERENCES public.hotel_bank_account(id);


--
-- TOC entry 3386 (class 2606 OID 18040)
-- Name: user_activity_log user_activity_log_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_activity_log
    ADD CONSTRAINT user_activity_log_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);


--
-- TOC entry 3387 (class 2606 OID 18045)
-- Name: user_activity_log user_activity_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_activity_log
    ADD CONSTRAINT user_activity_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_account(id);


--
-- TOC entry 3564 (class 3256 OID 72522)
-- Name: room_type p1; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY p1 ON public.room_type USING ((hotel_id = (current_setting('app.hotel_id'::text))::integer)) WITH CHECK ((hotel_id = (current_setting('app.hotel_id'::text))::integer));


--
-- TOC entry 3563 (class 0 OID 17775)
-- Dependencies: 212
-- Name: room_type; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.room_type ENABLE ROW LEVEL SECURITY;

-- Completed on 2021-01-06 16:09:37

--
-- PostgreSQL database dump complete
--

With return_id as(
INSERT INTO public.town (name_en, name_mm, description_en, description_mm, image_url, latitude, longitude, name_mm_soundex)
VALUES
    ('Yangon', 'ရန်ကုန်', 'Commercial City', NULL, NULL, 16.7714650407435464, 96.1466145782958392, 'Y_AN K_OME')
    RETURNING id
)
INSERT INTO public.township(name_en, name_mm, description_en, description_mm, image_url, town_id, latitude, longitude, name_mm_soundex)
VALUES
('Insein', 'အင်းစိန်', NULL, NULL, NULL, (SELECT id from return_id), 16.9017699999999991, 96.0959600000000052, 'Ah_IN S_AIN'),
('Ahlone', 'အလုံ', NULL, NULL, NULL, (SELECT id from return_id), 16.7823999999999991, 96.1278599999999983, 'Ah_A L_OME'),
('Bahan', 'ဗဟန်း', NULL, NULL, NULL, (SELECT id from return_id), 16.8154299999999992, 96.1561099999999982, 'B_A H_AN'),
('Botahtaung', 'ဗိုလ်တထောင်', NULL, NULL, NULL, (SELECT id from return_id), 16.7719699999999996, 96.1697099999999949, 'Bိုလ် T_A Ht_OUN'),
('Dagon', 'ဒဂုံ', NULL, NULL, NULL, (SELECT id from return_id), 16.79495, 96.1469000000000023, 'D_A G_OME'),
('Dagon Myothit (East)', 'ဒဂုံမြို့သစ်(အရှေ့ပိုင်း)', NULL, NULL, NULL, (SELECT id from return_id), 16.9128100000000003, 96.2132299999999958, 'D_A G_OME M_Y_O Th_IC (အ Y_H_AY P_INE )'),
('Shwepyithar', 'ရွှေပြည်သာ', NULL, NULL, NULL, (SELECT id from return_id), 16.9550400000000003, 96.0832900000000052, 'Y_W_AY P_Y_EE Th_A'),
('Dagon Myothit (North)', 'ဒဂုံမြို့သစ်(မြောက်ပိုင်း)', NULL, NULL, NULL, (SELECT id from return_id), 16.8777399999999993, 96.1907900000000069, 'D_A G_OME M_Y_O Th_IC (မ_Yောက် P_INE )'),
('Dagon Myothit (Seikkan)', 'ဒဂုံမြို့သစ်ဆိပ်ကမ်း', NULL, NULL, NULL, (SELECT id from return_id), 16.8404899999999991, 96.2725599999999986, 'D_A G_OME M_Y_O Th_IC S_ATE K_AN'),
('Dagon Myothit (South)', 'ဒဂုံမြို့သစ်(တောင်ပိုင်း)', NULL, NULL, NULL, (SELECT id from return_id), 16.8401600000000009, 96.2258199999999988, 'D_A G_OME M_Y_O Th_IC (တောင် P_INE )'),
('Yankin', 'ရန်ကင်း', NULL, NULL, NULL, (SELECT id from return_id), 16.8360100000000017, 96.1624000000000052, 'Y_AN K_IN'),
('Thingangyun', 'သင်္ဃန်းကျွန်း', NULL, NULL, NULL, (SELECT id from return_id), 16.8310099999999991, 96.1932299999999998, 'Th_IN ္ဃန်း Kျွ_AN'),
('Thaketa', 'သာကေတ', NULL, NULL, NULL, (SELECT id from return_id), 16.7930099999999989, 96.2029600000000045, 'Th_A K_AY T_A'),
('Tamwe', 'တာမွေ', NULL, NULL, NULL, (SELECT id from return_id), 16.810179999999999, 96.1764600000000058, 'T_A M_W_AY'),
('South Okkalapa', 'တောင်ဥက္ကလာပ', NULL, NULL, NULL, (SELECT id from return_id), 16.8462500000000013, 96.179860000000005, 'T_OUN U_A K_A ္က L_A P_A'),
('Seikkan', 'ဆိပ်ကမ်း', NULL, NULL, NULL, (SELECT id from return_id), 16.7703999999999986, 96.1550500000000028, 'S_ATE K_AN'),
('Seikgyikanaungto', 'ဆိပ်ကြီးခနောင်တို', NULL, NULL, NULL, (SELECT id from return_id), 16.75779, 96.1163700000000034, 'S_ATE K_Y_I Kh_A N_OUN T_O'),
('Sanchaung', 'စမ်းချောင်း', 'Sanchaung', NULL, NULL, (SELECT id from return_id), 16.8036071648366097, 96.1372567291957694, 'S_AN Kh_Y_OUN'),
('Pazundaung', 'ပုဇွန်တောင်', NULL, NULL, NULL, (SELECT id from return_id), 16.7796500000000002, 96.1743900000000025, 'P_U Z_W_AN T_OUN'),
('Pabedan', 'ပန်းပဲတန်း', NULL, NULL, NULL, (SELECT id from return_id), 16.7769799999999982, 96.1560099999999949, 'P_AN P_EARE T_AN'),
('North Okkalapa', 'မြောက်ဥက္ကလာပ', NULL, NULL, NULL, (SELECT id from return_id), 16.9187800000000017, 96.1630300000000062, 'M_Y_OUT U_A K_A ္က L_A P_A'),
('Mingalartaungnyunt', 'မင်္ဂလာတောင်ညွန့်', NULL, NULL, NULL, (SELECT id from return_id), 16.7889100000000013, 96.1678600000000046, 'M_IN ္ဂ L_A T_OUN Ny_W_AN'),
('Mingaladon', 'မင်္ဂလာဒုံ', NULL, NULL, NULL, (SELECT id from return_id), 16.9491399999999999, 96.1279499999999985, 'M_IN ္ဂ L_A D_OME'),
('Mayangon', 'မရမ်းကုန်း', NULL, NULL, NULL, (SELECT id from return_id), 16.8669750879097577, 96.1420457197925771, 'M_A Y_AN K_OME'),
('Latha', 'လသာ', NULL, NULL, NULL, (SELECT id from return_id), 16.77712, 96.1505300000000034, 'L_A Th_A'),
('Lanmadaw', '  လမ်းမတော်', NULL, NULL, NULL, (SELECT id from return_id), 16.7774518267821087, 96.1413673677632232, 'L_AN M_A T_AW'),
('Kyeemyindaing', 'ကြည့်မြင်တိုင်', NULL, NULL, NULL, (SELECT id from return_id), 16.8145699999999998, 96.1218800000000044, 'K_Y_EE M_Y_IN T_INE'),
('Kyauktada', 'ကျောက်တံတား', NULL, NULL, NULL, (SELECT id from return_id), 16.7742600000000017, 96.1616400000000056, 'K_Y_OUT T_AN T_A'),
('Kamaryut', 'ကမာရွတ်', NULL, NULL, NULL, (SELECT id from return_id), 16.8276800000000009, 96.1324400000000026, 'K_A M_A Y_W_AT'),
('Hlaing', 'လှိုင်', NULL, NULL, NULL, (SELECT id from return_id), 16.8479300000000016, 96.125230000000002, 'L_H_INE'),
('Dawbon', 'ဒေါပုံ', NULL, NULL, NULL, (SELECT id from return_id), 16.7819199999999995, 96.1843499999999949, 'D_AW P_OME'),
('Dala', 'ဒလ', NULL, NULL, NULL, (SELECT id from return_id), 16.7585499999999996, 96.1430000000000007, 'D_A L_A'),
('Htaukkyant', 'ထောက်ကြံ့', NULL, NULL, NULL, (SELECT id from return_id), 17.0427556500000001, 96.132312799999994, 'Ht_OUT K_Yံ့');



With return_id as(
INSERT INTO public.town (name_en, name_mm, description_en, description_mm, image_url, latitude, longitude, name_mm_soundex)
VALUES
    ('Mandalay', 'မန္တလေး', NULL, NULL, NULL, 21.9932100000000013, 96.0968600000000066, 'M_A N_A ္တ L_AY')
    RETURNING id
)
INSERT INTO public.township(name_en, name_mm, description_en, description_mm, image_url, town_id, latitude, longitude, name_mm_soundex)
VALUES
('Amarapura', 'အမရပူရ', NULL, NULL, NULL, (SELECT id from return_id), 21.9031400000000005, 96.0494800000000026, 'Ah_A M_A Y_A P_U Y_A'),
('Aungmyaythazan', 'အောင်မြေသာဇံ', NULL, NULL, NULL, (SELECT id from return_id), 21.9932100000000013, 96.0968600000000066, 'Ah_OUN M_Y_AY Th_A Z_AN'),
('Chanayethazan', 'ချမ်းအေးသာဇံ', NULL, NULL, NULL, (SELECT id from return_id), 21.9753499999999988, 96.0945999999999998, 'Kh_Y_AN Ah_AY Th_A Z_AN'),
('Chanmyathazi', 'ချမ်းမြသာစည်', NULL, NULL, NULL, (SELECT id from return_id), 21.9393999999999991, 96.0958399999999955, 'Kh_Y_AN M_Y_A Th_A S_EE'),
('Mahaaungmyay', 'မဟာအောင်မြေ', NULL, NULL, NULL, (SELECT id from return_id), 21.9588999999999999, 96.0911600000000021, 'M_A H_A Ah_OUN M_Y_AY'),
('Pyigyitagon', 'ပြည်ကြီးတံခွန်', NULL, NULL, NULL, (SELECT id from return_id), 21.901959999999999, 96.1041799999999995, 'P_Y_EE K_Y_I T_AN Kh_W_AN');



With return_id as(
INSERT INTO public.town (name_en, name_mm, description_en, description_mm, image_url, latitude, longitude, name_mm_soundex)
VALUES
    ('Nay Pyi Taw', 'နေပြည်တော်', NULL, NULL, NULL, 19.7585074108035776, 96.0791394772877538, 'N_AY P_Y_EE T_AW')
    RETURNING id
)
INSERT INTO public.township(name_en, name_mm, description_en, description_mm, image_url, town_id, latitude, longitude, name_mm_soundex)
VALUES
('Det Khi Na Thi Ri', 'ဒက္ခိဏသီရိ', NULL, NULL, NULL, (SELECT id from return_id), 19.7190000000000012, 96.0669999999999931, 'D_A K_A ္ခိ N_A Th_I Y_I'),
('Oke Ta Ra Thi Ri', 'ဥတ္တရသီရိ', NULL, NULL, NULL, (SELECT id from return_id), 19.8909999999999982, 96.0430000000000064, 'U_A T_A ္တ Y_A Th_I Y_I'),
('Za Bu Thi Ri', 'ဇမ္ဗူသီရိ', NULL, NULL, NULL, (SELECT id from return_id), 19.7639999999999993, 96.061000000000007, 'Z_A M_A ္ဗူ Th_I Y_I'),
('Zay Yar Thi Ri', 'ဇေယျာသီရိ', NULL, NULL, NULL, (SELECT id from return_id), 19.8619999999999983, 96.3089999999999975, 'Z_AY Y_Y_A Th_I Y_I');



INSERT INTO public.town (name_en, name_mm, description_en, description_mm, image_url, latitude, longitude, name_mm_soundex)
VALUES
('Bago', 'ပဲခူး', NULL, NULL, NULL, 17.3358300000000014, 96.4838900000000024, 'P_EARE Kh_U'),
('Bawlake', 'ဘောလခဲ', NULL, NULL, NULL, 19.1741400000000013, 97.3373500000000007, 'B_AW L_A Kh_EARE'),
('Bhamo', 'ဗန်းမော်', NULL, NULL, NULL, 24.2549300000000017, 97.2344099999999969, 'B_AN M_AW'),
('Dawei', 'ထားဝယ်', NULL, NULL, NULL, 14.0775299999999994, 98.1963599999999985, 'Ht_A W_EARE'),
('Hopang', 'ဟိုပန်', NULL, NULL, NULL, 23.4254399999999983, 98.7502900000000068, 'H_O P_AN'),
('Hpa-An', 'ဘားအံ', NULL, NULL, NULL, 16.8807599999999987, 97.6369100000000003, 'B_A Ah_AN'),
('Hpapun', 'ဖာပွန်', NULL, NULL, NULL, 18.0649599999999992, 97.4448799999999977, 'Pf_A P_W_AN'),
('Kawkareik', 'ကော့ကရိတ်', NULL, NULL, NULL, 16.555530000000001, 98.2399599999999964, 'K_AW K_A Y_ATE'),
('Kawthoung', 'ကော့သောင်း', NULL, NULL, NULL, 10.0120199999999997, 98.5638299999999958, 'K_AW Th_OUN'),
('Kengtung', 'ကျိုင်းတုံ', NULL, NULL, NULL, 21.2918899999999987, 99.6036000000000001, 'K_Y_INE T_OME'),
('Kunlong', 'ကွမ်းလုံ', NULL, NULL, NULL, 23.4072700000000005, 98.6445300000000032, 'K_W_AN L_OME'),
('Kyaukme', 'ကျောက်မဲ', NULL, NULL, NULL, 22.5417200000000015, 97.0367099999999994, 'K_Y_OUT M_EARE'),
('Langkho', 'လင်းခေး', NULL, NULL, NULL, 20.3422200000000011, 98.0037099999999981, 'L_IN Kh_AY'),
('Lashio', 'လားရှိုး', NULL, NULL, NULL, 22.952770000000001, 97.747470000000007, 'L_A Y_H_O'),
('Laukkaing', 'လောက်ကိုင်', NULL, NULL, NULL, 23.69163, 98.764080000000007, 'L_OUT K_INE'),
('Loikaw', 'လွိုင်ကော်', NULL, NULL, NULL, 19.6742400000000011, 97.2099299999999999, 'L_W_INE K_AW'),
('Loilen', 'လွိုင်လင်', NULL, NULL, NULL, 20.9253600000000013, 97.565809999999999, 'L_W_INE L_IN'),
('Muse', 'မူဆယ်', NULL, NULL, NULL, 23.989889999999999, 97.9016500000000036, 'M_U S_EARE'),
('Myawaddy', 'မြဝတီ', NULL, NULL, NULL, 16.6832999999999991, 98.5167000000000002, 'M_Y_A W_A T_I'),
('Myeik', 'မြိတ်', NULL, NULL, NULL, 12.4411199999999997, 98.6097800000000007, 'M_Y_ATE'),
('Matman', 'မက်မန်း', NULL, NULL, NULL, 21.9619600000000013, 98.8657500000000056, 'M_AK M_AN'),
('Mawlamyine', 'မော်လမြိုင်', NULL, NULL, NULL, 16.4845900000000007, 97.6259299999999968, 'M_AW L_A M_Y_INE'),
('Thaton', 'သထုံ', NULL, NULL, NULL, 16.9196999999999989, 97.3678000000000026, 'Th_A Ht_OME'),
('Myitkyina', 'မြစ်ကြီးနား', NULL, NULL, NULL, 25.3874899999999997, 97.3903600000000012, 'M_Y_IC K_Y_I N_A'),
('Monghpyak', 'မိုင်းဖြတ်', NULL, NULL, NULL, 20.8780399999999986, 99.9233300000000071, 'M_INE Pf_Y_AT'),
('Monghsat', 'မိုင်းဆတ်', NULL, NULL, NULL, 20.5054400000000001, 99.247240000000005, 'M_INE S_AT'),
('Mongmit', 'မိုးမိတ်', NULL, NULL, NULL, 23.1142199999999995, 96.6699899999999985, 'M_O M_ATE'),
('Pathein', 'ပုသိမ်', NULL, NULL, NULL, 16.811846139257451, 94.7784657398044601, 'P_U Th_AIN'),
('Puta-O', 'ပူတာအို', NULL, NULL, NULL, 27.2993400000000008, 97.4158999999999935, 'P_U T_A Ah_O'),
('Shwe Nyaung', 'ရွှေညောင်', NULL, NULL, NULL, 20.5850073589004516, 96.1962134179409531, 'Y_W_AY Ny_OUN'),
('Nyung Shwe', 'ညောင်ရွှေ', NULL, NULL, NULL, 20.6590866258780466, 96.9340597429902573, 'Ny_OUN Y_W_AY'),
('Tachileik', 'တာချီလိတ်', NULL, NULL, NULL, 20.4530400000000014, 99.8840299999999957, 'T_A Kh_Y_I L_ATE'),
('Taik Gyi', 'တိုက်ကြီး', NULL, NULL, NULL, 17.3128305171692354, 95.9589227934918654, 'T_ITE K_Y_I'),
('Taunggyi', 'တောင်ကြီး', NULL, NULL, NULL, 20.7747700000000002, 97.035979999999995, 'T_OUN K_Y_I'),
('Thanlyin', 'သန်လျင်', NULL, NULL, NULL, 16.756529857775476, 96.251117707870435, 'Th_AN L_Y_IN'),
('Falam', 'ဖလမ်း', NULL, NULL, NULL, 22.9110499999999995, 93.6803400000000011, 'Pf_A L_AN'),
('Gangaw', 'ဂန့်ဂေါ', NULL, NULL, NULL, 22.1742099999999986, 94.1358199999999954, 'G_AN G_AW'),
('Hakha', 'ဟားခါး', NULL, NULL, NULL, 22.64011, 93.6048300000000069, 'H_A Kh_A'),
('Hinthada', 'ဟင်္သာတ', NULL, NULL, NULL, 17.6495800000000003, 95.4581799999999987, 'H_IN ္သာ T_A'),
('Hkamti', 'ခန္တီး', NULL, NULL, NULL, 25.9924299999999988, 95.6954700000000003, 'Kh_A N_A ္တီး'),
('Kale', 'ကလေး', NULL, NULL, NULL, 23.1933000000000007, 94.0297699999999992, 'K_A L_AY'),
('Kanbalu', 'ကန့်ဘလူ', NULL, NULL, NULL, 23.2030500000000011, 95.5188600000000037, 'K_AN B_A L_U'),
('Katha', 'ကသာ', NULL, NULL, NULL, 24.1816299999999984, 96.3316700000000026, 'K_A Th_A'),
('Kyaukpyu', 'ကျောက်ဖြူ', NULL, NULL, NULL, 19.4238999999999997, 93.5544000000000011, 'K_Y_OUT Pf_Y_U'),
('Kyaukse', 'ကျောက်ဆည်', NULL, NULL, NULL, 21.6132500000000007, 96.1303300000000007, 'K_Y_OUT S_EE'),
('Labutta', 'လပွတ္တာ', NULL, NULL, NULL, 16.1455699999999993, 94.7588899999999938, 'L_A P_W_A T_A ္တာ'),
('Magway', 'မကွေး', NULL, NULL, NULL, 20.140270000000001, 94.926959999999994, 'M_A K_W_AY'),
('Maubin', 'မအူပင်', NULL, NULL, NULL, 16.7302299999999988, 95.6494, 'M_A Ah_U P_IN'),
('Maungdaw', 'မောင်တော', NULL, NULL, NULL, 20.8189700000000002, 92.3677600000000041, 'M_OUN T_AW'),
('Meiktila', 'မိတ္ထီလာ', NULL, NULL, NULL, 20.8818899999999985, 95.863110000000006, 'M_I T_A ္ထီ L_A'),
('Minbu', 'မင်းဘူး', NULL, NULL, NULL, 20.1716100000000012, 94.8751800000000003, 'M_IN B_U'),
('Mindat', 'မင်းတပ်', NULL, NULL, NULL, 21.3717599999999983, 93.9736500000000063, 'M_IN T_AT'),
('Mohnyin', 'မိုးညှင်း', NULL, NULL, NULL, 24.7790600000000012, 96.3731999999999971, 'M_O Ny_H_IN'),
('Monywa', 'မုံရွာ', NULL, NULL, NULL, 22.1216800000000013, 95.1396299999999968, 'M_OME Y_W_A'),
('Mrauk-U', 'မြောက်ဦး', NULL, NULL, NULL, 20.5918500000000009, 93.1884399999999999, 'M_Y_OUT Au'),
('Myaungmya', 'မြောင်းမြ', NULL, NULL, NULL, 16.599260000000001, 94.9297700000000049, 'M_Y_OUN M_Y_A'),
('Myingyan', 'မြင်းခြံ', NULL, NULL, NULL, 21.4574500000000015, 95.3917900000000003, 'M_Y_IN Kh_Y_AN'),
('Yinmarbin', 'ယင်းမာပင်', NULL, NULL, NULL, 22.0777900000000002, 94.9001399999999933, 'Y_IN M_A P_IN'),
('Yamethin', 'ရမည်းသင်း', NULL, NULL, NULL, 20.4304999999999986, 96.1374699999999933, 'Y_A M_EE Th_IN'),
('Thayet', 'သရက်', NULL, NULL, NULL, 19.3215000000000003, 95.1771600000000007, 'Th_A Y_AK'),
('Thayarwady', 'သာယာဝတီ', NULL, NULL, NULL, 17.6544099999999986, 95.7862899999999939, 'Th_A Y_A W_A T_I'),
('Nyaung-U', 'ညောင်ဦး', NULL, NULL, NULL, 21.1954300000000018, 94.9101100000000031, 'Ny_OUN Au'),
('Pakokku', 'ပခုက္ကူ', NULL, NULL, NULL, 21.3350000000000009, 95.0822699999999941, 'P_A Kh_U K_A ္ကူ'),
('Pyapon', 'ဖျာပုံ', NULL, NULL, NULL, 16.2843000000000018, 95.6832200000000057, 'Pf_Y_A P_OME'),
('Pyay', 'ပြည်', NULL, NULL, NULL, 18.82151, 95.2210299999999989, 'P_Y_EE'),
('Pyinoolwin', 'ပြင်ဦးလွင်', NULL, NULL, NULL, 22.0139700000000005, 96.4563399999999973, 'P_Y_IN Au L_W_IN'),
('Sagaing', 'စစ်ကိုင်း', NULL, NULL, NULL, 21.8800799999999995, 95.9623100000000022, 'S_IC K_INE'),
('Shwebo', 'ရွှေဘို', NULL, NULL, NULL, 22.5699599999999982, 95.6984900000000067, 'Y_W_AY B_O'),
('Sittwe', 'စစ်တွေ', NULL, NULL, NULL, 20.1372700000000009, 92.8855099999999965, 'S_IC T_W_AY'),
('Tamu', 'တမူး', NULL, NULL, NULL, 24.2114900000000013, 94.3153400000000062, 'T_A M_U'),
('Thandwe', 'သံတွဲ', NULL, NULL, NULL, 18.4609999999999985, 94.3607700000000023, 'Th_AN T_W_EARE'),
('Taungoo', 'တောင်ငူ', NULL, NULL, NULL, 18.9395300000000013, 96.4331399999999945, 'T_OUN Ng_U'),
('Mawlaik', 'မော်လိုက်', NULL, NULL, NULL, 23.6351200000000006, 94.4120099999999951, 'M_AW L_ITE');



INSERT INTO public.user_account(id, email, display_name, is_super_admin, is_active, preferred_language)
VALUES
(1, 'superadmin@gmail.com', 'Super Admin', true, true, 'en');


INSERT INTO public.agent(name, domain, description, api_key, commission_rate, creator_id, created_date, modified_date)
VALUES
('Shwe Booking','shwebooking.com','Instant booking!','25ddcf7b-3961-4d2a-9d83-cadc4a59fd66', '0.05', 1, '2019-09-23 00:00:00', '2019-09-23 00:00:00');



INSERT INTO public.agent_balance(agent_id, balance, modified_date)
VALUES
(1, 10000000, '2020-03-17 00:00:00');



INSERT INTO public.bank(full_name, short_name)
VALUES
('Co-operative Bank (CB Bank)', 'CB'),
('Yoma Bank', 'Yoma'),
('Central Bank of Myanmar', 'CBM'),
('Kanbawza Bank (KBZ Bank)', 'KBZ'),
('Myanma Apex Bank (MAB)', 'MAB'),
('Asia Green Development Bank (AGD Bank)', 'AGD'),
('Ayeyarwady Bank (AYA Bank)', 'AYA '),
('Myanmar Citizens Bank (MCB)', 'MCB');



INSERT INTO public.bed_type(bed_type)
VALUES
('Single'),
('Twin'),
('Twin XL'),
('Double'),
('Full'),
('Queen'),
('King'),
('California King');



INSERT INTO public.gateway_type(name, code)
VALUES
('Myanmar Payment Union','MPU');




INSERT INTO public.hotel_amenity(code, amenity, icon)
VALUES
('wifi', 'Free Wifi', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCxkFCSjkeTvQAAABZElEQVQ4y83Sv0vVYRTH8ZeWpIWIYKQ5JYKRFLpYKuailN+LpX+CS466VeDuLEE4OknYplIN5b2DP1oquxdyUXEofzRkmw7X5zZ0u+KPGwkKvbfzOec85/Oc5+G/o+BQfM4tN11Tgh2rUlL28jW3G7MtY8eaefPW7Mr4YUz70eI27wWzHrtxQK/3xJxgQeu+WGJUMKMpr/Hb4oLniqHSR1u6s6kag6YlbdmUNGVATTbzwHcfVBZICbqso9Gweza9smIdV9WKXPHGU4uo9hoiZSjyTDCjTeEBM4Xuitsz4jzKRL/lcu9se5gtqhDp0ydSkVV6/PRW+f453RbVgU4JacGGDUFaXAe47lPunjkumRBMuO8CKNblpeCFi8cvL+GrliNqq28Sxzf0qgIx45I+GxcDVXrz/61S09ImDRkyKW1Kqb8S80VDLmq09GeRp8xlK5Zzr/APNMvIuHOSGf0enYn3s+AXIJNhmkQ+6kIAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMTEtMjVUMDU6MDk6NDArMDA6MDCtgn3jAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTExLTI1VDA1OjA5OjQwKzAwOjAw3N/FXwAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAAASUVORK5CYII='),
('continental breakfast', 'Continental Breakfast', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjDAsJMBn6CQwwAAAB5UlEQVQ4y43TSUgVUBQA0KNIhmQpSdFAlIGQEmVKExlEWX9TFNFA5BBp5LKCaNoIBVG7zJKIFhLRhA0QRSamtpAkSLNPZhs1EGpRxpcW6v8tRNQ/QG93effw3n33viSXHDUsQ8SQ+CtLka6JIMVsxz111rBrCcB96ZNBctyUfCkJcFxQotHdRCQWrHVGrpAL/wsOu+SHE0rjg6kHH7PNX3k6kWqu6+YZUokN5mg0Eg12eGbAEdVaXdGvSb8XklApJEt9NPirT4sW3brNkCeIERHU2aI3toY2JZKEBR3yXRA7fcZ8b+XriK3hto06fbHOZWMeypRlrzTZZvlgNBaMKbPAQhGdis0W0issoNVWb+K9EgwahIkbY6smFSoSAZLkyrdctgxpWG2zWrss0yYUC/a7aNB7v7T4JCTsniXeCTvgpmanp4M5bin0zSqPsUeOarXalRtEshrnpoOINK+81OGgfiF5yhVKNlPASgH56qaDPwZsUqTAPpkypGPUcb8N6HJSqZ7oGl7brt6jBHO32+Xoaa1xXmr8OXVUi5/JyJkyIEENauKmr3Zq/I+s0CCo2VUFChRY66M70qLSi321frxNsFSVNdOat8QNT/QhVZEqi5TpmQSxa7FKAYuFjWj3wHOR8Y1/G6WIiiL+uwcAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMTItMTFUMDk6NDg6MjUrMDA6MDDYiWsuAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTEyLTExVDA5OjQ4OjI1KzAwOjAwqdTTkgAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAAASUVORK5CYII='),
('buffet breakfast', 'Buffet Breakfast', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjDAsJMgyl4opZAAABjElEQVQ4y53PTUiUURjF8d87vZgaU05iQuEgiQYRQwqFLSJmVS0nChLbtgxaB31tq1WLWhi6iqRgNn3QIpQW1UREMWKbpJiFUUwlKDj0aYt3lJlZ6Gtn9dx7/+c8526wupKuajHj7/JFYhV4qzEPLDmq4KxgjWhtCo5X52bX3IjGAN3a69CPvuO6l27X3I675UlkuCJnwnLACcMeSXhusC5mlwuGCfFT2nYVsMNvTZLGdLnbUDLrosshJuSMWARdznlmAUN+aarBF7xTijYc0+rUykOng/IWfXKpzvDWN5XIMGubHysbKtXpT01IpDMQCk0puVfF0vrMSNloi1SDocUmYeCmTBVeW62KjOqNidNrNBEbrio07U4Mbs6Q+9o9DOzxRTlm/GH7E3IG1lPpP/4QV1mf12PoN4l0/ErNjZV69Jk1ZQls1o835kEgo81OH6LDeZ16zCvqttu4sn0GTSKr4JUOJ00ryUh672tgrwGnHQApR3QoemoJgUMyyh6bAy+MeB0Vysf6Rx7+ARIWXxEFNSdzAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE5LTEyLTExVDA5OjUwOjEyKzAwOjAwQfjNdwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOS0xMi0xMVQwOTo1MDoxMiswMDowMDCldcsAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC'),
('atm', 'ATM machine', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAPYAAAD2ABenhFjQAAABl0RVh0U29mdHdhcmUAcGFpbnQubmV0IDQuMC4yMfEgaZUAAAHjSURBVEhLxVa/S8NAFE4b+jM/21LaLQjFYKFZXKTg1tVFKC7OBWdx7+Lm4iK4uAgOBRf7Hzj7b+jiUlwc4/ediaQ16Z0k4AeP9/LevffdvbvkoiXhum4AtZ9HWGOxWOiw12Ga5jVUWITU63XWWkepVHqBeoSkzuwPwhqs9Qt03n6bmtbv9z3DMNgyrd1uH0DNKJVKZdZqtRzYum3bJ9R8tizrCDbBGnIC07aXtVrtlTaInqDE8svlcgjy42azydmGjuPMGaefYwE5ATcJxVcwwyAIdukDuIK4CCEIdF3/6T2dgJxgNBqJZApmyMJEKgH2bgWSD9rCq0LQ6XTOkcjTsEIrHugDUglwLA/RnjPawqtCgCO7hBIrqFarYh+AVIJIJ2NyAs680Wjc4WRc4DEcDocD6OIIUHjued6e7/sWWnQ1mUycbrc7QOsuGSf88TgrJifIia0EXGYRkknwDGE/8whrZBKIFvV6vR0obp6yRDmEfA/w4nxCpS09U/AuMIeQEwBM4qk4jWzqzVknYxxLm1AmuIfEiSy4CfoY4xiOVSfAJ/kNigmxbCMQgpfznU5AaQUx4iLbCDZj/0SQcWWqbnLSn35lRhc1E3IJP/O4Q25gr4O3mFHAbwtrTKfT6LdF074Au8r5e8ALznwAAAAASUVORK5CYII='),
('laundry', 'Laundry Service', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfkAQ0HJRhw21xtAAABw0lEQVQ4y43UTUjUURQF8N+MExWW1PSNUpuohLSUIKyxCAla2coWWVEg0TYoiMpduGzTTlpIqyAyi6lFKFFgjpFDNBDWQikIF5VajGloMy2c0f+oqWf1ePecd8+57/FC4IQWGYujSLM4IdCn0ZFcIeO+UuUe26ROh/Hc/lqvVBEBWYcc9RKckXLXgJDzRuzV45hbWrT6I2IqktOnxewGZca8t99HPZpckTDgp1afponTlj44a2m0qcp3iLq4DMHm2eXbZdBJiORDF6JOg3L0e+j53OJcwQb3/DBo0qS00y4751uQEC6grxH3QqWMuA4T9ukSVzLfRD7Dbc16bQ3E7HXDnWCGoKBYn2cqCo7ao9ObXI+ESKGlGt2KpQoE/Yp0iy2cYYu0z/PsDvht28JTGrVSqYMO2y6tXRI7VRo2MksK5TIcwEbtVvuiw6CoRrtkZYSNajSEhNjs44Pvvko67oEJPMEqj3SpMfS/sZZJuq7XSVFR9V67KWlHcKxBS1ChzVPrVAhJGVbvgnczgpip8JxeKbV+qVaiRLUxsRn6gpYWR+C1rnBpyU8grNjf/MWdclV4CcE1DbL50HRaL7uoYFwt/APOXn14tiVA+QAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wMS0xM1QwNzozNzoyNCswMDowMMU3wVUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDEtMTNUMDc6Mzc6MjQrMDA6MDC0annpAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAABJRU5ErkJggg=='),
('parking', 'Car Parking', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAD2EAAA9hAag/p2kAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAADEElEQVRIS62VTUgbURDH12wSYzYx5mNNjAlLMMRoUSqBKkqhFxEEEULFW6EUAqVnwVtKLwUp9BKEnAUpQqG0F28FbwUvvQilUAKFIHiRQhCKsP3NZpMmm1qa1D8M8+a9t/P1ZmaVFtLp9B1YoUUej6ewvLyclLP/RiAQ+AAzneRyuUzO3hiG4UMeDLbnpq7rD+HisUWJRMKIxWLbbrf7MhgMVtgbGJIS8Tg5Pj6+NDExsT82NrYHl30lHA7v+ny+S1kPirYBTdOq5L6B119Jz1U+n895vd5NVVXlfGC0DYyMjFRJy+n09HQQI+bk5OQj9jdu1cDQ0NBPFP4gksu5ubkU+7drwO/314aHh5/MzMwY1ultGpCqCYXDO9auDR78GY98ZYv9g/K8CzNTqdS95s5v8AbzvIVEdGBv9Y9SqeShUk4lDXjaJpRKVCYpO11cXIzTcHuk8KrzjpP45jsOrzU1d6BQKPhpuG0a6mR0dLQ2NTVVIqLHKF3Z2tpS6eQHXDPpjRdydhNh4D1UPzo6UpuaHWiVqS22QRQVPPwiaxkboVBIDHYBh9YymYyk2cRYz7mFPxmQCEjhedowKuVyOeVyuY9pyMbh4WGyRaTllcytYrG47te02o2jxWkgl8vF8P4TS+s9/pWkl3DiJetuOA1EIpEyj3/BWxQp141/JebXcz43M5l8rqnJhtNAVNermhawZMJeh5U4l77pAR5vw0rJZFKUykSWaLrv/s0Aj/wRViea1yJ3olqteoj0jGU9Ho9Lo/ZvoE/0GiDf+3h5QR03SMc78YrqYHx7G2K0H+INPqOy2wAh1pmgJ+TyGNHcKZeTXFyh5i2Z1BxQimdQTSLtJO7JKDGJ9lh0cKfBdxUaOCS65Z8cw8A5c2dX1xPyDzBXV1dlRinZbHZJZBqsSD+cEOFb2e8E/eF3qeo1U2BXflpk4pt9pCgLCwtZ6taqXycxGjabjeazosCJBmV4n3UPULwHkx64jkajT5u7NvhoHib5ahMNVpBByNrqZpmss7OzEZFvgtQ9EctPyoai/AKi+fZlDIrPswAAAABJRU5ErkJggg=='),
('concierge', 'Concierge', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAD2EAAA9hAag/p2kAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAABn0lEQVRIS2MYBVQDWlpaEiYmJmkgDGJDhakHNDU1Yzk4OP6DMIgNFaYOqK+vZ9LR0dGTk5NbJysru05ZWVn7////jFBp8oGpqamEgIBADw8Pz1t2dvb/zMzM/xkZGf8zMTH95+LieissLNxvbm4uDlVOGpCWlvbm5uZ+KyQktExfX79RTU2tGWjJc6DUfxgGWQYUewdSC9JDNJCRkQkAhvU3ERGRPKAPToNcDMIgA4HSKBZALfknKSkZANJLEABTiBxQw0dxcfFWNja2u0AhFEOxYZDlQLUfQXqBfPxAUFBwPtD1r4EWdAO5WA1ExzCfiImJLQLycQM/Pz9eoOE/RUVFN/Hx8V1ADxJCGOiLzyEhIZxANnYgISFhBzIUqPAoKyvrZ6AQVoNwYVBQAZOwI5CNHVhZWSUAXf+NEmxmZoY7E3p7ewva2NhoUYJBZkCNwwTAjNMC8iYoQ5GLgRHdDjUOFQDDvx9o+A8gE2v4EouBZnwH5okeIBsVsLCwfAZG7H8gTQ38BmosAgQGBpoCsQU1cHBwsAnU2FEw/AEDAwC1L+iT9V3fNwAAAABJRU5ErkJggg=='),
('front-desk', 'Front Desk', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAD2EAAA9hAag/p2kAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAAB80lEQVRIS+1UPWvCUBRVY0yMMYmaxA+oWnBwChXnLo5Ct7oKUhCK0KUUdBD7A5wLgksRunXv1j/g0rFbJ3FxKZRCEdJz47PVEhXRTu2Bw/14791j7n1PzypkMhkxn88XS6VSnKX2h4iu1zmOe4Vre73eqSRJN/A5Z3FXJJPJY5/PZ2ua1i0UCpau62eI32RZbtN6NpvNwNTXEZBg3SGK4o0gCEMWOlAUpYvcM/m5XO4Ehr5sDDtaJHITWms0GilYd6DYIBAIPLLQAVrURu6F/LmAW5F1a19IJBKnMNN4PF6rVCpcOp0uYh7jcDhMc9hdIBKJXKLnU7g22mKTJUqyfAcrzovgB3RVVb1eJOZGe1YLGIZRY7ema5pm3TSTDiHa9Pv9k1AodGtZVgnFRnP6ef5DEMS3xdxFq+V+tYPB4AOK37NwCbhF5xB5Z+EX0LphNBrtsXA9VE0bKoq2arPTmpn7jY0C9V6Pv+p0UkS04gltGszjRWL4VWy3f+bRkifMw/UM1SaNIh38JVLtmYBhJKoHB4cn+yC64HztkgAG2IR1ffrbktWaCfA8b+EhjUDnmSMes3hr0lmqAX/CYgvxDLFYzLkl/X5/9SvcAHbWZrWW8S9A+CMC5XL5CJY2bk12dr3APugqgD86FYZe9c5ktQCP5xPNFQpvJyHvqAAAAABJRU5ErkJggg=='),
('fitness', 'Fitness Center', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfkAQ0HJAvtfizyAAABrUlEQVQ4y5XSQWgNcBwH8M/bHsXUoqnXsqQWDoR5OdGy0S4uLnPBgTDJoqEc7ERiCckJB66rhV0Y1nKhZYqipteWGtqwNkbmve3v8La3Z/a25/s7/H99f7/vv+/v14+5UOG8hFtz9k1gt2BQv0eTRMHEu1SHMcEHlyzIEtxXKebpFBGdeE9a55hRy9UrU5upf8tuzhYU+em1EV3GnLFK91xey70XMlEzrdr87wwJ5Y5jm7i1Hub+OZrJkvrwypfZrRT4T0wJilXggErz8hHWGxYMGRUMumOnhTMPncZFwQ0rEBV3zlvBDy32WDyToMq4Buxy2zVrwGqndRr3W5s6j/8W3PVSxFnBcz1+2ZSplDmqXUrwSZ35k/SARoskNdqgzAut0+YrsU+rlE7FEJF0xEpBlXa97nkz41rihlxOpz2uKPRRmy36BTdzbLJJXzq5akCxaoOCICVoyWpL2Crmq5gTRtJUqWEPFFlih2ql9lufJdisSMR2hZ7pIIKYvS7odV2X7znsLHNYjVrNHJLMOuzZI+VgxGdPNOV5eadURZVI2ZinIKmEd3kbCoLuP8pwqznjwgvMAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTAxLTEzVDA3OjM2OjExKzAwOjAw9kKCLwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wMS0xM1QwNzozNjoxMSswMDowMIcfOpMAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC'),
('pool', 'Pool', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAD2EAAA9hAag/p2kAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAADHUlEQVRIS+1WTUgbURCOJhtjzLrJ5s/8YNgkJATj2rAQgkG8SAqF2kslFxF6CYhQPIaC4KUUilC8FARvQimKUCheBOkxF0EEKYggPXkRIQihIIHt9202CUQL2nprPxjeyzfzZubNvH0vlocgPzWlCIKgYSq1mC4mJibGMFAnGMRD4PV6ww6H4xumuinPyRM+n09D0O+YtnVh8vfG3NycdXBw8BhOTmOx2DNQdOCgTtM0H/gru91+EIlECqbOSt294ff7ixh0RVHUFtOFLMuv4byRTqdFk3o4otHoKzjh1u/Can9//6E5/zMkEomK1WrVIRu90tfXd4jx7wMgS+7ga68gwNmjBMAJ+m2J/gcwAqDWDHBxh1w/SgB8TAxQ6RU0f+8f6UEgEAimUinFnKtOp3MHX29teHh4BfwyA3g8nrLd7jjA/CAYDJaNha0AdXA1rPnMtSRHR0eVZDIZNSwIyeNZh+FPl8t1hIY2seBIFMVNcNc2m+0GJjo/NjjZhXxh02F7Bt0lbZDIJhI6gk2TPjDS13rLOzA9Pe1wu91LQ0NDHyFl3qDkk+PjUUmS3sLpB4y86w2EQqEiHSCJ1XQuZ1zPXCOK7nlwG7Ct4KbtvgtUbm9vG06pwP0/j6zehMPhJ4YBkM1mg1i4LMnyMucmbaENbbmm7ZS+KpVKNwAMqgMDAzVcvysYT7HFG2R9BVUT4xb078HVBcF+DX2DdRcl6R10n2iDkl6ibDco2Ql94FjXsMMVwznBVwmPyj7qeAHZwslJkkfZFsCfgDtnqZChc3JyUmRABPrBXqGx87TFtZ5EeXfBX4DfQ6M7Jb2FQqEgZzKZsXYv2sjn80omk4uZPw3QJpvNqXFNu/VOd4CmPXU6XVU6RcZrKIFxcpDJuX9k5CW2necOyVGw/X0c1Tx2XkZZzsiZZV2jD6yrQt95t1EK7yIMGpjqfGOx1aV4PF7EdnfMe0jH/JiLAqHQC5TshBzW6LDdwbdS5AGwCUKdPBJsoOmLmHdRKpVk9gIPu/Ggt6GqqgLH/EvSAcuCR17tLdfs7KxIHzMzM2a5LJZfIsPOqUJ0mwcAAAAASUVORK5CYII='),
('security', 'Security Guard', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAD2EAAA9hAag/p2kAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAADGklEQVRIS62VTUgbURDHo3GTuCYk2aSJ0cQQjR+xmEugBEpRhFoo6kEqxaMIASn0UgqlUPDSc89CEaSXIgQEKUihCCIUIRcvQhBEEEKPQZCACNvfbF5awa9d8A+P92bYmf+8eTOzLicoFovG2NhYUokPg/HxcV8wGJzz+Xzl9vb2BsvUNG0nFAotj46OGuozZ5ifn3fjdKKrq2uto6Oj3tbWdtnZ2bmDbskwjDld18tut7vBuvB6vZuxWGwhnU77lPn9wGidzcTpASTvWmkJhx+9IPI3cp6amjICgcAiZDvc6pIbHoreFgwjuiRGg4ODOaWy0Nvb+zIajb5VooXp6WmdgP5AtqpU90NSRGoOJe+IPXctv9//iWDOSVMc2T6I6CubaWdxg8rGxoabsz2MjIwU5WEhKScSiac8buG2FQ6HP2NiSlU1rW0gn89nqJA9jiapOvd4PHs85jecfEG3QiWtUgBblGtNvmE/TqVSz8TWCWa4hRWZpAuHvyCtoK+Qkt8Qf9d1/0f2Y3QrloVDzEhTqfOtUKTOCUKhyAybOTs7G2hqboZUGzdyTpDNZpNyg+7u7ldKdQ25XC7NDUzpbqVyBiLbkggLhUJQqf5BeoWH3+SBT2VeKbUzEH2aW9SI8iAej0+2an1gYOAxTfiDYyMSiUyKzjEoO3GyhvMLRKuhOJ8Rcb0lQ35Bda1nMpk8sj0Q0QROtiT/pOeUUbDMfkAvNCjX96TlA3KDvSqDD31NyplgthOp1HPl5hrcdORraXnOMkX3PB7fNhHXGW5DkPbg9ARn+zja57ua6MAQ+jpkP8VGbPmmgq+FUqmkWZ6Hh4d7MDghYhm5ZYZWUfQy3yGQhjpKJpMG8gRqKzX9/f2T8rPRNM+RBEUR6GLDtC1yy00ZMxCdkGYZiK6CGFFqT0S4CiGH4JSPd0lbFcIjAqmiq+J4V9LTcnIVQsQmwYjvJgHr2ocC8pzH6Znm9VYlLbIU2XlfX5/l4AaIL3sEAilL0hBVokvOolPiTfhPIBFKFcQyGWc/jDtA5UXVoGyWLw+WtQ4PiKZPl+svF1K+CfO7YugAAAAASUVORK5CYII='),
('spa', 'Spa', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAD2EAAA9hAag/p2kAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAADMElEQVRIS+2UXUjaYRTGTfM7NZ2mGaZmahZ4443URRENQZIgggr6IAfCECKIgQSjEYxAuhlIMPAmghGNIBBBgghECEGQYAzGYDdBN2MwBmM3Qfu9zvXF1mrsYhcdOPzfj/M+5znPed+/5N7+T7PZbE61Wp3TGQxlviW5XP5VKpV+Zit32XU6Xam5ubmq1+uTzG9noeFhjVarrbjd7ocajSYFyHOXxxNhbYPxQj3s3IZ/xKebmprW6ks3m15vnIRRymg0HrhcroTP5xuhigIAY0qlsjQ9/SiQzWbt151KDgKBQE8d5vdmNpuXABwVpcNskvEbq9U6QIJDKnoilcmOCLsilfCGhoZyS4ttkfHNJqQBNAvbFYPBkCdJiZ5E+b4jeUJvMBRJ+PK6Q6hA/LM6zK9te3tbtry8bH9gseRNJtOqv6cnEgwGIyqVJkOjPyFbqrW1NcN67LI73O6YSqXah8B4HeqqhUIhDQHrNLECUIHxMSWfcXP2GhsbC4ScqtTq98zzyPSB+RlxRea5y46MZXzL4XDYa8A/DeAti8UyR5lJWGZgPyPkAEQcegHrFGtzJrN5HRkS7e3tU0hY7O/vV9Uhzq2trW1AoVAehsNhU22ht7fXDsgeB1cASXu93ijjVTTPsp6G+RGJH+NZsUfMElXsQmQRUqmJibg9Ho9fYQy5SYFRm3g8npBWp8vCdodxRKFQFIXWgO/7/f4I3zx7GfZG2NsDfI1LsImsUZlM9pFKRJU5Gj3A3o6ofnZ2VsVVP6wlqD+UKlmjaF8m6DVs04xzooEChLIHARevegNmm6I6mh/jTAUIWUdHRx9Jql1dXT5iShAcHxoaCtQSCDOZzAsAFoQEogrYzNO0U7ROwvAYTYudnZ0xsY8sMyT9xnVOQqQEoVfigpD0rdPpDPOtkGCFc5VaH3ipQSQ4YSN3V+d9jHFBqt3d3SaSzXPjvgC+A4k+9gtOpzcgSSQScrKVYXdR0h2Magc5f4LmVaqpCHmFnMwv/k2wENqJx1URut7FkcpKX8TvQ+CskmAKnFGSPa2B/wtDjnWaXKEXuxCt4kes/fnH9zcmfjf14b3dxiSS73n74tbuk9BdAAAAAElFTkSuQmCC'),
('ticketing', 'Ticketing Service', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAD2EAAA9hAag/p2kAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAACbElEQVRIS8VUS28SURQe3gzMMExgYJBXeGgyZFICDW0xkhFMG4IkwsZN00UTjQ0mbl0ao/4At3XhvmtXEhO2Jq7bRNP4iNsuqqJbv0PuEASRhxi/5OTec87c77vnnAvcf0WpVLokiuIRVpWFVgci93q9H2CHHo/neKUiJjnP823yA4HAAb8qkXFyEySCSk7+SmQaOUGWZcnhcJwit1wls8htNtvrdDr9YKlK5iWHa0kkEmkmMn8lgiAcud3uQ+YOMUbOZbPZmNVqfWe32zcXGnwul1MhcAyhAxaaIAfhXRDfxxx0EsG6vlC7RkXGyRk8IH7ldDrvwXLwwxRcppIT3PR0jNwEryhKlu2HmFkJbn3bKwjfJEnqL2N4IF/QsnOfz2f6X/Fg7jB6jkM7epsA7YvF4lahUNAGiTmBakMul2uHuVylUtmwWCw95nIcetur1+ulZDLpx01+oEWfQqHQGkvPRK1WW0OLnjKXa7bbJSyTAijPD3xGT6/hwPegopxPM7T0LS6xRedx1lUul5MDMmCmgBmG2aYZyMuo9L2qqsZOo3EZJ18gPsBUAWoRnmAfoeemYWCP6BsCxK9jGeYwuzeiKD3sdDqCYRg6fUOYKkD7i5rW0HX9Jhme7a7fL59RPBgMrkP8o6Zpe2aeLJVKhY3tbSJ/TN8R/igwClTkxo/uLB6PX6B/0lgsZrDUL8CQw7hAk7nzC6ACJ4ZNb7ofiURusfAEqtVqEvMb5icEMKwuyt2nxLi1Wq0Nst/lTMtkMjdQ4ZNmsznw8/n8Pi7dZfT4JcvyFRYg1YUNF3yJKp+N+N1oNHoV+38NjvsJlVrU7ibkzRoAAAAASUVORK5CYII='),
('business-center', 'Business Center', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAD2EAAA9hAag/p2kAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAADaklEQVRIS+WUX0RkcRTHb01T09Q0/Zmamm4lTVMjrWWoVKsVK1KWpYdRypIhsSLRWytGItayL5eUfes9kWXFiCzzMiSyZIj0HGvpZffzvXubdrJS7Mvaw3F/v3O+53vO7/zO7xr/jwwNDXnKy8vnqqur37S0tHgc898TyLfKyso+lpaWbkkd8+Okqqpq0e1271Hla8eUk+Li4uPJyUlzdnbW9Hg8J445J8RMK9bn8y06pnxpbGwcBZCKRCIDJSUlJ21tbV2Oy24PVR/g/6wvmhobG/M6biMajXZhO6V1fRSSqq+vH3Vct1JXVxcHtMPSJVBzc/OA7LFYzEvCLxUVFXter/eMNn2lXXuFhYVH8gkjrIpLJBJuMDuBQCAue54ABuO+hOgH328c2ZSd74Lf7/8wMTGhxGcQnIsI3HvsCw7GVAztUeyluGTPSTgcNqliHoJDBasC+pwWKV+Lil8KR/VrrDe0lk0+YUiapgNTTpEp0zTnxSmcKg9AnKUNabaW+h0KhSJUuAnBBb5LKsuoHSJwFE5vuqio6EIY/Jvt7e1RxYpDXCTKcp8BOweg3ZqamnE5Ozo6QgCynCLCPsS9aGqOamtrX2kvraysHAdzJJ/2FBNWTFNTk/yWuMTJOmaw8TU0NLy4SYAaBG4ogB6nH6LC0rJ3ikXyE3R3d5tUNC8jxzrha9FrtStpAx6mScUo1uG4TYC4enp6zGAwqBPso+P0fUFAl8t1JSCaYX2qWZdqLZt83MOVsCTQA7M5xJVLAFkEp6XHwlEzzkVJXNiz/f39ISYkwf4tD8lWrWXr7e0NCjMzM2PHKFaJ9UhzCejhUypQ5VqvkvAcPVxfX/dh2h0cHIzdTSACtVY+YVZWVryKQbNM1Co2Fb7PoMQMZefYZ0zCiGVZbubazys9Xlpa0kT8MQH7OBPz7CaBsIrhtL7t7W0P/7QRxjib6wbZIiQ5oJ/fqeAC8PV9CVh79B7uJLhWrDjgO2htbX2C71Y4sg3+tTPS9yWgv8u8/KnfEygGlex2dnbKni+PSaC1bA9OwO91itFKcswMF5PgmPprrjFV58PDw0H6rTdySOWfpLpQ2ehxQBiGY00xihUHrz7J73/aobfvYJmPXdmNFhQUqNrnrG2hv9M8yDmp1o5Z9j5hWeYpCcX5z4th/AT9uxGk8+9UigAAAABJRU5ErkJggg=='),
('airport-shuttle', 'Air Port Shuttle', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfkAQ0HODnD3iAvAAAByElEQVQ4y43RS0jUURgF8N88ILM25YQhgmGRGCikUREF1WjgrqRVLxAaaSE9dlmrNlIaxVAbKVsktIqMyogihCCMUkfaSBjRwlIwahFFL8cW85/UHB9n9XHuOfee892IubFVs4S0YWns1CYmFZrHsFuH65ar88QW7yUd9du8WKHTA69ctUaBFv3ic0njRiU1SWlRiIR+R0SJzGFYpcBjK12x3jY9btgsJU30P2HCoD3oUumHMrWeW2u73mz6maWXqJAyAWJKfDSqVtwydz3NFaTQyVlcgz4vppLM7PDNuGNqjGrzVcRn5HnrlD8WRJkNC4tm4nwuMoS4/cLzWid1u581RPVJSKPT4UBw1h1DYB+6hCU1eJM5rNAZyPr+3diuOpgaNYJqjzJEWJXUIvr0+2BvxrDRwKJW0OycfEJGfPETlAe5KTHuO4jhU8CWGndzevIplMgPppjYND7sde51nlEeTPXqp/Fpv7KGGi8NuJTzP4o81KdbUeaRqIil2tSpMulQDkNSq00uuiwiGnJCvTETDmCXpF7sMBRULUepYjDindshrFasXZNhHe4ZnPXCcYOuaVTptLEsuc4tPQ7mXEGeVs9ckAd/Abksczi8YGqNAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTAxLTEzVDA3OjU2OjU3KzAwOjAw+W1zrAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wMS0xM1QwNzo1Njo1NyswMDowMIgwyxAAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC');


INSERT INTO public.room_type_facility(code,facility,icon)
VALUES
('radio', 'Radio', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCQIOOwDNMatEAAABs0lEQVQ4y43TT0iUURQF8N/3zTQyTBkFVogVpUUFRdEq+ofI4CKoIMxNUYtylVSItGkR0WK2boKMqIhsIbUIAsESoQk3FQYKLRRrUVghOkLJMCotHGZCar7e6jzOOffed9+9RJ0GN9WWr2EFaUKrl7KqzEaGtU3GpKw2yShpQot+X2XUR8fdLmNSvxYr/iUJQMpWe1x0SL97Jv6qzBs3RyB0wyWfLURkj9mky624aw7b4Xt0vdbp9TMw5qQRHHemgvihF9irJ1CQNI8uK/Utkz1yQR7HTOlAlZm4mPkiPax3meG+Z36hTh0oiMdL5LxO55YZkrIWsV5Pua2LxfFYraHCG8bkEMqzGNmdVGniQoUoQ9qInGndqv/HcMAXjVjljj5BtGFQaxHFfNAkVCjvwxHd2gRodtdZsNObIrtgyK4luJRhgylXjTqt3g+XjWvGW+lSwNdO/FnSfmPibruuyTuhx9pxyqjNCHQYlhAoMG0tQs/lTNgoYcCMj2pAuylDPsnaghrfeOpKMWmteAnFSqWscdTu4t50ehKo98qgAXMR35eUdlBjgJTz9qmOMOS898DcbwX8cqbha0JgAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE5LTA5LTAyVDEyOjU5OjAwKzAyOjAwV+m+jwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOS0wOS0wMlQxMjo1OTowMCswMjowMCa0BjMAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC'),
('deskchair', 'Desk and chair', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCQYKCCyD6Z0cAAAA10lEQVQ4y+XRMUtCURyG8Z92w1pyaC0H3foGLk06Cy4t9RXa6zO4SFODi5FjJQQ2JDTUVNBShG4tCdEHEBxquHq5kHq5s+9ZzvPnfQ6cc1jBZFK1TxXTCIE342wKYV/GQ6Avv7Cy5s5JRDV0A1uqC4W8Vox2ZT0Grp2ruP9X3lbwqhmbbKiZhNuXOaeXnaGgOF17nsObL8uxuu+I1pOFTSOfEZWShYZbPe/gQDtZyNlx4ReMdDRZ/nF1V9M6X8ZKScKhyxi1Hc2EpznlHwMfhrHJTfhOK5g/xREnDYTc4ZcAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDktMDZUMTA6MDg6NDQrMDA6MDCnHWJdAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTA5LTA2VDEwOjA4OjQ0KzAwOjAw1kDa4QAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAAASUVORK5CYII='),
('bathtub', 'Bathtub', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCQIOOQGIAPlQAAABpUlEQVQ4y43RPWiTYRQF4Cf5QrEt/g+t1EJpdJCKDor4g+BkgkobClFw0dJ0qY6CuIi4iIPg4iBOBqViHQIxkqWCWDurm0jdpEQq6mJsbVOHJISvTU3P8MK57z3351zYpt96OKI9HIhh3BVt3ttn1m7zNltU0eGHbltdVNTnsUWBgnsQ1S6PR7rdclhGStJV+90RAyPS4FW1Q0V53ZGW0GtM2WvfLRPVGuOemnKpSloLdknqtcVIdf1YS0FJURzPqoO3FlQUzCnXrd/IDoMG9Bts3KEVcub8kdt4h2EH7DEc7nDzP4Jr4G1dkHEav11ukpoSD/FDRmPGnLVsomntotshHngZ88AH7ww0FST1hPgJ12Oy0s7Lr+PPjRDPe9JwKSoQiApEa29gZW2NuktTntvroS7HdFqyos05d5sLPjvqvhdKdvql04JAxF8dvoVyj/tEBNtNmvBRZU25L6L6agMfdEHazwjYJCUhrsfkqiUDZ6R9NasoZ6HxlTEjqdDUq4KkGaN1b6oYkpWon38VpiVkDVVJpBbsctK8N82MFHHKDtNK8A8SgWGeU1MB+QAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxOS0wOS0wMlQxMjo1NzowMSswMjowMO9XhYgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTktMDktMDJUMTI6NTc6MDErMDI6MDCeCj00AAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAABJRU5ErkJggg=='),
('gardenview', 'Garden View', ' data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCgcGGhFVc0UPAAABnklEQVQ4y73Sv2uTURTG8U9roOmQklIUCzUIbRTqjyyiDhncHLqUDqKClA7qIKQoig5WUP8AN3dHEQTBOomDiFJwUBF/EGlrFLFWGyPBGmsah7fv2zcIUQc90z2X53vOee49/Otoc9ZG9T9UrzHT/tcNZB0D2yWw3kfDekCPPvPSSMmBSyQi9rAChr0zYkhDVYeUir2uatjncSCLj9TAoDsmVFQlLbvglp2oSoWisMNWz5A3ZYfXTkZF6uZklNCmEe8wZBJjrv1i84oCHtrVPFK/kjHXfY/ygZXTnFl73DASB3abssU2k1Hdoz5F58sO6ZLQFQKdRhWNOxNJOiWMRtmycRfdd1wyAPJmTTgVjcN+N2ViPqpOOOKbweCVvip7I+duJCh6abrJeq9Xpn0JgBdueysbA+5hvgno9ygA2lG24Llkyx1KemLGhwBIK1j6zcbWLTkX/vSCTVI6dK/U6m6qHN5mlKXD1WhYJ68XVJyOAWHW54HqKsBm5z1tMVLWQT9WP27RgGJLDyVJawMPiw6oea/WEqjJ2eCz/xA/Ac9masLiZBw/AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE5LTEwLTA3VDA2OjI2OjE3KzAwOjAwsBb2dwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOS0xMC0wN1QwNjoyNjoxNyswMDowMMFLTssAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC'),
('telephone', 'Telephone', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAACmklEQVRIS71VzYtSURQ30ZTnx3s+ny8/UBu/Bg3UaeOMmhY2KLYqaBEEIypRES1mETGV0rawTRS4KGhltKiE1iExEBgxi4mZolkUtKj/ot/x+erBjNa1jws/zj3vnnd+9/7Oue/p/stIpVI+q9Xas9lsAy3w7AaW9ylRfzAo+fz8oSymlOwHBEHocBbLwGKx9Nlg7UuSdAI5lEG7hdm1U1EUTyFwrVKp2FlQLBYlEFFOZUwj4HnHKqaXcZo3Tqdz/VfgeeF9t9s1shK0MpnMsvJ0+rDb7S/b7fb+XQSowxEsduDWCEj+hJFAlGV5cSJBMBg8GAgEmirC4XBTS+D3+2+SPwmoVRMxt3ie39yTAGaiRA6HY4ns78Dr9a7OUoMi0CJghwv5fD6k+pDkDCxpf418SN2aqcjpdPqqz+frgKCeKxSWkeARLuhJ+C8oFvpvU53wzgazRJi2KDla9aFKYDQan2P9kkqAFt0RRakOf5uZAC8tUGICNI7hIrlVH4UddRdsbbxeZ5bIbDavYYdbvCB8dLvdK7lc7ii0/oT1ty6X6ynFejyer/CHiPs280UbSzCSiJ5hLgAjiSSXa0h24j2AmUZwBa26gbh3qMPZbDZ7DKf6gGevQfCYYrHzz8qngv/CTIBLd3huLtwkJJPJWLlc9qh+PB4/TrGJRGJl7NfPzSIRdn4bu36gkeiZXq+/qEqE2B2YGnJtzdSm6JLzKGxbQ3DfYDDkVQLIswmTQq7hngT4lhQkWV5XgW55pRJgXpXlA/cIkGupVCrFVD8SiVygHKFQ6A75+KbdZeoi3NDrjUZDZEG1eto9zqkMjrP2sJNFHM2gBQg6JpNpAPRZgFr1UbOfv8xoNOrjOK5Hx9ICmv+dn/6/Gzrdd1KzHNBawrydAAAAAElFTkSuQmCC'),
('breakfast', 'Breakfast', ' data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCxkFBRkZEnTmAAABUElEQVQ4y83SsUuVURgG8J+fShCSXLAhEQdpUAoquDWpQ5vQmrsOFzKkP+BC4SCtNUhDdCMc3ESqLVqsO3XuooK2OAkhCAYNuSQO3+nc77t4iTYfeDjv+57nfc/zwuHCoefc6pSJc+u/fcj+a/yI98W0UiD0eqJzYKtd6PUpMccVv5yippYWuNyXGu46TMxxrAHWk+a7RnvpZ/aNRa4asmTRabqdMeyNoNp2N+pqIkxiXD3e3lBBILd0R61jvS0rOLJJ+bXc0itNu6WGd24WsklfQVDNX8jsapUaTgTH5hxAlEdpN1Q9txzjuvF/N7DjWow2Hf0t9nWVL5j1IsZfOi39MFISZy458ciGfvcgnRHXBbfSz6146WmMB72WpTNAU8Bta74JguCzxzJ1e6Y7bAZ6bFspfIEiZjT0G0r5gPseZB7602Xttz6W8p/mXUScAc5bS7wZ53TUAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE5LTExLTI1VDA1OjA1OjI1KzAwOjAwI+m7TQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOS0xMS0yNVQwNTowNToyNSswMDowMFK0A/EAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC'),
('ac', 'Air-condition', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAABaUlEQVRIS+1Uu2qEQBQVxUKjY9TV8YUakKAEAioEO7cJqUJgf0GwyR9stU3qNGEhkDpsL6nzDf5R7h00TTashnS7Bw5z78xwzuXOgzvhSKAoypoQ0ikK6XRd79I0vRzzv1DTzj9kWV4z8SiKMhB9Y8k/4kxVt47jZBiXum5u2OwB+L6/0jQNKvzJJEkq0zQ3nuc9417LslCzxHiywRycDA5irwGl9H3fAc6hbTs71Po2EEURDHRmYFm0h1vwOodQ1BZ4Ydv2C+YWpT1qmaNBVVUGPIpPSZJWhGi42PI834LpFcZTKAjCwxjDA+0xR826rhcwx3HwIKIwDFu454yu6zbAxZjPZRAEDWoy8d8ABreGYVRDzFqY5/m1qqr3GENb2BzsuXGD4A7jWYD/aRfHMasCDw9HaCeKYytgnbC5LMsiaAc72MmA6pbU8x6HlBsvQVEUJZwV9hv3POGIgAIa+CaWQ3rCcYHjvgAVIXQKbTzfiQAAAABJRU5ErkJggg=='),
('shower', 'Shower', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfkAQ0HKCdzEw8dAAABV0lEQVQ4y43TP0ubURQG8F9jCJjFUn21FFOU4h8sUpN06F6cLHbRRTqVEtBPUESc/AYOJU7OfgAzdBBpIR2iIjoK2g4F0cm2jqaDxL7J+8ee4XLuOc+5zznPvZf/sy0/VCAbk3xl0oOO2DNrt04mAl/0MQKn2XKiDAtmrHue1Fu0oNuwrJcd0b2W097SY+8F5hW8092WObFy67R3u+2zP2DCldX7xWvceWXV+2eY9jBUkvPCYdrpr+3qC+1H7RlNhuccGOiIldSiwJZKb9Scd+T2NQ0lFRR9jeH9ErmPu6HHZQxGCibcxDPM6PI9lmHOkziGHiVPY8Uo6PEzSakuvaA/tKZa0SfwLbQmysoH8FaAkiICs2nnN2Q8UlUWqKgI4t/TP4YdY5Ydu7DpzKlNl47SZyirmpLXUFAIPcM2C/+HvBFLNuRM4kg9fWiuHbpyre63X/Fw/gIzqz2TY9zArgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wMS0xM1QwNzo0MDozOSswMDowMKOtrvEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDEtMTNUMDc6NDA6MzkrMDA6MDDS8BZNAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAABJRU5ErkJggg=='),
('alarm-clock', 'Alarm Clock', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAADfUlEQVRIS72VS0hUURjH7zjPO3rHme7V8W2Jpjg6i0QxzSyCHlQIYdLDkB5Yi6Ba2kaCoBbtI6I20YsQly2kVUQQFT2JFhFRFGRZam206fb75h5tppmR3PiHy3fO/3yP833nfOdqS47S0tKGUCjUV15evr6lpcWr6JwQHdENRSJ9ZllZvaIzUVtbGwoEArcY2nOfz+d7W1FR0SrrguHh4Tzbtl1qqkWj0TaPx/OG4bxNMBgcqa+vN2Q9Dbqu33S73QnDME7HYrFO0zT7Mf7AN06gq35df5eXlzfjcrlmfD7/O9Fn7avX5/tAxruam5u74E7hasbv999wvCo0NDSsxNDG+VlFaZFIpIOArxjayHGMRvnOyUemoxJYrb0mk3VJI4CPM+KrsbGxVlGaVlNTswNhW5bVLXPDKDwgO8XJ+3A43N/d3e0RPhXChcPmHnTeklmioKDgiPBFRUVrEHZ1dbX4dMDBrkLYpHqYIH04T7DLO62traaj4YADtXBcoKZJyNlRwtsME9jvJtBBxjZVWZ1UEMjhofSM3Xwh5e+U4VF7e7uulufh9XofsH5RTedBED/298lkiu8T9s/Fp1p2UFlZGcPBhBxkVVVVo6L/xQu+q84wHZS5juCzbrdngjOJKfovent7dTKY4rZcV1Q25Awg4IpeYYM/smWvUfu1CJtD2ukwWbFgAMuKbkOIj80OkwKiDyLseFvbCofJigUD0AsVCLuwsPC4w6SAJhFSujGYJLKA2yUB5ruWmv+mIbfLmqCnpycsPQAnDZcOMjiEsGnz5Q6TCZpInJ2c+6j3UF1dXbmsCbhNyQyWWdYJh0kBb440mU0H73KYxaOkpCTZsGSwwWFSMDAwEOAWfafBRhS1aFCFa/iYHhwczF5meWdIO1FcXBxX1H9D+gjb2fz8/POKygRPhoWSdPNT0sx8cnOgo6PDoJMfsftJmrRU0dlBmlsQM3T1vaampqjD5gZvjskNvCuZcwa9is4NWr6KDJJPMTv6TNMc5ZHLqKlwQcPYj+5HpnJlJ9j9Qj2kafF4PJ9zeIzjn5RoHwf+EFqMfzIeowwXkBfY8RgZ/pA10Q+b5l7u/zf0nrChtNc2DRgeQ/E3qc49Fy7OZSNP8GUcv6R808hJAj0P6PolnG0SHVHkv7EV8QvdIZlnhdSTN6lLTRcNNtNJsxWp6VJA0/4AY/fAEJ0jQ7wAAAAASUVORK5CYII='),
('bath-robe', 'Bath Robes', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAADhElEQVRIS51VTUgbURBeEjc/Gzd/RkNCoiTESEVzCXiRaCuJgpj0UmgCotBCQAQplELpRemlIAERpJBLpTexCIUgePZSAoEQECEIEiiIUAQv3vvN6+zmT0noB8O+mTd/b2beW6kfHB8fG+fn5yM+ny9ONDMzEyIZb/8/xsbGLFardctisdxYFKUyMDBQMhgMpcHBwSrkt6B3KysrCqv3D7fb/UyW5T1QAw5vEeg5b+kYHx9PyLLpjoIj4EEoFIrx1tMYHh6OwOm5yWSqwCg/MTGhOp3ODUVRvrKKDofDcWC32zeTyaQDdpvQqSHYL7/fH2WVbiDzLTjeZVYgHo8rlCW+DhZJmUxGNZvNv8k5iwRgX0BCW8x2A1nsqapzlVkdkBdsNptuODQ0tAG+61RwvorAe8x2A0an4XB4ltbr6+sWIQRGR0dDOEVdmxw0txaNRvWaa7qQzWLvVAgfgyybL9PZrJfWmJiTVidk6PF4ltHMBE50zmJpamoqhr79pPXi4qIbJ6iLjceAIxZ4KamqWo7FYnrD0MglBDlDj44Q6DWLpcnJyQh0K8yS3R9etoMmBiVaYFYyGo3VZCbjZ1YAAerIsJHP52UWSdls1o/T1pilMlfpIjLbBAXA6OnzbrXZbg4PD/U+EDCW+9D5zKwA9YWmjFlK4gg6eqI6RkZGUngGXjKLcrnueCmQLxZlOLqenp4OsEiHy+3WdVHmL3R3mG3CarXtYo7fMiuZW7IiYDQXUP8Ss21A2XRd9GCNxprZJjAJP3CDy/TeEKGWDd7SkLbbnUVetwG615od+UDAE95qArW78PmCKdQvjlovQfQAounQ6ArvEk1Iq0yjB7Ih22AwmEIpLyBrB45/l82+8RMlEi8WUMcqLlC8k7xe7wlKuYZgtVwut0Qy2Jbn5uZSmj1O1NY/aXt7W8FYlrEUGcG4DrrXeCZxAj5FmmQoySW+D7C9B12xXsUAX+QT68eB25pGHb8zq0H0gPsgAlD29EXdv+EVJVl/QC1fOZ3uzoZ2BcBTQusKJqzocrn0290TCJDHVLVdKEAEQG+KaOIZlSociRQCgUAO5dlBH/Ks1xsI8B7vzSdmNYgA9FOiNWZ9+Z9Y3JGPOMEHZnsD2e/AQWdGT94Dyp5smO0Nh8u1j3tBv8CSRnBQlk2mRqtMI9LFCQ7YvDfwJnnwoQnpmzB54j/SDkn6C+E212iyM38NAAAAAElFTkSuQmCC'),
('water-bottle', 'Water Bottle', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAACBklEQVRIS2MYFEBRUdGXg4NjIy8v72oQ5ubm3gwUtoLIUgEoKCinSUhLx2RlFcuDsJmZWSFQ2A8iSwWgrKxsycrK+oKRkXEiCAPZr4DC2hBZKgB+fv5EIC6FchmAQZQjLCycCeVSBkRERIwEBATWqaurN4SGhjJDhUGWLABaagjlkgeMjY1FeHh49mhoaPioqalZQ4XBAGghL1Buh7y8vABUiHTAyck5j5eP7yws9aBjoAUngGpmQ5WTDvgEBFZDmTiBoKDgRiiTdEBzC4CRuwZIMUJ4WMD//4wUWQAM4yxgamkDMj1hWEFBQR6YRE0lJSWNgamoHZjK8kFqyQKioqItEhIS9Zo6OkkwbGNjowaywMzS0gloeBUwslugykkHfHx884DJUQHKxQCqqqrSQF8shXJJB0JCQgnAQu4MMJzXw7Cenp6HnJxCHTCoStnZ2U9xcXElQJWTDoCRvCokJIQTysUAHh4e7CBLoVzSAVBzJLBg2w0s4KbCsIqKij0wbnKAcZMO9N1uYE5OgionHQB9MA0YFHatra2iMDx//nyOKVOm8IAwUM4eGMlTocpJB0M/JwOTKc2LilpgTs5mYWExFxMTPwQsvlnt7e1ZgBF8GChtCnRADjAp10JUkwHq6+uZxMXFw4HFQpmImFg1H5/AeqCha4HsWpAYUC4CpAaqfCAAAwMAZNlr/WRqvvAAAAAASUVORK5CYII='),
('closet', 'Closet', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAACuElEQVRIS71VS2sTURQe85g8J5m8yGSaOEkxAYNgN0nATYiLkBQrRZtd0oULF1IakFJcqNm0+KgobtQIUkFDd1pEhCJICFWEdlV8LVxZcOdviN/J3KRpOiRjoX7wcc6cOfd8c899DPdfYDQa7wiC0NSi2Wxu2u12zXfDSDVZeY6jQLvdPgb3AEVRbASDwUX403rJ8/xFi8XShK+CBGCo4AFIkkQCy5IkX4fY93D4+ALyf5GVZfmGw+H4Rr7P57vv9Xo/RsfHb1qt1q+RSOQ8KzFCQJYbMAoXCtn9fv8tiqHQNlm32y2C78gHTgcCgSflctmBenvtIegS6IPNZnvp8Xguw0U3+Pf4+rPw/WjL51gslugk9UOPQKFQsLhcritoyWtqAc9bvmDcByzmT2yCHUFwtQwGwy7ErpVKJaM6mkGPAFrxnASy2ayf4plMJup0OlfQrhWaAWaynUqlJpC3hHpLlNODToEt9LiuRjkOLXJj3Bra8gZ2Ftv5B9Yoiw3RQGydpanQI4AcH7ilRjtQPD7fBr5agr8aDoezyWTyBFr4CtarpjDoESBfFL2bZBlIlN4RVicymXgikYihjS9YbA+DAphqAr29FI/Hx45EAJgPhkKPBwVw6G5jLTa7RLGOFZglIucq5e7DoAAW8FQ6nQ6T3y9waGjMoAcmcAYkEV3EQex8XA/DBLAWDUx7g7afXmKb7larVZGVGC5Atyn2/w74SS8h8AezWGYlRgtMTU2fUxTlwphOViqVkzgPVFPFKIF8vjiHe6aFx/kucQc9hH1mMpme9sdReB3Xxsw/CRSLxTm4D9SICpzcRRT5jTNzl4U6iEajC4cSQF9bNLifuJofDcawId5qCtTrdXOtVjMNErtoLZ+fzGHRZmigHuZyk8o+AfpBU0CL3Z++1rthxLh7rPxRguP+Amhz82949CtqAAAAAElFTkSuQmCC'),
('coffee', 'Coffee', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfkAQ0HIBADdyAaAAABVElEQVQ4y6WTPUvDUBiFn1gRWiviUERwqajoUO2kS2uVLn5RK/oXRMHFzdnfIILgPxAH20HESQgIaQfBiA5WHKoU2sl+qiB1MPfSpGki+Aw3J+eew817IfBvQoSBKcJSu7BIBlhCk9qFXuqAn5rUJrraCgvoltUFjVUgw4rULtTwAXW8Urt8kk7MsprwtBWyvFMkS5mioU0oxnOUpE1Z8M05OXMhxxXljoV+4oybC02p7GmywRh5TkWswQAfHeM+KlyiM8+tsJ7FkbZM8ATAIAVxrRpRh0IUzZjlU1jrqA6FGxLAEBn2hOXhgUSHeJJ7ghxQZL/1aiK8EbSJz1BBp8AhI9atbV4IWbxpXkkRp1sYCrv4W7YTXLdMM0eMFHfyvcqRwhnLnNAwrD6GeZSBSfJUDe1liws2FXo4JkKaEk4EWENlh6/fqWeJEHAslFD/8n/b8ANLVVbZJSxjYQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wMS0xM1QwNzozMjoxNiswMDowMDoOHNsAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDEtMTNUMDc6MzI6MTYrMDA6MDBLU6RnAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAABJRU5ErkJggg=='),
('fan', 'Fan', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAADVUlEQVRIS8WU20vTYRjHf2ubO/x2PrizM10oMxxzDAaNBrkLbwqi7KoSlPROuogwkiQvFPFCM4woCSs0vIjoIKWBSczEAwh11UX/QDf9C33e9TqWy5EU+IWX3/s8v+d9vs/zfQ/KoSMej7vsdvsVk8k0a7XZVi0W64eamppHTre7r7m52S3DDo5oNGq0Wq2jqqoWIOhtbGyMMVrwDft8vgm/3z+iqtaCiMlkMia57O+QTCaDIjGJejA1v7yKAlE3/nGXx9NjNpvXHA7HJYfDdZn5R7oJyLDqaG1tJYdaQJqsdJUgCKi4W8xTqZSexO+dTudxvV6fsFgs62JtMbAaCJwkUWdDQ8MxEtyy2WwPSdrf3t7uLicQICZrNBrvijnrzpktlqnij/2AxhESrLjd7osms3mV72lkakGSbsg2qfZOOUEikXAYDIY30lTo/F0sFgtLsxIWm22AhDfYvI+5XE4n3UV4vV6/Tqf7Xk5QV1d3ArvYgYDH57tAxzelWQkqWPR6fZOicukqQWy8Vq/f5oguNTU1BTs6Ogx0tUxskwxRstmsE8lKHVUA9oJGo5kmQT/jTPlA4+VQKJQRukPyCWl2guHw0/IYcZSRcUOmqwSbWECGk0yv7w6DwfRMq9X+IOm3dDrtb2trC1Dl5/IYMShggu80He1PQAcrXV1dRmkq0Xjcz8It5IkiRxK9d/h+8Xg8KRlSAhcv53K57hG/Il2VgGCMLk5JUyHh7dra2rPSLN4DzvxXTopBukqAeA6SQXKMS1clQvX1CQLnpSk2/XU+n7dLc/cmv2IsiWdD+IRs2NNoP0lBc5Ani8H7wayqz6kkLea0+4Q3qbn4A+xetHA4nObfPNWusx+LSNMZCARSEL2QofuD4BCL1sXbgjx55jPy129PRTnEEYZwIxKJBKWrOpApIUjqkYxneoRKZ7lUcU5I314CpGnhyK5BXl2avUCmKC2/ZeH9UCQyYFLVx3S3QsLs0NDQEe6EKGIKwiXIj8plBwd65yCa4Wne4i5sk3QHkk2+D8Q/GfZfYEOKl2IMj42Vnod/Atc/yEZf9fr917hcg9yBTTHwjwmf+CdiZPjBwQYvoHsPJ+T8nwakvci2IMMPDh6+UU7UarUhYmT4YUBRfgK3Oa0mu550jgAAAABJRU5ErkJggg=='),
('hairdryer', 'Hairdryer', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCxkFCCoTbGu9AAABTklEQVQ4y+XSMUjUYRjH8Y//S4iQGuKSDsXS4/KuXI4gl7bLW7JNnBMyKJGGhoio5dYGB4dwMAJJKgQbagnaQm1pCMK/dtcpUYIFKhkkdzicIJxpV+DUb3qf9+H7PL/3fR72W3V/yEc0i4kqe+PbbsBBSaed0S6hDXlxnzUadtuvaiDmlYQfpoVCoTmflIwpGPXIim6OGjIgY8RZpC26YaKqTJf3OOSD64EpUVc9te61FDas7nhnq6Q7ym66wgFQr3JKy+ur6nDeuiFfXHPcz0CTx3J6PZfZ5afeeWFQ0UtNlgOTvjrnnikPpH4LrMlZ0qnglvHqZNKGebMGZJ0U2bq9a0xETtGRnXOI69AuJemUeh+FQpdNO6HkkoW9t6BFVsEzDy26L6hted66gCf6K2GN1Lb+D2BVFMes1Fqyx3cz5hyu3UXCRQ1/a/3ftQlW8FIL1iX1iwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxOS0xMS0yNVQwNTowODo0MiswMDowMNXfB/QAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTktMTEtMjVUMDU6MDg6NDIrMDA6MDCkgr9IAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAABJRU5ErkJggg=='),
('mosquito-net', 'Mosquito Net', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAAC+0lEQVRIS62Uz0vTcRjHN9zv6Ta33K/M5YIkQ8mGsDIaVDgoQe1QQR7UQ0RBXbpUYnUIL4IVFHTIgg5qdgltpTdvOxVe/Ht6vT9+5oTN2MoHHr6f5/087/fz+fX9OJqx9vb2sNyGh29tbW0TwWBwwoaHbm6/378o13gXOiRj5ud9Pt8Gs78l11iYTf+7tba2XkBsFX8Ti8V6iIckjJ8UppxqbHlj1tHRkWQbHuKbXq/3JcLpQCAwjGieAz4mj0ajeWHKUTdHo01xxLUy9Y3CZxQu4aO9vb2eUChURHgqlUoFSDt3q4w5hZGbpmZYtXDGLPe5rak1GqxDGGRmgyx9nJketakDTTWqFY9V5dD4blO1RvdSMpnMFAoFl2IIMxzqFr5+gG8h+NSQHQ6XuGjUbxCPxxMUL0K6ksvlzDXkDOa6urrOMsMj4KfD4XAkm82GiU8Jg9OnGtVqm8RF40Mmk6k9C5KXSD5iXycttNcA/CMzmydewpdZ2Wu+n/Y3kIFPSkNaFqoaAvcRH2FmBQuZBsQzkMoWqpiTXBnBJ/sbiIvGNWlZqGqIvGVGWQ7rhIXUdBn8Bv4bsQEExsFGGZ8B+6Uc8Rdb7hA3kUh0S8tCVQNcY4+P871oISfknxqw5Nsej2eW+C5+j1m/ADNvEvEP1WosLhrdYLUHDVjS3ulHUsy4D2zeJP9iqolEIv0aiwvvck2Dzs7OKLP6zP71WEjEB9pPhi24rm09b2G7rqqWsTFpSEuaFjKHM8TyHuPnCCvLXdWTwNZsu1yulXqO0I6eB2q/ioM5pSEtNKtvFLO4wyzG6D6lWMuEvI34e74Lbrf7Zj0nt4LYrGrFEReNacTHpKnYGEUL3KB+wKJibkNZhcQNuRU1V5m4yJn0oflKsTGCb/l83l95eyBsmEQTVuFIgz8ZSd+aScjYnhLLzNJ9QPH/NJCGtPZukt4dwHcs8breGWHs544Izbg44vKjxYlHpFl502qMZiU7bNia4qTT6ZgdNmxcjOq93zOH4w9S9Jj34BKZaQAAAABJRU5ErkJggg=='),
('safebox', 'Safe Box', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAACs0lEQVRIS71VzYtSURR/Yvr8fs9v35imjqOB2hODcKjRzQwazCKmlLFm2kQ0G3fVbrJtVIsICenDhtkUwVBBQUUgMQyTbqKi/oHaDPQ32O/oTZKZzK/6wcF7z9fv3nPOu3L/BUql8prRaKyNUygnS89xpGg2mwosxyKVSkWl1+trWLdBBPhRuNzuZcFsXh9FXC7XcqlU2rcnATl4PJ4Zr9frH0Yo1mQyrfckIMe2thvhcNiH4BUSn893gKl/h2J6eiZlsVieFotFfiACJC0gYNtgMNzH+iH8G9gXmLkF7A+pVKqvPM834HeybwJZlt1arXYTiW86HI4LVodjBQmuQ/cOt5pgbgQZ9jJud1GtVp/qmwC2JVEUN2w223kEVbCvgOAc6bA+y9w4QRCohJ80Gs2O2Ww+tosgk8lIVqv1ZSKRmM/lckpmQnnE0wiq4nQFnU73GMkfSdL+M0hQBckSc2shFAr5QbJ3kxH8DB9HGTX8gFrKzMTF43E7bHWQP8At8jhdHo28C6I6EtqYWws9CaB4ns1mTZIklaHqEBCQ+LjBYGzAj8qyAd9tp9M5z8wd9CRAklWcfgcne49Tepipg1gsZna73TmcfoHWTN2FngT46fkdIPERBG+hmVuBqanFo6nUXDKZnA0Gg3ayo2/qSCSyiL68TqfT4sAEKNEbqjkl5HnNd6iuKBSKqyD92PbgZAxDHeP7aqAx/QX4PMEkzUqSZw6l/IGmb5LgRi+Yi2y32+8hfnUoAr/f74TfHUzULZospu4AZBMmUXwL8m/oZ2Jggn7w9yYLwhoMVTrlMEKxmMK1PxJEo1Hn5OTBw6MI5dhFgLrV8EhdoodqHBIIBC5TTpae4zBaNeo8xuwztieGFTw1C8jxBafPdxHQHzRdCULPxEhAL25TLrxnN5jqX4LjfgImpABvXjNxrgAAAABJRU5ErkJggg=='),
('towel', 'Towels', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAACcElEQVRIS+1UTYjTUBAOpGnTpGn+tmkbU/pjaCm2ZUtAvEhPIiykgtCb2NuCeBEWYS/SIogggghlodCLCHvoSVgE8SiBEij07HnPgnjx6jdprLJmIbl52A+G5M2b9828+XnMFf5vOI7DKYri6nphqqp6LNE07Zlpmm5IEQ0Y7AuC8DaXy21EUXyRzWZdchRT7uHsLJ/Pz0O6LTqdThFkT1Kp1Ibn+a8weor/m9hyLhM6g28kwPWp2WzuBQt4fQiFz3HcSyyncQT2ryArWZYPsf4HuMF73NxkWq2WROSTyYQP95KABYl38SalUukADlbL5ZKltQkHC8q7qqrrJNJut29LkjTDzR3bti2k9hipRSbSP6vV6kHgbTAY8Ol0xsdNzECRABQ5yM4RrYeG+Kzr+gMQ8+Qsk8n4xB0YGoZxBwX9gXxGRholZMuy7He05azf71cDor8Apwt8TIbyBGMP3t3RaBTkLA7m8zkHR3epBhHniHONOZIZEJu43mmhULCxEdkxl0mlcv0GarAQFaWHNTMcDiXqSNTCR00fk44pl8t7UHwkb71ez00ijUZDRlE/1Gq1QzGXe4dAfZoffF+Dk1K0BbrohLqhWCy6lUo9lpAtEaGDvtF5y7JoKHdA6s4o+GCBgjyC5xWMp9iIJYGtIHiow3FAcgEI+BR2Jj1oMl0NutgF/g0qLqL36vX6btBIh866DwdfQtV20FDkffyfJRHDuHZLUbQT3N5BimxE/Bxca6zfIPBtesbjMQ/lBl6tQJEA3W7Xwvyco8ArKja9pPTEh9t/gGI4NI2qpkUOVZSAzBclyUO/H+1ezSskB8P8AloTxYUSPrBRAAAAAElFTkSuQmCC'),
('tv', 'TV', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAAB90lEQVRIS+1US0sCURQeUYfUGWd0ZnzM5PhME6FFi3IhuA8hCnQWYZusRdROCVobLqpNL6FFSgVJ0cJa1bJVEFi0atNPCfpuTfSiCByoRQcO13Pvud93znfPSP3b37B8Ps/QNL1nNpvXjXBg7eZyObsOT1EIRJfLdR8MBo+McLfbfZ/JZFw6/DOB3++v62HXpihKvSsCQRQbFotl22QybSHchCx1EguCUCXnXRMQGQBSxTpCYvyexv3pQCBwrMfdE9jt9gWPx1OyWq1reL8Sy7KThhJgUsp+RZkhBBzHGU/AMMyULAc0dLLo9Xo1nudHDSVAxUI4HB5yOBxziPshE2coAWQZx9QcOJ3OG47nD0E0YCiBz+drq6o6lc1mxVAoVEYHjW8JJElq4QtM/sSV3t4TaH4AifK4l4nG4yV0tCHL8jk5x3S1PhGgxQtMxCoebQ1bsx8d+6uCJHWIQ5ZLm802jKrPAHyL9RQKqFivSS7BekdQLBYFPFoHCfu4sM+yXO2jo+IGgAl4h+P4K/xB0oVCYTCdTo9pmpYkOKj+juSSHEjHP4G/WCqVmozFYiuiKDYrlUrfd443aEOGCEgJcQ2FLQGQQZcPkUhkOZFITOiwr4YDFW03o9FoTN/60gA6DznX3zpN92xiqsr4AHcIlp76b79uFPUIWTe6SVO2WcAAAAAASUVORK5CYII=');