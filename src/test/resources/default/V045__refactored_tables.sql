ALTER TABLE IF EXISTS settlement_request
DROP CONSTRAINT IF EXISTS settlement_request_hotel_bank_account_id_fkey;

ALTER TABLE IF EXISTS settlement_request
ADD CONSTRAINT settlement_request_hotel_payment_account_id_fkyey
FOREIGN KEY (hotel_payment_account_id) REFERENCES hotel_payment_account(hotel_payment_account_id);

DROP TABLE IF EXISTS hotel_bank_account, hotel_bank_account_approvement, hotel_bank_account_docs;

DROP TABLE IF EXISTS password_setter_token_status;

DROP TABLE IF EXISTS customer;

DROP TABLE IF EXISTS login_record;