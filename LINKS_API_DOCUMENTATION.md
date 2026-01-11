# Links API Documentation - 2-Way Database Connection

## Overview

The Links API provides a complete 2-way connection between the backend and the `links` database table. This allows you to:

1. **READ** links from the database (grouped by type: platform/game)
2. **WRITE** links to the database (create, update, delete)
3. **INTEGRATE** links with gameposts automatically

## Database Schema

The `links` table matches your SQL query structure:

```sql
CREATE TABLE links (
    id UUID PRIMARY KEY,
    content_id UUID REFERENCES gameposts(id) ON DELETE CASCADE,
    label VARCHAR(200) NOT NULL,
    icon_url VARCHAR(512),
    target_url VARCHAR(512) NOT NULL,
    type VARCHAR(20) NOT NULL,  -- 'platform' or 'game'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## API Endpoints

### 1. Get Links for a GamePost (Grouped Format)

**GET** `/api/v1/gameposts/{content_id}/links`

Returns links grouped by type, matching your SQL query format:

```json
{
  "content_id": "uuid-here",
  "platform_links": [
    {
      "label": "Steam",
      "icon_url": "https://example.com/steam.png",
      "target_url": "https://store.steampowered.com/..."
    }
  ],
  "game_links": [
    {
      "label": "Official Website",
      "icon_url": "https://example.com/icon.png",
      "target_url": "https://game-website.com"
    }
  ]
}
```

### 2. Get Links (Flat List)

**GET** `/api/v1/gameposts/{content_id}/links/flat?link_type=platform`

Optional `link_type` parameter: `platform` or `game`

Returns a flat list of all links (or filtered by type).

### 3. Create a Link

**POST** `/api/v1/gameposts/{content_id}/links` (Admin only)

Request body:
```json
{
  "label": "Steam",
  "icon_url": "https://example.com/steam.png",
  "target_url": "https://store.steampowered.com/...",
  "type": "platform"
}
```

### 4. Bulk Create Links

**POST** `/api/v1/gameposts/{content_id}/links/bulk` (Admin only)

Request body:
```json
[
  {
    "label": "Steam",
    "icon_url": "https://example.com/steam.png",
    "target_url": "https://store.steampowered.com/...",
    "type": "platform"
  },
  {
    "label": "Epic Games",
    "icon_url": "https://example.com/epic.png",
    "target_url": "https://epicgames.com/...",
    "type": "platform"
  }
]
```

### 5. Get Single Link

**GET** `/api/v1/links/{link_id}`

Returns a single link with all details including timestamps.

### 6. Update a Link

**PUT** `/api/v1/links/{link_id}` (Admin only)

Request body same as create.

### 7. Delete a Link

**DELETE** `/api/v1/links/{link_id}` (Admin only)

### 8. Delete All Links for a GamePost

**DELETE** `/api/v1/gameposts/{content_id}/links` (Admin only)

## Integration with GamePosts

### Automatic Link Inclusion

When you fetch a gamepost, links are automatically included:

**GET** `/api/v1/gameposts/public/{slug}`

Response includes:
```json
{
  "id": "uuid",
  "title": "Game Title",
  "slug": "game-slug",
  ...
  "platform_links": [...],
  "game_links": [...]
}
```

**GET** `/api/v1/gameposts` (Admin endpoint)

All gameposts in the list include their links.

## Usage Examples

### Creating Links for a GamePost

```bash
# First, create or get a gamepost to get its content_id (UUID)
# Then create links:

curl -X POST "http://localhost:8000/api/v1/gameposts/{content_id}/links" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "label": "Steam",
    "icon_url": "https://example.com/steam.png",
    "target_url": "https://store.steampowered.com/app/123456",
    "type": "platform"
  }'
```

### Reading Links (Matching Your SQL Query)

```bash
# Get links grouped by type (matches your SQL query format)
curl "http://localhost:8000/api/v1/gameposts/{content_id}/links"
```

This returns data in the exact format your SQL query produces:
- `platform_links`: Array of platform links
- `game_links`: Array of game links

### Reading GamePost with Links

```bash
# Get a gamepost with all its links automatically included
curl "http://localhost:8000/api/v1/gameposts/public/{slug}"
```

## Migration

To create the links table in your database, run:

```powershell
cd Backend
.\.venv\Scripts\Activate.ps1
cd server
python -m alembic upgrade head
```

This will create the `links` table with proper foreign key relationships.

## Notes

- Links are automatically deleted when a gamepost is deleted (CASCADE)
- `content_id` references `gameposts.id` (UUID)
- Link types must be either `"platform"` or `"game"`
- All write operations require admin authentication
- Read operations are public (for published gameposts)

## Two-Way Connection Explained

**READ Direction** (Database → API):
- Query links from database
- Group them by type (platform/game)
- Return in JSON format matching your SQL query

**WRITE Direction** (API → Database):
- Create links via POST
- Update links via PUT
- Delete links via DELETE
- All changes are immediately persisted to database

This provides a complete bidirectional data flow between your frontend and the database!
