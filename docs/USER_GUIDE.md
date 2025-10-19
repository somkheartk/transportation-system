# User Guide / คู่มือผู้ใช้งาน

## Introduction / บทนำ

This guide will help you understand how to use the Transportation System for tracking shipments to warehouses and stores.

คู่มือนี้จะช่วยให้คุณเข้าใจวิธีการใช้งานระบบติดตามการขนส่งสินค้าไปยังคลังสินค้าและร้านค้า

## Getting Started / เริ่มต้นใช้งาน

### Accessing the System / การเข้าถึงระบบ

1. **Mobile App**: Open the Transportation System app on your mobile device
2. **API**: Access the API at `http://your-server:3000`
3. **Documentation**: View API docs at `http://your-server:3000/api`

## Mobile App Features / คุณสมบัติของแอปมือถือ

### 1. Shipments Screen / หน้าจอรายการการจัดส่ง

The main screen showing all shipments.

#### How to View Shipments / วิธีดูรายการการจัดส่ง

1. Open the app
2. You'll see the Shipments tab by default
3. Pull down to refresh the list
4. Tap on any shipment to view details

#### Shipment Status Colors / สีสถานะการจัดส่ง

- **Orange**: Pending (รอดำเนินการ)
- **Blue**: In Transit (กำลังจัดส่ง)
- **Green**: Delivered (ส่งถึงแล้ว)
- **Red**: Cancelled (ยกเลิก)

#### Information Displayed / ข้อมูลที่แสดง

- Tracking number / เลขติดตามพัสดุ
- Sender and receiver names / ชื่อผู้ส่งและผู้รับ
- Item description / รายละเอียดสินค้า
- Estimated delivery date / วันที่คาดว่าจะส่งถึง
- Current status / สถานะปัจจุบัน

### 2. Warehouses Screen / หน้าจอคลังสินค้า

View all warehouses and stores.

#### How to View Warehouses / วิธีดูรายการคลังสินค้า

1. Tap the "Warehouses" tab at the bottom
2. See list of all warehouses and stores
3. Pull down to refresh

#### Information Displayed / ข้อมูลที่แสดง

- Warehouse/store name / ชื่อคลังสินค้า/ร้านค้า
- Type (Warehouse, Store, Distribution Center) / ประเภท
- Address and location / ที่อยู่และสถานที่
- Contact phone number / เบอร์โทรติดต่อ
- Manager name / ชื่อผู้จัดการ
- Active/Inactive status / สถานะเปิด/ปิด

### 3. Tracking Screen / หน้าจอติดตามพัสดุ

Search and track shipments by tracking number.

#### How to Track a Shipment / วิธีติดตามพัสดุ

1. Tap the "Track" tab at the bottom
2. Enter the tracking number in the text field
3. Tap "Track Shipment" button or press Enter
4. View the shipment details and tracking history

#### What You'll See / สิ่งที่คุณจะเห็น

- Shipment status / สถานะการจัดส่ง
- Sender and receiver information / ข้อมูลผู้ส่งและผู้รับ
- Item details / รายละเอียดสินค้า
- Tracking history with timestamps / ประวัติการติดตามพร้อมเวลา

### 4. Shipment Details Screen / หน้าจอรายละเอียดการจัดส่ง

Detailed information about a specific shipment.

#### Sections / ส่วนต่างๆ

1. **Status Card / การ์ดสถานะ**
   - Large status icon and text
   - Tracking number
   - Color-coded status

2. **Shipment Details / รายละเอียดการจัดส่ง**
   - Item description / รายละเอียดสินค้า
   - Weight (kg) / น้ำหนัก
   - Quantity / จำนวน
   - Estimated delivery date / วันที่คาดว่าจะส่งถึง
   - Notes / หมายเหตุ

3. **Sender & Receiver / ผู้ส่งและผู้รับ**
   - FROM section with sender details / ข้อมูลผู้ส่ง
   - TO section with receiver details / ข้อมูลผู้รับ
   - Names, addresses, and phone numbers

4. **Tracking History / ประวัติการติดตาม**
   - Location updates / อัพเดทสถานที่
   - Timestamps / เวลา
   - Notes for each update / หมายเหตุในแต่ละอัพเดท

## API Usage / การใช้งาน API

### Authentication / การยืนยันตัวตน

Currently, the API is open without authentication. For production, implement JWT tokens.

### Common API Operations / การดำเนินการ API ทั่วไป

#### 1. Create a New Shipment / สร้างการจัดส่งใหม่

```bash
POST /shipments
Content-Type: application/json

{
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
  "status": "pending",
  "estimatedDeliveryDate": "2025-10-25"
}
```

#### 2. Track a Shipment / ติดตามพัสดุ

```bash
GET /shipments/tracking/TRK001
```

#### 3. Update Shipment Status / อัพเดทสถานะการจัดส่ง

```bash
PATCH /shipments/:id
Content-Type: application/json

{
  "status": "in_transit"
}
```

#### 4. Add Tracking Update / เพิ่มอัพเดทการติดตาม

```bash
PATCH /shipments/:id/tracking
Content-Type: application/json

{
  "location": "Bangkok Distribution Center",
  "timestamp": "2025-10-19T14:30:00.000Z",
  "notes": "Package sorted and ready for delivery"
}
```

#### 5. Create a Warehouse / สร้างคลังสินค้า

