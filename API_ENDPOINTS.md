# MiBook API Endpoints Documentation

This document provides a complete specification for all API endpoints needed to replace the local JSON storage with a real database backend.

## Base Configuration

```
Base URL: https://api.mibook.com/v1
Content-Type: application/json
```

---

## Authentication Endpoints

### 1. Sign Up (Register)

**Endpoint:** `POST /auth/signup`

**Headers:**
```json
{
  "Content-Type": "application/json"
}
```

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123",
  "displayName": "John Doe"
}
```

**Response (201 Created):**
```json
{
  "id": "user123",
  "email": "user@example.com",
  "displayName": "John Doe",
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresIn": 3600
}
```

**Error Response (400 Bad Request):**
```json
{
  "error": "EMAIL_ALREADY_EXISTS",
  "message": "An account with this email already exists"
}
```

---

### 2. Sign In (Login)

**Endpoint:** `POST /auth/signin`

**Headers:**
```json
{
  "Content-Type": "application/json"
}
```

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response (200 OK):**
```json
{
  "id": "user123",
  "email": "user@example.com",
  "displayName": "John Doe",
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresIn": 3600
}
```

**Error Response (401 Unauthorized):**
```json
{
  "error": "INVALID_CREDENTIALS",
  "message": "Email or password is incorrect"
}
```

---

### 3. Sign Out (Logout)

**Endpoint:** `POST /auth/signout`

**Headers:**
```json
{
  "Content-Type": "application/json",
  "Authorization": "Bearer {accessToken}"
}
```

**Request Body:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response (200 OK):**
```json
{
  "message": "Successfully signed out"
}
```

---

### 4. Refresh Token

**Endpoint:** `POST /auth/refresh`

**Headers:**
```json
{
  "Content-Type": "application/json"
}
```

**Request Body:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response (200 OK):**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresIn": 3600
}
```

---

## Reading List Endpoints

### 5. Start Reading (Add to Reading List)

**Endpoint:** `POST /readings`

**HTTP Method:** POST

**Headers:**
```json
{
  "Content-Type": "application/json",
  "Authorization": "Bearer {accessToken}"
}
```

**Request Body:**
```json
{
  "bookId": "book_id_123",
  "bookName": "Harry Potter and the Sorcerer's Stone",
  "bookThumb": "https://example.com/images/harry-potter.jpg",
  "progress": 0.0
}
```

**Response (201 Created):**
```json
{
  "id": "reading_123",
  "bookId": "book_id_123",
  "bookName": "Harry Potter and the Sorcerer's Stone",
  "bookThumb": "https://example.com/images/harry-potter.jpg",
  "progress": 0.0,
  "createdAt": "2026-02-04T10:30:00Z",
  "updatedAt": "2026-02-04T10:30:00Z"
}
```

**Error Response (409 Conflict - Book already in reading list):**
```json
{
  "error": "DUPLICATED_READING",
  "message": "This book is already in your reading list"
}
```

---

### 6. Get Reading List

**Endpoint:** `GET /readings`

**HTTP Method:** GET

**Headers:**
```json
{
  "Authorization": "Bearer {accessToken}"
}
```

**Query Parameters:**
- `skip` (optional): Number of records to skip (default: 0)
- `limit` (optional): Number of records to return (default: 20)

**Response (200 OK):**
```json
{
  "items": [
    {
      "id": "reading_123",
      "bookId": "book_id_123",
      "bookName": "Harry Potter and the Sorcerer's Stone",
      "bookThumb": "https://example.com/images/harry-potter.jpg",
      "progress": 0.25,
      "createdAt": "2026-02-04T10:30:00Z",
      "updatedAt": "2026-02-05T15:45:00Z"
    },
    {
      "id": "reading_124",
      "bookId": "book_id_456",
      "bookName": "Deltora Quest",
      "bookThumb": "https://example.com/images/deltora.jpg",
      "progress": 0.5,
      "createdAt": "2026-02-03T08:20:00Z",
      "updatedAt": "2026-02-05T15:45:00Z"
    }
  ],
  "total": 2,
  "skip": 0,
  "limit": 20
}
```

