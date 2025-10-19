# Transportation System / ระบบติดตามการขนส่ง

A comprehensive transportation tracking system built with **Flutter** for mobile frontend and **NestJS** with **MongoDB** for backend. This system allows tracking shipments to various warehouses and stores.

ระบบติดตามการขนส่งสินค้าที่สมบูรณ์แบบ พัฒนาด้วย Flutter สำหรับแอปพลิเคชันมือถือ และ NestJS กับ MongoDB สำหรับส่วนหลังบ้าน ระบบนี้ช่วยในการติดตามสินค้าไปยังคลังสินค้าและร้านค้าต่างๆ

## 🚀 Features / คุณสมบัติ

### Backend (NestJS)
- ✅ RESTful API with Swagger documentation
- ✅ MongoDB database integration
- ✅ Shipment management (CRUD operations)
- ✅ Warehouse/Store management
- ✅ Real-time tracking history
- ✅ Status updates and notifications
- ✅ Data validation with DTOs
- ✅ Docker support for easy deployment

### Frontend (Flutter)
- ✅ Beautiful Material Design 3 UI
- ✅ Shipment tracking by tracking number
- ✅ List all shipments with status
- ✅ Warehouse and store management
- ✅ Detailed shipment information
- ✅ Tracking history timeline
- ✅ Pull-to-refresh functionality
- ✅ Responsive and intuitive interface

## 📁 Project Structure

```
transportation-system/
├── backend/                 # NestJS Backend
│   ├── src/
│   │   ├── shipments/      # Shipment module
│   │   ├── warehouses/     # Warehouse module
│   │   ├── auth/           # Authentication module
│   │   └── main.ts         # Application entry
│   ├── Dockerfile
│   └── package.json
├── frontend/               # Flutter Mobile App
│   ├── lib/
│   │   ├── config/        # Configuration files
│   │   ├── models/        # Data models
│   │   ├── services/      # API services
│   │   ├── providers/     # State management
│   │   ├── screens/       # UI screens
│   │   └── widgets/       # Reusable widgets
│   └── pubspec.yaml
├── docker-compose.yml      # Docker compose configuration
└── README.md
```

## 🛠️ Technology Stack

### Backend
- **NestJS** - Progressive Node.js framework
- **MongoDB** - NoSQL database
- **Mongoose** - ODM for MongoDB
- **Passport JWT** - Authentication
- **Swagger** - API documentation
- **TypeScript** - Type-safe JavaScript

### Frontend
- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **Provider** - State management
- **Dio** - HTTP client
- **Material Design 3** - UI components

## 📋 Prerequisites

- Node.js (v20+)
- npm or yarn
- MongoDB (v7+)
- Flutter SDK (v3+)
- Docker & Docker Compose (optional)

## 🚀 Getting Started

### Option 1: Using Docker (Recommended)

1. Clone the repository:
```bash
git clone https://github.com/somkheartk/transportation-system.git
cd transportation-system
```

2. Start all services with Docker Compose:
```bash
docker-compose up -d
```

The backend will be available at:
- API: http://localhost:3000
- Swagger Documentation: http://localhost:3000/api

### Option 2: Manual Setup

#### Backend Setup

1. Navigate to backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
```

3. Configure environment variables:
```bash
cp .env.example .env
# Edit .env file with your configuration
```

4. Start MongoDB (if not using Docker):
```bash
# Using Docker
docker run -d -p 27017:27017 --name mongodb mongo:7.0

# Or install MongoDB locally
```

5. Run the backend:
```bash
# Development mode
npm run start:dev

# Production mode
npm run build
npm run start:prod
```

#### Frontend Setup

1. Navigate to frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure API endpoint:
Edit `lib/config/api_config.dart` and update the `baseUrl`:
```dart
static const String baseUrl = 'http://your-backend-url:3000';
```

4. Run the app:
```bash
# For Android/iOS
flutter run

