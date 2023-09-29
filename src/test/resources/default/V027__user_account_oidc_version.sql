ALTER TABLE IF EXISTS user_account
ADD COLUMN IF NOT EXISTS oidc_version TEXT DEFAULT 'To be updated';