# Manual Authentication - No Authorize Button Needed

If the Authorize button doesn't appear in Swagger UI, you can manually add the token to each request.

## Method 1: Add Authorization Header Manually in Swagger UI

1. **Login first:**
   - Go to `POST /api/v1/auth/login`
   - Click "Try it out"
   - Enter:
     ```json
     {
       "email": "admin@test.com",
       "password": "admin123"
     }
     ```
   - Click "Execute"
   - Copy the `access_token` (long string starting with `eyJ...`)

2. **For each protected endpoint:**
   - Expand the endpoint (e.g., `POST /api/v1/gameposts`)
   - Click "Try it out"
   - Scroll down to see the request
   - Look for a section that says "Authorization" or "Headers"
   - If there's an "Authorization" field, enter:
     ```
     Bearer YOUR_TOKEN_HERE
     ```
   - OR manually add it in "Headers" section if available

3. **Add the header manually:**
   - Some Swagger UI versions let you add custom headers
   - Look for "Add header" or similar option
   - Key: `Authorization`
   - Value: `Bearer YOUR_TOKEN_HERE`

## Method 2: Use curl (Command Line)

```bash
# First, login to get token
curl -X POST "http://localhost:8000/api/v1/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@test.com", "password": "admin123"}'

# Copy the access_token from the response, then:
curl -X POST "http://localhost:8000/api/v1/gameposts" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "My Game",
    "slug": "my-game",
    "status": "draft"
  }'
```

## Method 3: Use Postman or Insomnia

1. Create a new request
2. Set method to POST
3. URL: `http://localhost:8000/api/v1/gameposts`
4. Go to "Headers" tab
5. Add header:
   - Key: `Authorization`
   - Value: `Bearer YOUR_TOKEN_HERE`
6. Go to "Body" tab (JSON)
7. Enter your JSON payload

## Method 4: Fix Swagger UI (After Server Restart)

I've added the security scheme configuration. **Restart your server** and the Authorize button should appear:

1. Stop the server (Ctrl+C)
2. Restart:
   ```powershell
   cd Backend
   .\.venv\Scripts\Activate.ps1
   cd server
   uvicorn app.main:app --reload --port 8000
   ```
3. Refresh http://localhost:8000/docs
4. Look for the 🔒 **Authorize** button at the top right

## Quick Test

After restarting, you should see:
- A lock icon/button at the top right of Swagger UI
- Security schemes listed in the OpenAPI spec
- Each protected endpoint showing a lock icon