# For Web
flutter run -d chrome

# Build for release
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

## 📖 API Documentation

Once the backend is running, visit the Swagger documentation at:
```
http://localhost:3000/api
```

### Main Endpoints

#### Shipments
- `GET /shipments` - Get all shipments
- `GET /shipments/:id` - Get shipment by ID
- `GET /shipments/tracking/:trackingNumber` - Track shipment
- `POST /shipments` - Create new shipment
- `PATCH /shipments/:id` - Update shipment
- `PATCH /shipments/:id/tracking` - Add tracking update
- `DELETE /shipments/:id` - Delete shipment

#### Warehouses
- `GET /warehouses` - Get all warehouses
- `GET /warehouses/active` - Get active warehouses
- `GET /warehouses/:id` - Get warehouse by ID
- `POST /warehouses` - Create new warehouse
- `PATCH /warehouses/:id` - Update warehouse
- `DELETE /warehouses/:id` - Delete warehouse

## 🎨 Mobile App Screens

### 1. Shipments Screen
- View all shipments
- Filter by status
- Quick status indicators
- Pull to refresh

### 2. Warehouses Screen
- List all warehouses and stores
- View warehouse details
- Active/inactive status

### 3. Tracking Screen
- Search by tracking number
- View shipment details
- Tracking history timeline

### 4. Shipment Details
- Complete shipment information
- Sender and receiver details
- Tracking history with timestamps
- Status updates

## 🗄️ Database Schema

### Shipment Collection
```javascript
{
  trackingNumber: String,
  senderName: String,
  senderAddress: String,
  senderPhone: String,
  receiverName: String,
  receiverAddress: String,
  receiverPhone: String,
  destinationWarehouse: ObjectId,
  itemDescription: String,
  weight: Number,
  quantity: Number,
  status: Enum['pending', 'in_transit', 'delivered', 'cancelled'],
  estimatedDeliveryDate: Date,
  actualDeliveryDate: Date,
  trackingHistory: [{
    location: String,
    timestamp: Date,
    notes: String
  }],
  notes: String,
  createdAt: Date,
  updatedAt: Date
}
```

### Warehouse Collection
```javascript
{
  name: String,
  address: String,
  city: String,
  province: String,
  postalCode: String,
  phone: String,
  email: String,
  type: Enum['warehouse', 'store', 'distribution_center'],
  coordinates: {
    lat: Number,
    lng: Number
  },
  isActive: Boolean,
  capacity: Number,
  manager: String,
  notes: String,
  createdAt: Date,
  updatedAt: Date
}
```

## 🧪 Testing

### Backend Tests
```bash
cd backend

# Unit tests
npm run test

# E2E tests
npm run test:e2e

# Test coverage
npm run test:cov
```

### Frontend Tests
```bash
cd frontend

# Run tests
flutter test

# Integration tests
flutter test integration_test
```

## 🔒 Security

- Environment variables for sensitive data
- JWT authentication (ready for implementation)
- Input validation with class-validator
- CORS enabled
- MongoDB injection prevention

## 📦 Deployment

### Backend Deployment

1. **Using Docker:**
```bash
docker build -t transportation-backend ./backend
docker run -p 3000:3000 transportation-backend
```

2. **Using PM2:**
```bash
npm install -g pm2
cd backend
npm run build
pm2 start dist/main.js --name transportation-api
```

### Frontend Deployment

1. **Android:**
```bash
flutter build apk --release
# APK located at: build/app/outputs/flutter-apk/app-release.apk
```

2. **iOS:**
```bash
flutter build ios --release
# Follow iOS deployment process
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License.

## 👥 Authors

- **Somkheart K** - Initial work

## 🙏 Acknowledgments

- NestJS team for the amazing framework
- Flutter team for the cross-platform toolkit
- MongoDB for the flexible database

## 📞 Support

For support, email somkheart@example.com or open an issue in the repository.

---

Made with ❤️ for better transportation management