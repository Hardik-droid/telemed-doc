"""Check users table structure"""
from sqlalchemy import create_engine, inspect, text
import os
from pathlib import Path
from dotenv import load_dotenv

load_dotenv(Path(__file__).resolve().parent / '.env')
engine = create_engine(os.getenv('DATABASE_URL'))

with engine.connect() as conn:
    # Check if table exists
    result = conn.execute(text("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' AND table_name = 'users'
    """))
    if result.fetchone():
        print("Users table exists")
        
        # Get column names
        result = conn.execute(text("""
            SELECT column_name, data_type 
            FROM information_schema.columns 
            WHERE table_name = 'users'
            ORDER BY ordinal_position
        """))
        
        print("\nTable columns:")
        for row in result:
            print(f"  - {row[0]} ({row[1]})")
    else:
        print("Users table does not exist")
