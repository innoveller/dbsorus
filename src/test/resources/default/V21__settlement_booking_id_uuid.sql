TRUNCATE TABLE settlement_request, settlement_confirmation RESTART IDENTITY CASCADE;

DROP TABLE IF EXISTS settlement_booking CASCADE;

CREATE TABLE settlement_booking (
    settlement_request_id INT REFERENCES settlement_request,
    booking_id UUID REFERENCES booking,
    PRIMARY KEY (settlement_request_id, booking_id)
);