---

### 7. Update Reading Progress

**Endpoint:** `PATCH /readings/{readingId}`

**HTTP Method:** PATCH

**Headers:**
```json
{
  "Content-Type": "application/json",
  "Authorization": "Bearer {accessToken}"
}
```

**Request Body:**
```json
{
  "progress": 0.35
}
```

**Response (200 OK):**
```json
{
  "id": "reading_123",
  "bookId": "book_id_123",
  "bookName": "Harry Potter and the Sorcerer's Stone",
  "bookThumb": "https://example.com/images/harry-potter.jpg",
  "progress": 0.35,
  "createdAt": "2026-02-04T10:30:00Z",
  "updatedAt": "2026-02-05T16:00:00Z"
}
```

---

### 8. Remove from Reading List

**Endpoint:** `DELETE /readings/{readingId}`

**HTTP Method:** DELETE

**Headers:**
```json
{
  "Authorization": "Bearer {accessToken}"
}
```

**Response (204 No Content)**

---

## Favorites Endpoints

### 9. Set Favorite Status

**Endpoint:** `POST /favorites`

**HTTP Method:** POST

**Headers:**
```json
{
  "Content-Type": "application/json",
  "Authorization": "Bearer {accessToken}"
}
```

**Request Body:**
```json
{
  "bookId": "book_id_123",
  "isFavorite": true,
  "bookData": {
    "kind": "books#volume",
    "id": "book_id_123",
    "etag": "abcdef123456",
    "selfLink": "https://www.googleapis.com/books/v1/volumes/book_id_123",
    "volumeInfo": {
      "title": "Harry Potter and the Sorcerer's Stone",
      "authors": ["J.K. Rowling"],
      "description": "A young wizard's first year at a magical school",
      "imageLinks": {
        "thumbnail": "https://example.com/images/harry-potter.jpg"
      },
      "pageCount": 309
    }
  }
}
```

**Response (201 Created / 200 OK):**
```json
{
  "id": "favorite_123",
  "bookId": "book_id_123",
  "isFavorite": true,
  "createdAt": "2026-02-04T10:30:00Z",
  "updatedAt": "2026-02-04T10:30:00Z"
}
```

---

### 10. Get Favorite Status

**Endpoint:** `GET /favorites/{bookId}`

**HTTP Method:** GET

**Headers:**
```json
{
  "Authorization": "Bearer {accessToken}"
}
```

**Response (200 OK):**
```json
{
  "bookId": "book_id_123",
  "isFavorite": true
}
```

**Response (404 Not Found):**
```json
{
  "bookId": "book_id_123",
  "isFavorite": false
}
```

---

### 11. Get All Favorite Books

**Endpoint:** `GET /favorites`

**HTTP Method:** GET

**Headers:**
```json
{
  "Authorization": "Bearer {accessToken}"
}
```

**Query Parameters:**
- `skip` (optional): Number of records to skip (default: 0)
- `limit` (optional): Number of records to return (default: 20)

**Response (200 OK):**
```json
{
  "items": [
    {
      "id": "favorite_123",
      "kind": "books#volume",
      "bookId": "book_id_123",
      "etag": "abcdef123456",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/book_id_123",
      "volumeInfo": {
        "title": "Harry Potter and the Sorcerer's Stone",
        "authors": ["J.K. Rowling"],
        "description": "A young wizard's first year at a magical school",
        "imageLinks": {
          "thumbnail": "https://example.com/images/harry-potter.jpg"
        },
        "pageCount": 309
      },
      "createdAt": "2026-02-04T10:30:00Z"
    }
  ],
  "total": 1,
  "skip": 0,
  "limit": 20
}
```

