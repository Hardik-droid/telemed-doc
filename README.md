# GzoneSphere Backend (FastAPI + SQLAlchemy + Alembic)

## Quickstart (Windows PowerShell)

1. **Install Python 3.11+** and **PostgreSQL 14+** (or use Docker).
2. Open PowerShell in the `Backend/` folder and run:

```ps1
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install --upgrade pip
pip install -r requirements.txt
```

3. **Create database** `gzonesphere` in Postgres and set `DATABASE_URL` in `.env`.  
   Example:
   ```
   DATABASE_URL=postgresql+psycopg://postgres:postgres@localhost:5432/gzonesphere
   ```

4. **Run migrations** (from `Backend/server/`):
```ps1
cd server
alembic upgrade head
```
> If `alembic` is not recognized, use: `python -m alembic upgrade head`

5. **Start the API** (from `Backend/server/`):
```ps1
uvicorn app.main:app --reload --port 8000
```

Visit: `http://127.0.0.1:8000/docs`

## Common Issues
- **`alembic : The term 'alembic' is not recognized`**  
  Activate your virtual environment or run with `python -m alembic ...`.

- **`pydantic_settings.SettingsError: DATABASE_URL`**  
  Ensure `.env` exists at `Backend/.env` with `DATABASE_URL=...`.

- **`psycopg` errors**  
  Install Postgres client tools and ensure the DB is reachable.

## Project Layout
```
Backend/
  .env                 # your local settings (DO NOT COMMIT)
  .env.example         # template
  requirements.txt
  server/
    alembic.ini
    alembic/
      env.py
      versions/
        <revision>.py
    app/
      main.py
      api/
        v1/
          routes/
            health.py
      core/
        config.py
        middleware.py
      db/
        base.py
        session.py
      modules/
        gameposts/
          models.py
```