```bash
POST /warehouses
Content-Type: application/json

{
  "name": "Bangkok Central Warehouse",
  "address": "789 Industrial Rd",
  "city": "Bangkok",
  "province": "Bangkok",
  "postalCode": "10100",
  "phone": "021234567",
  "type": "warehouse",
  "isActive": true,
  "capacity": 10000,
  "manager": "Somchai Prasert"
}
```

## Best Practices / แนวปฏิบัติที่ดี

### For Users / สำหรับผู้ใช้งาน

1. **Tracking Numbers**: Use unique tracking numbers for each shipment
   - Format: TRK + numbers (e.g., TRK001, TRK002)
   
2. **Regular Updates**: Update tracking history regularly
   - When package is picked up
   - At each distribution center
   - When out for delivery
   - When delivered

3. **Accurate Information**: Ensure all contact information is correct
   - Phone numbers with country code
   - Complete addresses
   - Valid postal codes

4. **Status Management**: Update shipment status appropriately
   - `pending` → New shipment
   - `in_transit` → Package is moving
   - `delivered` → Package received
   - `cancelled` → Shipment cancelled

### For Administrators / สำหรับผู้ดูแลระบบ

1. **Warehouse Management**
   - Keep warehouse information up-to-date
   - Mark inactive warehouses properly
   - Maintain accurate capacity information

2. **Data Cleanup**
   - Archive old deliveries periodically
   - Remove test data before production
   - Backup database regularly

3. **Monitoring**
   - Check API logs regularly
   - Monitor database performance
   - Track API usage and errors

## Troubleshooting / การแก้ไขปัญหา

### Common Issues / ปัญหาที่พบบ่อย

#### 1. Cannot Find Shipment / หาพัสดุไม่เจอ

**Problem**: Tracking number not found

**Solutions**:
- Verify the tracking number is correct
- Check if shipment was deleted
- Ensure network connection is stable
- Try refreshing the app

#### 2. App Not Loading Data / แอปไม่โหลดข้อมูล

**Problem**: Screens show "loading" indefinitely

**Solutions**:
- Check internet connection
- Verify backend server is running
- Check API endpoint configuration in `api_config.dart`
- Pull down to refresh manually

#### 3. Cannot Connect to Server / เชื่อมต่อเซิร์ฟเวอร์ไม่ได้

**Problem**: "Network error" or "Connection timeout"

**Solutions**:
- Verify backend server is running
- Check firewall settings
- For Android emulator, use `http://10.0.2.2:3000`
- For physical device, use computer's IP address

#### 4. Shipment Status Not Updating / สถานะไม่อัพเดท

**Problem**: Changes don't reflect in the app

**Solutions**:
- Pull down to refresh the list
- Check if update was successful in API
- Verify database is running
- Check for error messages

### Error Messages / ข้อความแจ้งข้อผิดพลาด

| Error | Meaning | Solution |
|-------|---------|----------|
| "Shipment not found" | Invalid tracking number | Check tracking number |
| "Connection timeout" | Server not responding | Check server status |
| "Network error" | No internet connection | Check connectivity |
| "Failed to load" | API error | Check server logs |

## Tips and Tricks / เคล็ดลับและเทคนิค

1. **Quick Search**: Use the tracking screen for fast lookups
2. **Pull to Refresh**: Swipe down on any list to refresh data
3. **Tap for Details**: Tap any shipment card to see full details
4. **Status Colors**: Learn the color codes for quick status checks
5. **Bookmark**: Add frequently accessed warehouses to favorites (future feature)

## Support / การสนับสนุน

### Need Help? / ต้องการความช่วยเหลือ?

- **Email**: somkheart@example.com
- **GitHub Issues**: https://github.com/somkheartk/transportation-system/issues
- **Documentation**: Check the docs folder in the repository

### Reporting Bugs / รายงานบั๊ก

When reporting bugs, please include:
1. Steps to reproduce the issue
2. Expected behavior
3. Actual behavior
4. Screenshots (if applicable)
5. Device/browser information
6. App version

### Feature Requests / ขอฟีเจอร์ใหม่

Submit feature requests via GitHub Issues with:
1. Clear description of the feature
2. Use case and benefits
3. Any relevant examples or mockups

## Glossary / อภิธานศัพท์

- **Tracking Number**: Unique identifier for a shipment / เลขติดตามพัสดุที่ไม่ซ้ำกัน
- **Warehouse**: Storage facility for goods / คลังสินค้า
- **Distribution Center**: Hub for sorting and routing shipments / ศูนย์กระจายสินค้า
- **In Transit**: Package is currently being transported / กำลังขนส่ง
- **Delivered**: Package has reached its destination / ส่งถึงปลายทาง
- **Pending**: Waiting to be picked up / รอรับสินค้า
- **Cancelled**: Shipment has been cancelled / ยกเลิกการจัดส่ง

## Updates and Changelog / การอัพเดทและบันทึกการเปลี่ยนแปลง

### Version 1.0.0 (Current)

**Features**:
- Shipment tracking
- Warehouse management
- Real-time status updates
- Tracking history
- Mobile-responsive design

**Coming Soon**:
- Push notifications
- Barcode scanning
- Photo proof of delivery
- Advanced analytics
- Multi-language support

---

Thank you for using the Transportation System! / ขอบคุณที่ใช้ระบบติดตามการขนส่ง!
