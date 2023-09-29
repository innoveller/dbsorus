CREATE TABLE IF NOT EXISTS reference_block_starter(
	id INTEGER NOT NULL PRIMARY KEY DEFAULT 1,
	next_block_first_value TEXT,
	updated_at TIMESTAMP DEFAULT NOW(),
	CONSTRAINT single_row_table CHECK (id = 1)
);

CREATE OR REPLACE RULE reference_block_no_delete_constraint AS ON DELETE TO reference_block_starter
     DO INSTEAD NOTHING;

INSERT INTO reference_block_starter(next_block_first_value) VALUES('10000000');

ALTER TABLE IF EXISTS booking
ALTER COLUMN reference TYPE text;