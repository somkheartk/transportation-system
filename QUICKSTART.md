# Quick Start Guide / คู่มือเริ่มต้นใช้งานอย่างรวดเร็ว

Get up and running with the Transportation System in 5 minutes!

## Prerequisites / สิ่งที่ต้องมี

- Docker and Docker Compose installed
- OR Node.js v20+ and MongoDB v7+

## Option 1: Docker (Easiest) / วิธีที่ 1: Docker (ง่ายที่สุด)

### Step 1: Clone and Start

```bash
# Clone the repository
git clone https://github.com/somkheartk/transportation-system.git
cd transportation-system

# Start all services
docker-compose up -d

# Check if services are running
docker-compose ps
```

### Step 2: Access the API

Open your browser and visit:
- API: http://localhost:3000
- Swagger Docs: http://localhost:3000/api

### Step 3: Test the API

```bash
# Create a warehouse
curl -X POST http://localhost:3000/warehouses \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Bangkok Central Warehouse",
    "address": "789 Industrial Rd",
    "city": "Bangkok",
    "province": "Bangkok",
    "postalCode": "10100",
    "phone": "021234567",
    "type": "warehouse",
    "isActive": true
  }'

# Create a shipment
curl -X POST http://localhost:3000/shipments \
  -H "Content-Type: application/json" \
  -d '{
    "trackingNumber": "TRK001",
    "senderName": "John Doe",
    "senderAddress": "123 Main St, Bangkok",
    "senderPhone": "0812345678",
    "receiverName": "Jane Smith",
    "receiverAddress": "456 Oak Ave, Chiang Mai",
    "receiverPhone": "0887654321",
    "itemDescription": "Electronics",
    "weight": 5.5,
    "quantity": 2,
    "status": "pending"
  }'

# Track the shipment
curl http://localhost:3000/shipments/tracking/TRK001

# Get all shipments
curl http://localhost:3000/shipments

# Get all warehouses
curl http://localhost:3000/warehouses
```

That's it! Your backend is running. 🎉

---

## Option 2: Manual Setup / วิธีที่ 2: ติดตั้งแบบ Manual

### Step 1: Start MongoDB

```bash
# Using Docker
docker run -d -p 27017:27017 --name mongodb mongo:7.0

# OR install MongoDB locally and start it
```

### Step 2: Setup Backend

```bash
# Navigate to backend
cd backend

# Install dependencies
npm install

# Start the backend
npm run start:dev
```

Backend will be available at http://localhost:3000

### Step 3: Setup Flutter App (Optional)

```bash
# Navigate to frontend
cd ../frontend

# Get dependencies
flutter pub get

# Configure API endpoint
# Edit lib/config/api_config.dart and update baseUrl

# Run the app
flutter run
```

---

## Testing with Sample Data / ทดสอบด้วยข้อมูลตัวอย่าง

Use the Swagger UI at http://localhost:3000/api to:

1. Create warehouses using the `/warehouses` POST endpoint
2. Create shipments using the `/shipments` POST endpoint
3. Add tracking updates using the `/shipments/{id}/tracking` PATCH endpoint
4. Track shipments using the `/shipments/tracking/{trackingNumber}` GET endpoint

Or use the provided sample data script (coming soon).

---

## Next Steps / ขั้นตอนต่อไป

1. ✅ Read the [Full Documentation](README.md)
2. ✅ Explore the [API Documentation](docs/API.md)
3. ✅ Check the [Architecture Guide](docs/ARCHITECTURE.md)
4. ✅ Review the [User Guide](docs/USER_GUIDE.md)
5. ✅ Set up the Flutter mobile app
6. ✅ Configure for production deployment

---

## Troubleshooting / แก้ไขปัญหา

### Port 3000 already in use

```bash
# Find and kill the process
lsof -i :3000
kill -9 <PID>

# Or change the port in .env
PORT=3001
```

### MongoDB connection error

```bash
# Check if MongoDB is running
docker ps | grep mongo

# Check MongoDB logs
docker logs mongodb
```

### Docker Compose issues

```bash
# Stop all services
docker-compose down

# Remove volumes and restart
docker-compose down -v
docker-compose up -d
```

---

## Stop Services / หยุดบริการ

```bash
# Using Docker Compose
docker-compose down

# Remove volumes (data will be lost)
docker-compose down -v

# Using manual setup
# Stop the backend with Ctrl+C
# Stop MongoDB:
docker stop mongodb
```

---

## Quick Commands Reference / คำสั่งอ้างอิงอย่างรวดเร็ว

```bash
# Docker Compose
docker-compose up -d          # Start services
docker-compose down           # Stop services
docker-compose ps             # Check status
docker-compose logs -f        # View logs

# Backend
npm run start:dev             # Development mode
npm run start:prod            # Production mode
npm run build                 # Build
npm run test                  # Run tests
npm run lint                  # Lint code

# Flutter
flutter pub get               # Install dependencies
flutter run                   # Run app
flutter build apk             # Build Android APK
flutter test                  # Run tests
```

---

## Support / ช่วยเหลือ

Need help? Check:
- [Full README](README.md)
- [API Docs](docs/API.md)
- [GitHub Issues](https://github.com/somkheartk/transportation-system/issues)

Happy shipping! 🚚📦
