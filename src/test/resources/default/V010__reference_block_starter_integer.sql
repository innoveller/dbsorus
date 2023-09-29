ALTER TABLE IF EXISTS reference_block_starter
ALTER COLUMN next_block_first_value TYPE INTEGER USING next_block_first_value::INTEGER;