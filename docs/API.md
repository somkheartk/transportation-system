# API Documentation

## Base URL
```
http://localhost:3000
```

## Swagger Documentation
Interactive API documentation available at: `http://localhost:3000/api`

## Authentication
Currently, the API is open. JWT authentication can be implemented using the auth module.

## Endpoints

### Shipments

#### Get All Shipments
```http
GET /shipments
```

**Response:**
```json
[
  {
    "_id": "507f1f77bcf86cd799439011",
    "trackingNumber": "TRK123456",
    "senderName": "John Doe",
    "senderAddress": "123 Main St",
    "senderPhone": "+1234567890",
    "receiverName": "Jane Smith",
    "receiverAddress": "456 Oak Ave",
    "receiverPhone": "+0987654321",
    "itemDescription": "Electronics",
    "weight": 5.5,
    "quantity": 2,
    "status": "in_transit",
    "estimatedDeliveryDate": "2025-10-25T00:00:00.000Z",
    "trackingHistory": [],
    "createdAt": "2025-10-19T10:00:00.000Z",
    "updatedAt": "2025-10-19T10:00:00.000Z"
  }
]
```

#### Get Shipment by ID
```http
GET /shipments/:id
```

#### Track Shipment by Tracking Number
```http
GET /shipments/tracking/:trackingNumber
```

**Example:**
```http
GET /shipments/tracking/TRK123456
```

#### Create Shipment
```http
POST /shipments
Content-Type: application/json
```

**Request Body:**
```json
{
  "trackingNumber": "TRK123456",
  "senderName": "John Doe",
  "senderAddress": "123 Main St, Bangkok",
  "senderPhone": "0812345678",
  "receiverName": "Jane Smith",
  "receiverAddress": "456 Oak Ave, Chiang Mai",
  "receiverPhone": "0887654321",
  "itemDescription": "Electronics",
  "weight": 5.5,
  "quantity": 2,
  "status": "pending",
  "estimatedDeliveryDate": "2025-10-25",
  "notes": "Handle with care"
}
```

**Response:**
```json
{
  "_id": "507f1f77bcf86cd799439011",
  "trackingNumber": "TRK123456",
  ...
}
```

#### Update Shipment
```http
PATCH /shipments/:id
Content-Type: application/json
```

**Request Body:**
```json
{
  "status": "in_transit",
  "notes": "Package picked up"
}
```

#### Add Tracking Update
```http
PATCH /shipments/:id/tracking
Content-Type: application/json
```

**Request Body:**
```json
{
  "location": "Bangkok Distribution Center",
  "timestamp": "2025-10-19T14:30:00.000Z",
  "notes": "Package arrived at distribution center"
}
```

#### Delete Shipment
```http
DELETE /shipments/:id
```

**Response:** `204 No Content`

---

### Warehouses

#### Get All Warehouses
```http
GET /warehouses
```

**Response:**
```json
[
  {
    "_id": "507f1f77bcf86cd799439012",
    "name": "Bangkok Central Warehouse",
    "address": "789 Industrial Rd",
    "city": "Bangkok",
    "province": "Bangkok",
    "postalCode": "10100",
    "phone": "021234567",
    "email": "bangkok@warehouse.com",
    "type": "warehouse",
    "coordinates": {
      "lat": 13.7563,
      "lng": 100.5018
    },
    "isActive": true,
    "capacity": 10000,
    "manager": "Somchai Prasert",
    "createdAt": "2025-10-19T10:00:00.000Z",
    "updatedAt": "2025-10-19T10:00:00.000Z"
  }
]
```

#### Get Active Warehouses
```http
GET /warehouses/active
```

Returns only warehouses with `isActive: true`

#### Get Warehouse by ID
```http
GET /warehouses/:id
```

#### Create Warehouse
```http
POST /warehouses
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "Bangkok Central Warehouse",
  "address": "789 Industrial Rd",
  "city": "Bangkok",
  "province": "Bangkok",
  "postalCode": "10100",
  "phone": "021234567",
  "email": "bangkok@warehouse.com",
  "type": "warehouse",
  "coordinates": {
    "lat": 13.7563,
    "lng": 100.5018
  },
  "isActive": true,
  "capacity": 10000,
  "manager": "Somchai Prasert",
  "notes": "Main distribution center"
}
```

#### Update Warehouse
```http
PATCH /warehouses/:id
Content-Type: application/json
```

**Request Body:**
```json
{
  "isActive": false,
  "notes": "Temporarily closed for maintenance"
}
```

#### Delete Warehouse
```http
DELETE /warehouses/:id
```

**Response:** `204 No Content`

---

## Status Codes

- `200 OK` - Successful GET, PATCH requests
- `201 Created` - Successful POST requests
- `204 No Content` - Successful DELETE requests
- `400 Bad Request` - Invalid request data
- `404 Not Found` - Resource not found
- `500 Internal Server Error` - Server error

## Error Response Format

```json
{
  "statusCode": 404,
  "message": "Shipment with ID 507f1f77bcf86cd799439011 not found",
  "error": "Not Found"
}
```

## Shipment Status Values

- `pending` - Shipment created but not yet picked up
- `in_transit` - Shipment is on the way
- `delivered` - Shipment has been delivered
- `cancelled` - Shipment was cancelled

## Warehouse Types

- `warehouse` - Large storage facility
- `store` - Retail store
- `distribution_center` - Distribution hub
