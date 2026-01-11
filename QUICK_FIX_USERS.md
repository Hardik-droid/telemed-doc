# Quick Fix: Create Admin User

## Problem
You're getting: `column "id" of relation "users" does not exist`

This means the users table might have a different structure or the migration didn't complete properly.

## Solution 1: Check Table Structure First

Run this SQL to see what columns exist:

```sql
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'users'
ORDER BY ordinal_position;
```

## Solution 2: Try Without ID (Auto-generated)

If the table has an auto-incrementing ID or serial ID, try this:

```sql
INSERT INTO users (email, password_hash, display_name, role, created_at)
VALUES (
    'admin@test.com',
    '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYq5ZqJq5Sq',
    'Admin User',
    'admin',
    NOW()
)
ON CONFLICT (email) DO NOTHING;
```

## Solution 3: Re-run Migration (if table is wrong)

If the table structure is completely wrong, you might need to:

1. Drop and recreate the users table:
```sql
DROP TABLE IF EXISTS users CASCADE;
```

2. Re-run the migration:
```powershell
cd Backend/server
python -m alembic upgrade head
```

Then try creating the user again.

## Quick Test Script

I've created `check_users_table.py` - run it to see the actual table structure:
```powershell
cd Backend
python check_users_table.py
```

This will show you exactly what columns exist so we can create the correct INSERT statement.
