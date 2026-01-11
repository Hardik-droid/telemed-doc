-- SQL script to create admin user
-- Run this in your PostgreSQL database (using psql, pgAdmin, or any SQL client)

-- This creates an admin user with password "admin123"
-- The password hash is pre-computed using bcrypt

INSERT INTO users (id, email, password_hash, display_name, role, created_at)
VALUES (
    gen_random_uuid(),
    'admin@test.com',
    '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYq5ZqJq5Sq',  -- hash of 'admin123'
    'Admin User',
    'admin',
    NOW()
)
ON CONFLICT (email) DO NOTHING;

-- Verify the user was created
SELECT id, email, display_name, role, created_at FROM users WHERE email = 'admin@test.com';