---

### 12. Delete Favorite

**Endpoint:** `DELETE /favorites/{bookId}`

**HTTP Method:** DELETE

**Headers:**
```json
{
  "Authorization": "Bearer {accessToken}"
}
```

**Response (204 No Content)**

---

## Search/Browse Books Endpoints

### 13. Search Books by Title (With Caching)

**Endpoint:** `GET /books/search`

**HTTP Method:** GET

**Headers:**
```json
{
  "Content-Type": "application/json"
}
```

**Query Parameters:**
- `q` (required): Search query (e.g., "intitle:Harry Potter")
- `startIndex` (required): Starting position of results
- `maxResults` (optional): Maximum results to return (default: 40)

**Description:**
This endpoint searches for books using Google Books API with smart caching. The backend:
1. Checks if cached results exist for the query
2. If cache is fresh (updated within 24 hours), returns cached data
3. If cache is stale or missing, attempts to fetch from Google Books API
4. If Google Books returns 429 (rate limit), serves from cache regardless of age
5. If no cache exists and Google Books fails, returns 503 with error message

**Response (200 OK - Fresh Cache or Live Data):**
```json
{
  "kind": "books#volumes",
  "totalItems": 1500,
  "items": [
    {
      "kind": "books#volume",
      "id": "book_id_123",
      "etag": "abcdef123456",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/book_id_123",
      "volumeInfo": {
        "title": "Harry Potter and the Sorcerer's Stone",
        "authors": ["J.K. Rowling"],
        "description": "A young wizard's first year at a magical school",
        "imageLinks": {
          "thumbnail": "https://example.com/images/harry-potter.jpg"
        },
        "pageCount": 309
      }
    }
  ],
  "fromCache": false,
  "cacheExpiresAt": "2026-02-05T10:30:00Z",
  "lastUpdated": "2026-02-04T10:30:00Z"
}
```

**Response (200 OK - Fallback to Stale Cache):**
```json
{
  "kind": "books#volumes",
  "totalItems": 1500,
  "items": [
    {
      "kind": "books#volume",
      "id": "book_id_123",
      "etag": "abcdef123456",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/book_id_123",
      "volumeInfo": {
        "title": "Harry Potter and the Sorcerer's Stone",
        "authors": ["J.K. Rowling"],
        "description": "A young wizard's first year at a magical school",
        "imageLinks": {
          "thumbnail": "https://example.com/images/harry-potter.jpg"
        },
        "pageCount": 309
      }
    }
  ],
  "fromCache": true,
  "warning": "Google Books API rate limit reached. Serving cached data.",
  "cacheExpiresAt": "2026-02-05T10:30:00Z",
  "lastUpdated": "2026-02-01T10:30:00Z"
}
```

**Error Response (503 Service Unavailable - No Cache Available):**
```json
{
  "error": "GOOGLE_BOOKS_UNAVAILABLE",
  "message": "Google Books API is temporarily unavailable and no cached data is available",
  "timestamp": "2026-02-04T10:30:00Z"
}
```

---

### 14. Get Book Details by ID (With Caching)

**Endpoint:** `GET /books/{bookId}`

**HTTP Method:** GET

**Headers:**
```json
{
  "Content-Type": "application/json"
}
```

**Description:**
This endpoint retrieves detailed information about a specific book using Google Books API with smart caching. The backend:
1. Checks if cached book details exist
2. If cache is fresh (updated within 24 hours), returns cached data
3. If cache is stale or missing, attempts to fetch from Google Books API
4. If Google Books returns 429 (rate limit), serves from cache regardless of age
5. If no cache exists and Google Books fails, returns 503 with error message

