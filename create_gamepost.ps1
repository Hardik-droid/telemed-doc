# PowerShell script to login and create a gamepost automatically
# Usage: .\create_gamepost.ps1

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Login and Create GamePost" -ForegroundColor Yellow
Write-Host "========================================`n" -ForegroundColor Cyan

# Step 1: Login
Write-Host "Step 1: Logging in..." -ForegroundColor Green
$loginBody = @{
    email = "admin@test.com"
    password = "admin123"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "http://localhost:8000/api/v1/auth/login" `
        -Method POST `
        -ContentType "application/json" `
        -Body $loginBody
    
    $token = $loginResponse.access_token
    Write-Host "✅ Login successful!" -ForegroundColor Green
    Write-Host "Token: $($token.Substring(0, 50))..." -ForegroundColor Gray
} catch {
    Write-Host "❌ Login failed: $_" -ForegroundColor Red
    exit 1
}

# Step 2: Create GamePost
Write-Host "`nStep 2: Creating gamepost..." -ForegroundColor Green

$gamepostBody = @{
    title = "My Awesome Game"
    slug = "my-awesome-game"
    excerpt = "This is a great game"
    content = "Full game description here..."
    cover_image_url = "https://example.com/image.jpg"
    tags = @("action", "adventure")
    status = "draft"
    publish_at = $null
} | ConvertTo-Json -Depth 10

$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

try {
    $response = Invoke-RestMethod -Uri "http://localhost:8000/api/v1/gameposts" `
        -Method POST `
        -Headers $headers `
        -Body $gamepostBody
    
    Write-Host "`n✅ GamePost created successfully!" -ForegroundColor Green
    Write-Host "`nResponse:" -ForegroundColor Cyan
    $response | ConvertTo-Json -Depth 10 | Write-Host
} catch {
    Write-Host "`n❌ Failed to create gamepost: $_" -ForegroundColor Red
    if ($_.ErrorDetails.Message) {
        Write-Host "Error details: $($_.ErrorDetails.Message)" -ForegroundColor Yellow
    }
}

Write-Host "`nDone!`n" -ForegroundColor Cyan
