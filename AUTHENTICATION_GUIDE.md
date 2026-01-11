# Authentication Guide

## Quick Setup

### 1. Create Admin User

Run this script to create a test admin user:

```powershell
cd Backend/server
python create_test_admin.py
```

**Default Credentials:**
- Email: `admin@test.com`
- Password: `admin123`

### 2. Get Authentication Token

**Using Swagger UI (Recommended):**

1. Go to http://localhost:8000/docs
2. Find the **POST /api/v1/auth/login** endpoint
3. Click "Try it out"
4. Enter credentials:
   ```json
   {
     "email": "admin@test.com",
     "password": "admin123"
   }
   ```
5. Click "Execute"
6. Copy the `access_token` from the response

**Using curl:**
```bash
curl -X POST "http://localhost:8000/api/v1/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@test.com", "password": "admin123"}'
```

### 3. Use Token in Swagger UI

1. In Swagger UI, click the **🔒 Authorize** button at the top
2. In the "Value" field, enter: `Bearer YOUR_ACCESS_TOKEN`
   - Replace `YOUR_ACCESS_TOKEN` with the token from step 2
   - Example: `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`
3. Click "Authorize"
4. Click "Close"

Now all protected endpoints will automatically include the token!

### 4. Use Token in API Calls (curl/Postman)

Add this header to your requests:
```
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Example:**
```bash
curl -X POST "http://localhost:8000/api/v1/gameposts" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Test Game",
    "slug": "test-game",
    "excerpt": "A test game",
    "status": "draft"
  }'
```

## Protected Endpoints

These endpoints require authentication:

### Admin Only (require_admin):
- `POST /api/v1/gameposts` - Create gamepost
- `GET /api/v1/gameposts` - List gameposts (admin)
- `PUT /api/v1/gameposts/{slug}` - Update gamepost
- `DELETE /api/v1/gameposts/{slug}` - Delete gamepost
- `POST /api/v1/gameposts/{slug}/publish` - Publish gamepost
- `POST /api/v1/gameposts/{content_id}/links` - Create link
- `PUT /api/v1/links/{link_id}` - Update link
- `DELETE /api/v1/links/{link_id}` - Delete link
- And more...

### Public Endpoints (no auth required):
- `GET /api/v1/gameposts/public` - Public gamepost list
- `GET /api/v1/gameposts/public/{slug}` - Public gamepost detail
- `GET /api/v1/gameposts/{content_id}/links` - Get links (public)
- `POST /api/v1/auth/login` - Login

## Troubleshooting

**Error: "Missing or invalid Authorization header"**
- Make sure you clicked "Authorize" in Swagger UI
- Check that the token starts with "Bearer " (with space)
- Verify the token hasn't expired

**Error: "Invalid or expired token"**
- Token may have expired (check JWT_ACCESS_MIN in .env)
- Login again to get a new token

**Error: "Admin required"**
- Make sure your user has role="admin" in the database
- Check that you're using the correct token

## Creating Custom Admin Users

You can modify `create_test_admin.py` to create users with different credentials:

```python
admin = User(
    email="your-email@example.com",
    password_hash=hash_password("your-password"),
    display_name="Your Name",
    role="admin"
)
```
