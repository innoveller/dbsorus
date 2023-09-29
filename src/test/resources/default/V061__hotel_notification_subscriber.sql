CREATE TABLE IF NOT EXISTS hotel_notification_subscriber (
    hotel_notification_subscriber_id serial primary key,
    hotel_id integer references hotel,
    email text not null,
    display_name text not null,
    created_by integer references user_account,
    created_at timestamp without time zone,
    updated_by integer references user_account,
    updated_at timestamp without time zone
);