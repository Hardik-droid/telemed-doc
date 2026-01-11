# Quick start script for Backend
Write-Host "Starting GzoneSphere Backend..." -ForegroundColor Green

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
.\.venv\Scripts\Activate.ps1

# Check if .env exists
if (-not (Test-Path ".env")) {
    Write-Host "ERROR: .env file not found in Backend directory!" -ForegroundColor Red
    Write-Host "Please create Backend/.env with your database credentials." -ForegroundColor Yellow
    exit 1
}

# Check database connection
Write-Host "Checking database connection..." -ForegroundColor Yellow
cd server
python setup_db.py

if ($LASTEXITCODE -ne 0) {
    Write-Host "`nWARNING: Database setup had issues. Please check SETUP_INSTRUCTIONS.md" -ForegroundColor Yellow
    Write-Host "You can still try to start the server, but it may fail if the database isn't accessible." -ForegroundColor Yellow
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y") {
        exit 1
    }
}

# Run migrations
Write-Host "Running database migrations..." -ForegroundColor Yellow
python -m alembic upgrade head

if ($LASTEXITCODE -ne 0) {
    Write-Host "`nERROR: Migrations failed. Please check your database configuration in .env" -ForegroundColor Red
    Write-Host "See SETUP_INSTRUCTIONS.md for help." -ForegroundColor Yellow
    exit 1
}

# Start server
Write-Host "`nStarting FastAPI server on http://localhost:8000" -ForegroundColor Green
Write-Host "API docs available at http://localhost:8000/docs" -ForegroundColor Cyan
uvicorn app.main:app --reload --port 8000