**Response (200 OK - Fresh Cache or Live Data):**
```json
{
  "kind": "books#volume",
  "id": "book_id_123",
  "etag": "abcdef123456",
  "selfLink": "https://www.googleapis.com/books/v1/volumes/book_id_123",
  "volumeInfo": {
    "title": "Harry Potter and the Sorcerer's Stone",
    "authors": ["J.K. Rowling"],
    "description": "A young wizard's first year at a magical school",
    "publishedDate": "1997-06-26",
    "pageCount": 309,
    "imageLinks": {
      "smallThumbnail": "https://example.com/small.jpg",
      "thumbnail": "https://example.com/images/harry-potter.jpg"
    },
    "language": "en",
    "previewLink": "https://books.google.com/books?id=...",
    "infoLink": "https://books.google.com/books?id=..."
  },
  "fromCache": false,
  "cacheExpiresAt": "2026-02-05T10:30:00Z",
  "lastUpdated": "2026-02-04T10:30:00Z"
}
```

**Response (200 OK - Fallback to Stale Cache):**
```json
{
  "kind": "books#volume",
  "id": "book_id_123",
  "etag": "abcdef123456",
  "selfLink": "https://www.googleapis.com/books/v1/volumes/book_id_123",
  "volumeInfo": {
    "title": "Harry Potter and the Sorcerer's Stone",
    "authors": ["J.K. Rowling"],
    "description": "A young wizard's first year at a magical school",
    "publishedDate": "1997-06-26",
    "pageCount": 309,
    "imageLinks": {
      "smallThumbnail": "https://example.com/small.jpg",
      "thumbnail": "https://example.com/images/harry-potter.jpg"
    },
    "language": "en",
    "previewLink": "https://books.google.com/books?id=...",
    "infoLink": "https://books.google.com/books?id=..."
  },
  "fromCache": true,
  "warning": "Google Books API rate limit reached. Serving cached data.",
  "cacheExpiresAt": "2026-02-05T10:30:00Z",
  "lastUpdated": "2026-02-01T10:30:00Z"
}
```

**Error Response (503 Service Unavailable - No Cache Available):**
```json
{
  "error": "GOOGLE_BOOKS_UNAVAILABLE",
  "message": "Google Books API is temporarily unavailable and no cached data is available for book ID: book_id_123",
  "timestamp": "2026-02-04T10:30:00Z"
}
```

**Error Response (404 Not Found):**
```json
{
  "error": "BOOK_NOT_FOUND",
  "message": "Book not found in cache or Google Books API",
  "timestamp": "2026-02-04T10:30:00Z"
}
```

---

## Error Handling

### Standard Error Response Format

All error responses follow this format:

```json
{
  "error": "ERROR_CODE",
  "message": "Human-readable error message",
  "timestamp": "2026-02-04T10:30:00Z"
}
```

### Common HTTP Status Codes

| Status Code | Meaning |
|-------------|---------|
| 200 | OK - Request successful |
| 201 | Created - Resource created successfully |
| 204 | No Content - Request successful, no response body |
| 400 | Bad Request - Invalid request parameters |
| 401 | Unauthorized - Missing or invalid authentication token |
| 403 | Forbidden - Insufficient permissions |
| 404 | Not Found - Resource not found |
| 409 | Conflict - Resource already exists (e.g., duplicate reading) |
| 500 | Internal Server Error - Server error |

---

## Authentication Flow

### Token Management

1. **Initial Login:** User calls Sign In endpoint, receives `accessToken` and `refreshToken`
2. **API Requests:** Include `accessToken` in Authorization header
3. **Token Expiration:** When token expires (401 response), call Refresh Token endpoint
4. **Logout:** Call Sign Out endpoint to invalidate tokens

### Authorization Header Format

```
Authorization: Bearer {accessToken}
```

---

## Implementation Notes

### For APIClient Class

Extend the `IApiClient` interface to include:
- Token management (storing and refreshing access tokens)
- Authorization header injection for all authenticated requests
- Error handling for 401 responses (auto-refresh token)
- Updated base URL to point to your backend API only
- Remove direct Google Books API calls - all book search/details go through your backend

