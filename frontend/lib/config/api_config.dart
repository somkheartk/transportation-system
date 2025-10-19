class ApiConfig {
  // Change this to your backend URL
  static const String baseUrl = 'http://localhost:3000';
  
  // API Endpoints
  static const String shipmentsEndpoint = '/shipments';
  static const String warehousesEndpoint = '/warehouses';
  
  // Timeout
  static const Duration timeout = Duration(seconds: 30);
}
