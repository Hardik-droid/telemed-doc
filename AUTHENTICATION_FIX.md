# Fix 401 Unauthorized Error

## Problem
You're getting `401 Unauthorized` when trying to create a gamepost.

This means the authentication token is either:
1. Not provided
2. Invalid/expired
3. Not in the correct format

## Solution: Proper Authentication in Swagger UI

### Step 1: Login to Get Token

1. Go to **POST /api/v1/auth/login**
2. Click "Try it out"
3. Enter:
   ```json
   {
     "email": "admin@test.com",
     "password": "admin123"
   }
   ```
4. Click "Execute"
5. **Copy the `access_token`** from the response

### Step 2: Authorize in Swagger UI

1. Click the **🔒 Authorize** button at the **TOP RIGHT** of Swagger UI
2. In the **"Value"** field, enter:
   ```
   Bearer YOUR_ACCESS_TOKEN_HERE
   ```
   Replace `YOUR_ACCESS_TOKEN_HERE` with the token from Step 1
   
   Example:
   ```
   Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzNzg2MzAyZC03Nzc1LTQyMmItYmQ5Mi04NDgzNWM3ZjBlMTkiLCJyb2xlIjoiYWRtaW4iLCJleHAiOjE3NjgwMjk2OTZ9.meFXfdlzhFNfJmGJWu9Wu34CCSLMaMT0sHdA8jazSy0
   ```
3. Click **"Authorize"**
4. Click **"Close"**

### Step 3: Verify Authorization

After authorizing, you should see a **🔓** (unlocked) icon in the top right, or the lock should show as "Authorized".

### Step 4: Try Creating GamePost Again

1. Go to **POST /api/v1/gameposts**
2. Click "Try it out"
3. Enter the JSON body (without `id` field):
   ```json
   {
     "title": "My Game",
     "slug": "my-game",
     "excerpt": "Game description",
     "status": "draft",
     "publish_at": null
   }
   ```
4. Click "Execute"

It should work now!

## Troubleshooting

**Still getting 401?**
- Make sure you clicked "Authorize" and it shows as authorized
- Check the token hasn't expired (default is 30 minutes)
- Try logging in again to get a fresh token
- Make sure the token starts with "Bearer " (with a space after Bearer)

**Token expired?**
- Just login again to get a new token
- Update the authorization with the new token

## Quick Check: Is User Created?

If login fails, make sure the admin user exists:
```powershell
cd Backend/server
python fix_admin_user.py
```
