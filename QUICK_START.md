# Quick Start Guide

## Database Setup Required

The application needs PostgreSQL to run. You need to:

1. **Create a database** named `GamePost` (or update .env to use a different name)

2. **Update the .env file** in `Backend/.env` with your PostgreSQL credentials:
   ```
   DATABASE_URL=postgresql+psycopg://USERNAME:PASSWORD@localhost:5432/GamePost
   ```

3. **Common PostgreSQL setups:**
   - If you installed PostgreSQL with default settings, try:
     - Username: `postgres`
     - Password: (the password you set during installation)
     - Database: `GamePost` (create it first)
   
   - To create the database, connect to PostgreSQL and run:
     ```sql
     CREATE DATABASE "GamePost";
     ```

4. **After updating .env, run migrations:**
   ```powershell
   cd Backend
   .\.venv\Scripts\Activate.ps1
   cd server
   python -m alembic upgrade head
   ```

## Redis Setup (Optional but Recommended)

Redis is used for rate limiting. Options:

1. **Start Docker Desktop** and run: `docker run -d --name gzs_redis -p 6379:6379 redis:7-alpine`
2. **Install Redis for Windows** from: https://github.com/microsoftarchive/redis/releases
3. **Or skip Redis** - the app may work with reduced functionality (rate limiting disabled)

## Starting the Application

### Backend:
```powershell
cd Backend
.\.venv\Scripts\Activate.ps1
cd server
uvicorn app.main:app --reload --port 8000
```

### Frontend (in a new terminal):
```powershell
cd Frontend
npm run dev
```

The frontend will run on http://localhost:5173
The backend API will run on http://localhost:8000
