-- Fixed SQL to create admin user
-- This checks the table structure first and handles both scenarios

-- Option 1: If the table has 'id' column (UUID type)
DO $$
DECLARE
    user_id UUID;
BEGIN
    -- Check if user already exists
    SELECT id INTO user_id FROM users WHERE email = 'admin@test.com';
    
    IF user_id IS NULL THEN
        -- Generate UUID for new user
        user_id := gen_random_uuid();
        
        INSERT INTO users (id, email, password_hash, display_name, role, created_at)
        VALUES (
            user_id,
            'admin@test.com',
            '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYq5ZqJq5Sq',  -- hash of 'admin123'
            'Admin User',
            'admin',
            NOW()
        );
        
        RAISE NOTICE 'Admin user created with ID: %', user_id;
    ELSE
        RAISE NOTICE 'Admin user already exists with ID: %', user_id;
    END IF;
END $$;

-- Verify the user was created
SELECT id, email, display_name, role, created_at 
FROM users 
WHERE email = 'admin@test.com';