### For StorageClient Class

Replace file-based operations with:
- HTTP requests to backend endpoints
- Stream management for real-time updates (consider WebSocket for watch operations)
- Local caching strategy for offline support
- Conflict resolution for concurrent updates

### Backend Caching Strategy

The backend implements a smart caching system for Google Books API:

**Cache Lifecycle:**
1. **Fresh Cache (< 24 hours):** Serve from cache immediately
2. **Stale Cache (> 24 hours):** Attempt live fetch
3. **Live Fetch Fails (429 Rate Limit):** Serve from cache regardless of age
4. **No Cache + Live Fetch Fails:** Return 503 Service Unavailable

**Cache Key Structure:**
- **Search queries:** `books:search:{hash(q)}:{startIndex}:{maxResults}`
- **Book details:** `books:detail:{bookId}`

**Automatic Cache Refresh:**
- Backend should implement scheduled tasks to refresh popular search queries
- Cache TTL: 24 hours (86,400 seconds)
- Store `lastUpdated` and `cacheExpiresAt` timestamps in responses

**Benefits:**
- ✅ Handles rate limiting gracefully
- ✅ Faster response times for popular queries
- ✅ Reduced API quota consumption
- ✅ Better user experience with consistent data availability
- ✅ Supports offline access patterns through your app's local storage

### Data Models to Update

Ensure the following Dart models are serializable and match backend response:
- `ReadingData` - for reading list operations
- `BookData` - for book information
- `User` - for authentication responses
- Add fields to responses: `fromCache`, `warning` (optional), `lastUpdated`, `cacheExpiresAt`

---

## Example Implementation References

### Sign In Flow
```dart
// 1. Call sign in
final response = await apiClient.post(
  endpoint: 'auth/signin',
  body: {'email': email, 'password': password},
);

// 2. Store tokens
final tokens = AuthResponse.fromJson(response);
secureStorage.saveAccessToken(tokens.accessToken);
secureStorage.saveRefreshToken(tokens.refreshToken);

// 3. Use accessToken for subsequent requests
```

### Search Books with Smart Caching
```dart
// 1. Call backend search endpoint (NOT Google Books directly)
final response = await apiClient.get(
  endpoint: 'books/search',
  queryParameters: {
    'q': 'intitle:Harry Potter',
    'startIndex': 0,
    'maxResults': 40,
  },
);

// 2. Parse response
final bookList = BookListData.fromJson(response);

// 3. Check cache status in response
if (response['fromCache'] == true) {
  print('Serving from cache (last updated: ${response['lastUpdated']})');
  if (response.containsKey('warning')) {
    print('Warning: ${response['warning']}');
  }
} else {
  print('Serving fresh data from Google Books API');
}
```

### Get Book Details with Smart Caching
```dart
// 1. Call backend details endpoint (NOT Google Books directly)
final response = await apiClient.get(
  endpoint: 'books/book_id_123',
);

// 2. Parse response
final bookData = BookData.fromJson(response);

// 3. Handle potential service unavailability
if (response.statusCode == 503) {
  print('Google Books API unavailable and no cache exists');
  showErrorToUser('Book details temporarily unavailable. Please try again later.');
}
```

### Add to Reading List
```dart
// 1. Create reading object
final reading = ReadingData(
  bookId: book.id,
  bookName: book.title,
  bookThumb: book.thumbnail,
  progress: 0.0,
);

// 2. POST to /readings
final response = await apiClient.post(
  endpoint: 'readings',
  body: reading.toJson(),
);

// 3. Notify listeners of change
_readingListController.add(await getReadingList());
```

### Watch Readings (Real-time Updates)
For the `watchReadingList()` stream, consider:
- **Option 1:** Poll the endpoint periodically (simple, less efficient)
- **Option 2:** WebSocket connection for push updates (efficient, real-time)
- **Option 3:** Local stream with background sync (offline support)
