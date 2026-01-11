-- Final working SQL to create admin user
-- This uses a pre-computed bcrypt hash for 'admin123'

-- Make sure you're connected to 'GamePost' database first!
SELECT current_database(); -- Should return: GamePost

-- Delete existing admin if it exists (optional)
-- DELETE FROM users WHERE email = 'admin@test.com';

-- Insert admin user with correct password hash
INSERT INTO users (id, email, password_hash, display_name, role, created_at)
VALUES (
    gen_random_uuid(),
    'admin@test.com',
    '$2b$12$a7ZuKGAbjRhZWkOpCPnM4eX1mA63uqCQ7SEZTRiqdPOmwEfR2c4km',
    'Admin User',
    'admin',
    NOW()
)
ON CONFLICT (email) DO UPDATE 
SET 
    password_hash = EXCLUDED.password_hash,
    role = EXCLUDED.role;

-- Verify it was created
SELECT id, email, display_name, role, created_at 
FROM users 
WHERE email = 'admin@test.com';

-- Test credentials:
-- Email: admin@test.com
-- Password: admin123
