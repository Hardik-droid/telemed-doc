-- Simple SQL to check table structure and create admin user
-- Run this to see what columns exist first

-- First, check the table structure:
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'users'
ORDER BY ordinal_position;

-- If the table has 'id' as UUID, use this:
INSERT INTO users (id, email, password_hash, display_name, role, created_at)
SELECT 
    gen_random_uuid(),
    'admin@test.com',
    '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYq5ZqJq5Sq',
    'Admin User',
    'admin',
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'admin@test.com');

-- If the table doesn't have 'id' or it's auto-generated, try this instead:
-- (Uncomment if the above doesn't work)
/*
INSERT INTO users (email, password_hash, display_name, role, created_at)
SELECT 
    'admin@test.com',
    '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYq5ZqJq5Sq',
    'Admin User',
    'admin',
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'admin@test.com');
*/

-- Verify:
SELECT * FROM users WHERE email = 'admin@test.com';
