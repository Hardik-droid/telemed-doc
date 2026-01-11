-- CORRECT SQL - Make sure you're connected to the 'GamePost' database first!

-- First, verify you're in the right database:
SELECT current_database();
-- Should return: GamePost

-- Then create the admin user:
INSERT INTO users (id, email, password_hash, display_name, role, created_at)
VALUES (
    gen_random_uuid(),
    'admin@test.com',
    '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYq5ZqJq5Sq',
    'Admin User',
    'admin',
    NOW()
)
ON CONFLICT (email) DO NOTHING;

-- Verify it was created:
SELECT id, email, display_name, role, created_at 
FROM users 
WHERE email = 'admin@test.com';
