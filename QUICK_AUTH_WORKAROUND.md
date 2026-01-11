# Quick Auth Workaround - Add Header Manually

Since the Authorize button might not appear, here's how to add the token manually:

## Method 1: Use Swagger UI's "Try it out" with Manual Header

1. **Login first:**
   - Go to `POST /api/v1/auth/login`
   - Click "Try it out"
   - Enter: `{"email": "admin@test.com", "password": "admin123"}`
   - Click "Execute"
   - Copy the `access_token` (starts with `eyJ...`)

2. **For protected endpoints:**
   - Some Swagger UI versions have a "Parameters" section
   - Or look for a way to add custom headers
   - If not available, use Method 2 below

## Method 2: Use Browser Developer Tools (Easiest!)

1. **Open Browser Developer Tools:**
   - Press `F12` or `Right-click → Inspect`
   - Go to "Network" tab

2. **Make a request in Swagger UI:**
   - Fill in your JSON in the endpoint
   - Click "Execute"

3. **Edit the request before sending:**
   - In Network tab, find the request
   - Right-click → "Edit and Resend" (in Chrome/Edge)
   - Add header: `Authorization: Bearer YOUR_TOKEN`
   - Send it

## Method 3: Use curl (Copy-Paste Ready)

```bash
# 1. Login and save token
TOKEN=$(curl -s -X POST "http://localhost:8000/api/v1/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@test.com","password":"admin123"}' | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

# 2. Create gamepost (replace $TOKEN with actual token if above didn't work)
curl -X POST "http://localhost:8000/api/v1/gameposts" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "My Game",
    "slug": "my-game",
    "status": "draft"
  }'
```

## Method 4: PowerShell Script

```powershell
# Login and get token
$response = Invoke-RestMethod -Uri "http://localhost:8000/api/v1/auth/login" `
  -Method POST `
  -ContentType "application/json" `
  -Body '{"email":"admin@test.com","password":"admin123"}'

$token = $response.access_token

# Create gamepost
Invoke-RestMethod -Uri "http://localhost:8000/api/v1/gameposts" `
  -Method POST `
  -Headers @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
  } `
  -Body '{
    "title": "My Game",
    "slug": "my-game",
    "status": "draft"
  }'
```

## Simplest: Use Postman or Insomnia

Download Postman (free) or Insomnia:
- Create new request
- Method: POST
- URL: http://localhost:8000/api/v1/gameposts
- Headers tab: Add `Authorization: Bearer YOUR_TOKEN`
- Body tab: Paste your JSON
- Click Send
