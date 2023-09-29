ALTER TABLE IF EXISTS agent_hotel
ADD COLUMN IF NOT EXISTS contract_expiration_date DATE;
