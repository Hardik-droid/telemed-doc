# Quick Authentication Fix

## Problem
You're getting: `{"detail": "Missing or invalid Authorization header"}`

This means you need to authenticate first!

## Solution - Use Swagger UI's Authorize Button

### Step 1: Login to Get Token

1. In Swagger UI (http://localhost:8000/docs), find **POST /api/v1/auth/login**
2. Click "Try it out"
3. Enter this in the Request body:
   ```json
   {
     "email": "admin@test.com",
     "password": "admin123"
   }
   ```
4. Click "Execute"
5. Copy the `access_token` from the response (it will look like: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`)

### Step 2: Authorize in Swagger UI

1. Click the **🔒 Authorize** button at the top right of Swagger UI
2. In the "Value" field, paste your token with `Bearer ` prefix:
   ```
   Bearer YOUR_TOKEN_HERE
   ```
   Example: `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`
3. Click "Authorize"
4. Click "Close"

### Step 3: Test Protected Endpoints

Now try creating a gamepost again - it should work!

## If Login Fails (User Doesn't Exist)

If you get "Invalid credentials", you need to create an admin user first.

**Option 1: Use the API directly (if you have another way to create users)**

**Option 2: Use SQL to create user:**

Connect to your PostgreSQL database and run:
```sql
INSERT INTO users (id, email, password_hash, display_name, role, created_at)
VALUES (
    gen_random_uuid(),
    'admin@test.com',
    '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYq5ZqJq5Sq',  -- hash of 'admin123'
    'Admin User',
    'admin',
    NOW()
);
```

**Option 3: Use the create script** (if it works on your system)

## Test Credentials

After creating the user:
- **Email:** `admin@test.com`
- **Password:** `admin123`

Then follow Step 1 above to login and get your token!
