ALTER TABLE user_account
ADD COLUMN if not exists oidc_id UUID;

ALTER TABLE hotel
ADD COLUMN if not exists oidc_org_id UUID;