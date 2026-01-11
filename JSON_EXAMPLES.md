# JSON Request Examples

## Creating a GamePost

**Endpoint:** `POST /api/v1/gameposts`

**Valid JSON Example:**
```json
{
  "title": "My Awesome Game",
  "slug": "my-awesome-game",
  "excerpt": "This is a great game",
  "content": "Full game description here...",
  "cover_image_url": "https://example.com/image.jpg",
  "tags": ["action", "adventure"],
  "status": "draft",
  "publish_at": null
}
```

**Minimal Required Fields:**
```json
{
  "title": "Game Title",
  "slug": "game-title",
  "status": "draft"
}
```

## Common JSON Errors:

❌ **Missing comma:**
```json
{
  "title": "Game"
  "slug": "game"  // Missing comma after "Game"
}
```

✅ **Correct:**
```json
{
  "title": "Game",
  "slug": "game"
}
```

❌ **Trailing comma:**
```json
{
  "title": "Game",
  "slug": "game",  // Trailing comma (OK in modern JSON but can cause issues)
}
```

❌ **Unquoted keys:**
```json
{
  title: "Game",  // Keys must be in quotes
  slug: "game"
}
```

✅ **Correct:**
```json
{
  "title": "Game",
  "slug": "game"
}
```

❌ **Single quotes (use double quotes):**
```json
{
  'title': 'Game',  // Use double quotes, not single
  'slug': 'game'
}
```

✅ **Correct:**
```json
{
  "title": "Game",
  "slug": "game"
}
```

## Creating a Link

**Endpoint:** `POST /api/v1/gameposts/{content_id}/links`

**Valid JSON Example:**
```json
{
  "label": "Steam",
  "icon_url": "https://example.com/steam.png",
  "target_url": "https://store.steampowered.com/app/123456",
  "type": "platform"
}
```

## Tips:

1. **Use Swagger UI** - It validates JSON automatically
2. **Copy the example** from Swagger UI and modify it
3. **Check for:**
   - All keys in double quotes
   - Commas between properties
   - No trailing commas
   - Proper array/object syntax
   - Valid URLs if using HttpUrl type
