# Admin User Setup - Final Solution

## Problem
You're getting "Invalid credentials" because no admin user exists yet.

## Solution

### Step 1: Connect to Database

**In pgAdmin:**
1. Right-click on **"GamePost"** database
2. Select **"Query Tool"**

**In psql:**
```bash
psql -U postgres -d GamePost
```

### Step 2: Run This SQL

```sql
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
```

This will:
- Create the user if it doesn't exist
- Update password if user already exists

### Step 3: Verify

```sql
SELECT id, email, display_name, role FROM users WHERE email = 'admin@test.com';
```

### Step 4: Login

In Swagger UI (http://localhost:8000/docs):
1. Go to `POST /api/v1/auth/login`
2. Enter:
   ```json
   {
     "email": "admin@test.com",
     "password": "admin123"
   }
   ```
3. Copy the `access_token`
4. Click the 🔒 **Authorize** button
5. Enter: `Bearer YOUR_TOKEN_HERE`
6. Click "Authorize"

Now you can use all protected endpoints!

## Quick Reference

- **Email:** `admin@test.com`
- **Password:** `admin123`
- **File with SQL:** `Backend/create_admin_final.sql`
