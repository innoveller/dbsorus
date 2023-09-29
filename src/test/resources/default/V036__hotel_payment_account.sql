CREATE TABLE IF NOT EXISTS financial_institution (
    financial_institution_id serial primary key,
    institution_type text not null,
    name text not null,
    abbreviation text
);

CREATE TABLE IF NOT EXISTS hotel_payment_account (
    hotel_payment_account_id serial primary key,
    hotel_id integer references hotel,
    account_type text not null,
    account_holder_name character varying(100),
    account_number character varying(50),
    financial_institution_id integer references financial_institution,
    branch_name text,
    created_by integer references user_account,
    created_on timestamp without time zone,
    updated_by integer references user_account,
    updated_on timestamp without time zone
);

CREATE TABLE IF NOT EXISTS hotel_payment_account_doc (
    hotel_payment_account_doc_id serial primary key,
    hotel_payment_account_id integer references hotel_payment_account,
    file_name text,
    s3_key text,
    created_by integer references user_account,
    created_on timestamp without time zone
);

CREATE TABLE IF NOT EXISTS hotel_payment_account_approval (
    hotel_payment_account_id integer references hotel_payment_account,
    approved_by integer references user_account,
    approved_on timestamp without time zone,
    PRIMARY KEY(hotel_payment_account_id, approved_by)
);