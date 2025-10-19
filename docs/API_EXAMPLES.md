# API Examples / ตัวอย่างการใช้งาน API

Code examples for integrating with the Transportation System API in multiple programming languages.

ตัวอย่างโค้ดสำหรับการเชื่อมต่อกับ API ระบบติดตามการขนส่งในหลายภาษา

## Table of Contents / สารบัญ

1. [JavaScript/Node.js](#javascriptnodejs)
2. [Python](#python)
3. [PHP](#php)
4. [Java](#java)
5. [C# (.NET)](#c-net)
6. [Go](#go)
7. [Flutter/Dart](#flutterdart)
8. [cURL](#curl)

---

## JavaScript/Node.js

### Using Fetch API

```javascript
const API_BASE_URL = 'http://localhost:3000';

// Get all shipments
async function getAllShipments() {
  try {
    const response = await fetch(`${API_BASE_URL}/shipments`);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const shipments = await response.json();
    console.log('Shipments:', shipments);
    return shipments;
  } catch (error) {
    console.error('Error fetching shipments:', error);
  }
}

// Track shipment by tracking number
async function trackShipment(trackingNumber) {
  try {
    const response = await fetch(
      `${API_BASE_URL}/shipments/tracking/${trackingNumber}`
    );
    if (!response.ok) {
      if (response.status === 404) {
        console.log('Shipment not found');
        return null;
      }
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const shipment = await response.json();
    console.log('Shipment found:', shipment);
    return shipment;
  } catch (error) {
    console.error('Error tracking shipment:', error);
  }
}

// Create new shipment
async function createShipment(shipmentData) {
  try {
    const response = await fetch(`${API_BASE_URL}/shipments`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(shipmentData),
    });
    
    if (!response.ok) {
      const error = await response.json();
      throw new Error(`Error: ${error.message}`);
    }
    
    const newShipment = await response.json();
    console.log('Shipment created:', newShipment);
    return newShipment;
  } catch (error) {
    console.error('Error creating shipment:', error);
  }
}

// Add tracking update
async function addTrackingUpdate(shipmentId, updateData) {
  try {
    const response = await fetch(
      `${API_BASE_URL}/shipments/${shipmentId}/tracking`,
      {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(updateData),
      }
    );
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const updatedShipment = await response.json();
    console.log('Tracking updated:', updatedShipment);
    return updatedShipment;
  } catch (error) {
    console.error('Error adding tracking update:', error);
  }
}

// Example usage
(async () => {
  // Create a shipment
  const newShipment = await createShipment({
    trackingNumber: 'TRK001',
    senderName: 'John Doe',
    senderAddress: '123 Main St, Bangkok',
    senderPhone: '0812345678',
    receiverName: 'Jane Smith',
    receiverAddress: '456 Oak Ave, Chiang Mai',
    receiverPhone: '0887654321',
    itemDescription: 'Electronics',
    weight: 5.5,
    quantity: 2,
    status: 'pending',
  });
  
  // Add tracking update
  if (newShipment) {
    await addTrackingUpdate(newShipment._id, {
      location: 'Bangkok Warehouse',
      notes: 'Package received',
    });
  }
  
  // Track shipment
  await trackShipment('TRK001');
  
  // Get all shipments
  await getAllShipments();
})();
```

### Using Axios

```javascript
const axios = require('axios');

const API_BASE_URL = 'http://localhost:3000';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Get all shipments
async function getAllShipments() {
  try {
    const response = await api.get('/shipments');
    console.log('Shipments:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error:', error.response?.data || error.message);
  }
}

// Create shipment
async function createShipment(data) {
  try {
    const response = await api.post('/shipments', data);
    console.log('Created:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error:', error.response?.data || error.message);
  }
}

// Track shipment
async function trackShipment(trackingNumber) {
  try {
    const response = await api.get(`/shipments/tracking/${trackingNumber}`);
    console.log('Tracking info:', response.data);
    return response.data;
  } catch (error) {
    if (error.response?.status === 404) {
      console.log('Shipment not found');
    } else {
      console.error('Error:', error.response?.data || error.message);
    }
  }
}

// Get all warehouses
async function getAllWarehouses() {
  try {
    const response = await api.get('/warehouses');
    console.log('Warehouses:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error:', error.response?.data || error.message);
  }
}
```

---

## Python

### Using requests library

```python
import requests
import json
from datetime import datetime

API_BASE_URL = 'http://localhost:3000'

class TransportationAPI:
    def __init__(self, base_url=API_BASE_URL):
        self.base_url = base_url
        self.session = requests.Session()
        self.session.headers.update({'Content-Type': 'application/json'})
    
    def get_all_shipments(self):
        """Get all shipments"""
        try:
            response = self.session.get(f'{self.base_url}/shipments')
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f'Error fetching shipments: {e}')
            return None
    
    def track_shipment(self, tracking_number):
        """Track shipment by tracking number"""
        try:
            response = self.session.get(
                f'{self.base_url}/shipments/tracking/{tracking_number}'
            )
            response.raise_for_status()
            return response.json()
        except requests.exceptions.HTTPError as e:
            if e.response.status_code == 404:
                print(f'Shipment {tracking_number} not found')
            else:
                print(f'Error: {e}')
            return None
    
    def create_shipment(self, shipment_data):
        """Create new shipment"""
        try:
            response = self.session.post(
                f'{self.base_url}/shipments',
                json=shipment_data
            )
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f'Error creating shipment: {e}')
            if hasattr(e.response, 'json'):
                print(e.response.json())
            return None
    
    def add_tracking_update(self, shipment_id, location, notes=''):
        """Add tracking update to shipment"""
        try:
            update_data = {
                'location': location,
                'timestamp': datetime.utcnow().isoformat() + 'Z',
                'notes': notes
            }
            response = self.session.patch(
                f'{self.base_url}/shipments/{shipment_id}/tracking',
                json=update_data
            )
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f'Error adding tracking update: {e}')
            return None
    
    def update_shipment_status(self, shipment_id, status):
        """Update shipment status"""
        try:
            response = self.session.patch(
                f'{self.base_url}/shipments/{shipment_id}',
                json={'status': status}
            )
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f'Error updating status: {e}')
            return None
    
    def get_all_warehouses(self):
        """Get all warehouses"""
        try:
            response = self.session.get(f'{self.base_url}/warehouses')
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f'Error fetching warehouses: {e}')
            return None
    
    def get_active_warehouses(self):
        """Get only active warehouses"""
        try:
            response = self.session.get(f'{self.base_url}/warehouses/active')
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f'Error fetching active warehouses: {e}')
            return None
    
    def create_warehouse(self, warehouse_data):
        """Create new warehouse"""
        try:
            response = self.session.post(
                f'{self.base_url}/warehouses',
                json=warehouse_data
            )
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f'Error creating warehouse: {e}')
            return None

# Example usage
if __name__ == '__main__':
    api = TransportationAPI()
    
    # Create a shipment
    shipment_data = {
        'trackingNumber': 'TRK001',
        'senderName': 'John Doe',
        'senderAddress': '123 Main St, Bangkok',
        'senderPhone': '0812345678',
        'receiverName': 'Jane Smith',
        'receiverAddress': '456 Oak Ave, Chiang Mai',
        'receiverPhone': '0887654321',
        'itemDescription': 'Electronics',
        'weight': 5.5,
        'quantity': 2,
        'status': 'pending'
    }
    
    new_shipment = api.create_shipment(shipment_data)
    if new_shipment:
        print(f"Created shipment: {new_shipment['_id']}")
        
        # Add tracking update
        api.add_tracking_update(
            new_shipment['_id'],
            'Bangkok Warehouse',
            'Package received at warehouse'
        )
        
        # Update status
        api.update_shipment_status(new_shipment['_id'], 'in_transit')
    
    # Track shipment
    tracking_info = api.track_shipment('TRK001')
    if tracking_info:
        print(f"Status: {tracking_info['status']}")
        print(f"Tracking history: {len(tracking_info['trackingHistory'])} updates")
    
    # Get all shipments
    shipments = api.get_all_shipments()
    print(f"Total shipments: {len(shipments) if shipments else 0}")
    
    # Get active warehouses
    warehouses = api.get_active_warehouses()
    print(f"Active warehouses: {len(warehouses) if warehouses else 0}")
```

---

## PHP

### Using cURL

```php
<?php

class TransportationAPI {
    private $baseUrl;
    
    public function __construct($baseUrl = 'http://localhost:3000') {
        $this->baseUrl = $baseUrl;
    }
    
    private function makeRequest($method, $endpoint, $data = null) {
        $ch = curl_init($this->baseUrl . $endpoint);
        
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);
        
        if ($data) {
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
            curl_setopt($ch, CURLOPT_HTTPHEADER, [
                'Content-Type: application/json',
                'Content-Length: ' . strlen(json_encode($data))
            ]);
        } else {
            curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
        }
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        $result = json_decode($response, true);
        
        return [
            'status' => $httpCode,
            'data' => $result
        ];
    }
    
    public function getAllShipments() {
        return $this->makeRequest('GET', '/shipments');
    }
    
    public function trackShipment($trackingNumber) {
        return $this->makeRequest('GET', '/shipments/tracking/' . $trackingNumber);
    }
    
    public function createShipment($shipmentData) {
        return $this->makeRequest('POST', '/shipments', $shipmentData);
    }
    
    public function updateShipment($shipmentId, $updateData) {
        return $this->makeRequest('PATCH', '/shipments/' . $shipmentId, $updateData);
    }
    
    public function addTrackingUpdate($shipmentId, $location, $notes = '') {
        $updateData = [
            'location' => $location,
            'timestamp' => date('c'),
            'notes' => $notes
        ];
        return $this->makeRequest('PATCH', '/shipments/' . $shipmentId . '/tracking', $updateData);
    }
    
    public function getAllWarehouses() {
        return $this->makeRequest('GET', '/warehouses');
    }
    
    public function getActiveWarehouses() {
        return $this->makeRequest('GET', '/warehouses/active');
    }
    
    public function createWarehouse($warehouseData) {
        return $this->makeRequest('POST', '/warehouses', $warehouseData);
    }
}

// Example usage
$api = new TransportationAPI();

// Create a shipment
$shipmentData = [
    'trackingNumber' => 'TRK001',
    'senderName' => 'John Doe',
    'senderAddress' => '123 Main St, Bangkok',
    'senderPhone' => '0812345678',
    'receiverName' => 'Jane Smith',
    'receiverAddress' => '456 Oak Ave, Chiang Mai',
    'receiverPhone' => '0887654321',
    'itemDescription' => 'Electronics',
    'weight' => 5.5,
    'quantity' => 2,
    'status' => 'pending'
];

$result = $api->createShipment($shipmentData);
if ($result['status'] === 201) {
    echo "Shipment created: " . $result['data']['_id'] . "\n";
    
    // Add tracking update
    $api->addTrackingUpdate(
        $result['data']['_id'],
        'Bangkok Warehouse',
        'Package received'
    );
}

// Track shipment
$tracking = $api->trackShipment('TRK001');
if ($tracking['status'] === 200) {
    echo "Status: " . $tracking['data']['status'] . "\n";
} else if ($tracking['status'] === 404) {
    echo "Shipment not found\n";
}

// Get all warehouses
$warehouses = $api->getAllWarehouses();
if ($warehouses['status'] === 200) {
    echo "Total warehouses: " . count($warehouses['data']) . "\n";
}

?>
```

---

## Java

### Using HttpClient

```java
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class TransportationAPI {
    private final String baseUrl;
    private final HttpClient client;
    private final Gson gson;
    
    public TransportationAPI(String baseUrl) {
        this.baseUrl = baseUrl;
        this.client = HttpClient.newHttpClient();
        this.gson = new Gson();
    }
    
    public String getAllShipments() throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(baseUrl + "/shipments"))
            .header("Content-Type", "application/json")
            .GET()
            .build();
        
        HttpResponse<String> response = client.send(request, 
            HttpResponse.BodyHandlers.ofString());
        
        return response.body();
    }
    
    public String trackShipment(String trackingNumber) throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(baseUrl + "/shipments/tracking/" + trackingNumber))
            .header("Content-Type", "application/json")
            .GET()
            .build();
        
        HttpResponse<String> response = client.send(request, 
            HttpResponse.BodyHandlers.ofString());
        
        if (response.statusCode() == 404) {
            return null;
        }
        
        return response.body();
    }
    
    public String createShipment(JsonObject shipmentData) throws Exception {
        String jsonBody = gson.toJson(shipmentData);
        
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(baseUrl + "/shipments"))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
            .build();
        
        HttpResponse<String> response = client.send(request, 
            HttpResponse.BodyHandlers.ofString());
        
        return response.body();
    }
    
    public String addTrackingUpdate(String shipmentId, String location, String notes) 
            throws Exception {
        JsonObject updateData = new JsonObject();
        updateData.addProperty("location", location);
        updateData.addProperty("notes", notes);
        
        String jsonBody = gson.toJson(updateData);
        
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(baseUrl + "/shipments/" + shipmentId + "/tracking"))
            .header("Content-Type", "application/json")
            .method("PATCH", HttpRequest.BodyPublishers.ofString(jsonBody))
            .build();
        
        HttpResponse<String> response = client.send(request, 
            HttpResponse.BodyHandlers.ofString());
        
        return response.body();
    }
    
    public static void main(String[] args) {
        TransportationAPI api = new TransportationAPI("http://localhost:3000");
        
        try {
            // Create shipment
            JsonObject shipmentData = new JsonObject();
            shipmentData.addProperty("trackingNumber", "TRK001");
            shipmentData.addProperty("senderName", "John Doe");
            shipmentData.addProperty("senderAddress", "123 Main St, Bangkok");
            shipmentData.addProperty("senderPhone", "0812345678");
            shipmentData.addProperty("receiverName", "Jane Smith");
            shipmentData.addProperty("receiverAddress", "456 Oak Ave, Chiang Mai");
            shipmentData.addProperty("receiverPhone", "0887654321");
            shipmentData.addProperty("itemDescription", "Electronics");
            shipmentData.addProperty("weight", 5.5);
            shipmentData.addProperty("quantity", 2);
            shipmentData.addProperty("status", "pending");
            
            String result = api.createShipment(shipmentData);
            System.out.println("Created: " + result);
            
            // Track shipment
            String tracking = api.trackShipment("TRK001");
            System.out.println("Tracking: " + tracking);
            
            // Get all shipments
            String shipments = api.getAllShipments();
            System.out.println("All shipments: " + shipments);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

---

## C# (.NET)

### Using HttpClient

```csharp
using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

public class TransportationAPI
{
    private readonly HttpClient _client;
    private readonly string _baseUrl;
    
    public TransportationAPI(string baseUrl = "http://localhost:3000")
    {
        _baseUrl = baseUrl;
        _client = new HttpClient();
        _client.DefaultRequestHeaders.Add("Content-Type", "application/json");
    }
    
    public async Task<string> GetAllShipmentsAsync()
    {
        var response = await _client.GetAsync($"{_baseUrl}/shipments");
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadAsStringAsync();
    }
    
    public async Task<string> TrackShipmentAsync(string trackingNumber)
    {
        try
        {
            var response = await _client.GetAsync(
                $"{_baseUrl}/shipments/tracking/{trackingNumber}");
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadAsStringAsync();
        }
        catch (HttpRequestException ex) when (ex.Message.Contains("404"))
        {
            Console.WriteLine("Shipment not found");
            return null;
        }
    }
    
    public async Task<string> CreateShipmentAsync(object shipmentData)
    {
        var json = JsonSerializer.Serialize(shipmentData);
        var content = new StringContent(json, Encoding.UTF8, "application/json");
        
        var response = await _client.PostAsync($"{_baseUrl}/shipments", content);
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadAsStringAsync();
    }
    
    public async Task<string> AddTrackingUpdateAsync(string shipmentId, 
        string location, string notes = "")
    {
        var updateData = new
        {
            location = location,
            timestamp = DateTime.UtcNow.ToString("o"),
            notes = notes
        };
        
        var json = JsonSerializer.Serialize(updateData);
        var content = new StringContent(json, Encoding.UTF8, "application/json");
        
        var request = new HttpRequestMessage(HttpMethod.Patch, 
            $"{_baseUrl}/shipments/{shipmentId}/tracking")
        {
            Content = content
        };
        
        var response = await _client.SendAsync(request);
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadAsStringAsync();
    }
    
    public async Task<string> GetAllWarehousesAsync()
    {
        var response = await _client.GetAsync($"{_baseUrl}/warehouses");
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadAsStringAsync();
    }
}

// Example usage
class Program
{
    static async Task Main(string[] args)
    {
        var api = new TransportationAPI();
        
        // Create shipment
        var shipmentData = new
        {
            trackingNumber = "TRK001",
            senderName = "John Doe",
            senderAddress = "123 Main St, Bangkok",
            senderPhone = "0812345678",
            receiverName = "Jane Smith",
            receiverAddress = "456 Oak Ave, Chiang Mai",
            receiverPhone = "0887654321",
            itemDescription = "Electronics",
            weight = 5.5,
            quantity = 2,
            status = "pending"
        };
        
        var result = await api.CreateShipmentAsync(shipmentData);
        Console.WriteLine($"Created: {result}");
        
        // Track shipment
        var tracking = await api.TrackShipmentAsync("TRK001");
        Console.WriteLine($"Tracking: {tracking}");
        
        // Get all shipments
        var shipments = await api.GetAllShipmentsAsync();
        Console.WriteLine($"All shipments: {shipments}");
    }
}
```

---

## Go

### Using net/http

```go
package main

import (
    "bytes"
    "encoding/json"
    "fmt"
    "io/ioutil"
    "net/http"
    "time"
)

type TransportationAPI struct {
    BaseURL string
    Client  *http.Client
}

func NewTransportationAPI(baseURL string) *TransportationAPI {
    return &TransportationAPI{
        BaseURL: baseURL,
        Client:  &http.Client{Timeout: 10 * time.Second},
    }
}

func (api *TransportationAPI) GetAllShipments() ([]byte, error) {
    resp, err := api.Client.Get(api.BaseURL + "/shipments")
    if err != nil {
        return nil, err
    }
    defer resp.Body.Close()
    
    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        return nil, err
    }
    
    return body, nil
}

func (api *TransportationAPI) TrackShipment(trackingNumber string) ([]byte, error) {
    url := fmt.Sprintf("%s/shipments/tracking/%s", api.BaseURL, trackingNumber)
    resp, err := api.Client.Get(url)
    if err != nil {
        return nil, err
    }
    defer resp.Body.Close()
    
    if resp.StatusCode == 404 {
        return nil, fmt.Errorf("shipment not found")
    }
    
    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        return nil, err
    }
    
    return body, nil
}

func (api *TransportationAPI) CreateShipment(shipmentData map[string]interface{}) ([]byte, error) {
    jsonData, err := json.Marshal(shipmentData)
    if err != nil {
        return nil, err
    }
    
    resp, err := api.Client.Post(
        api.BaseURL+"/shipments",
        "application/json",
        bytes.NewBuffer(jsonData),
    )
    if err != nil {
        return nil, err
    }
    defer resp.Body.Close()
    
    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        return nil, err
    }
    
    return body, nil
}

func (api *TransportationAPI) AddTrackingUpdate(shipmentID, location, notes string) ([]byte, error) {
    updateData := map[string]interface{}{
        "location":  location,
        "timestamp": time.Now().UTC().Format(time.RFC3339),
        "notes":     notes,
    }
    
    jsonData, err := json.Marshal(updateData)
    if err != nil {
        return nil, err
    }
    
    url := fmt.Sprintf("%s/shipments/%s/tracking", api.BaseURL, shipmentID)
    req, err := http.NewRequest("PATCH", url, bytes.NewBuffer(jsonData))
    if err != nil {
        return nil, err
    }
    req.Header.Set("Content-Type", "application/json")
    
    resp, err := api.Client.Do(req)
    if err != nil {
        return nil, err
    }
    defer resp.Body.Close()
    
    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        return nil, err
    }
    
    return body, nil
}

func main() {
    api := NewTransportationAPI("http://localhost:3000")
    
    // Create shipment
    shipmentData := map[string]interface{}{
        "trackingNumber":   "TRK001",
        "senderName":       "John Doe",
        "senderAddress":    "123 Main St, Bangkok",
        "senderPhone":      "0812345678",
        "receiverName":     "Jane Smith",
        "receiverAddress":  "456 Oak Ave, Chiang Mai",
        "receiverPhone":    "0887654321",
        "itemDescription":  "Electronics",
        "weight":           5.5,
        "quantity":         2,
        "status":           "pending",
    }
    
    result, err := api.CreateShipment(shipmentData)
    if err != nil {
        fmt.Printf("Error creating shipment: %v\n", err)
        return
    }
    fmt.Printf("Created: %s\n", string(result))
    
    // Track shipment
    tracking, err := api.TrackShipment("TRK001")
    if err != nil {
        fmt.Printf("Error tracking: %v\n", err)
    } else {
        fmt.Printf("Tracking: %s\n", string(tracking))
    }
    
    // Get all shipments
    shipments, err := api.GetAllShipments()
    if err != nil {
        fmt.Printf("Error getting shipments: %v\n", err)
    } else {
        fmt.Printf("All shipments: %s\n", string(shipments))
    }
}
```

---

## Flutter/Dart

### Using Dio (as in the project)

```dart
import 'package:dio/dio.dart';

class TransportationAPI {
  final Dio _dio;
  final String baseUrl;
  
  TransportationAPI({this.baseUrl = 'http://localhost:3000'}) 
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {'Content-Type': 'application/json'},
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
        ));
  
  // Get all shipments
  Future<List<dynamic>> getAllShipments() async {
    try {
      final response = await _dio.get('/shipments');
      return response.data;
    } on DioException catch (e) {
      print('Error fetching shipments: ${e.message}');
      rethrow;
    }
  }
  
  // Track shipment
  Future<Map<String, dynamic>?> trackShipment(String trackingNumber) async {
    try {
      final response = await _dio.get('/shipments/tracking/$trackingNumber');
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        print('Shipment not found');
        return null;
      }
      print('Error tracking shipment: ${e.message}');
      rethrow;
    }
  }
  
  // Create shipment
  Future<Map<String, dynamic>> createShipment(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/shipments', data: data);
      return response.data;
    } on DioException catch (e) {
      print('Error creating shipment: ${e.message}');
      if (e.response != null) {
        print('Response: ${e.response?.data}');
      }
      rethrow;
    }
  }
  
  // Add tracking update
  Future<Map<String, dynamic>> addTrackingUpdate(
    String shipmentId,
    String location,
    String notes,
  ) async {
    try {
      final response = await _dio.patch(
        '/shipments/$shipmentId/tracking',
        data: {
          'location': location,
          'timestamp': DateTime.now().toUtc().toIso8601String(),
          'notes': notes,
        },
      );
      return response.data;
    } on DioException catch (e) {
      print('Error adding tracking update: ${e.message}');
      rethrow;
    }
  }
  
  // Get all warehouses
  Future<List<dynamic>> getAllWarehouses() async {
    try {
      final response = await _dio.get('/warehouses');
      return response.data;
    } on DioException catch (e) {
      print('Error fetching warehouses: ${e.message}');
      rethrow;
    }
  }
  
  // Get active warehouses
  Future<List<dynamic>> getActiveWarehouses() async {
    try {
      final response = await _dio.get('/warehouses/active');
      return response.data;
    } on DioException catch (e) {
      print('Error fetching active warehouses: ${e.message}');
      rethrow;
    }
  }
}

// Example usage
void main() async {
  final api = TransportationAPI();
  
  try {
    // Create shipment
    final shipment = await api.createShipment({
      'trackingNumber': 'TRK001',
      'senderName': 'John Doe',
      'senderAddress': '123 Main St, Bangkok',
      'senderPhone': '0812345678',
      'receiverName': 'Jane Smith',
      'receiverAddress': '456 Oak Ave, Chiang Mai',
      'receiverPhone': '0887654321',
      'itemDescription': 'Electronics',
      'weight': 5.5,
      'quantity': 2,
      'status': 'pending',
    });
    
    print('Created shipment: ${shipment['_id']}');
    
    // Add tracking update
    await api.addTrackingUpdate(
      shipment['_id'],
      'Bangkok Warehouse',
      'Package received',
    );
    
    // Track shipment
    final tracking = await api.trackShipment('TRK001');
    if (tracking != null) {
      print('Status: ${tracking['status']}');
    }
    
    // Get all shipments
    final shipments = await api.getAllShipments();
    print('Total shipments: ${shipments.length}');
    
  } catch (e) {
    print('Error: $e');
  }
}
```

---

## cURL

### Complete cURL Examples

```bash
# Base URL
BASE_URL="http://localhost:3000"

# 1. Get all shipments
curl -X GET "$BASE_URL/shipments" \
  -H "Content-Type: application/json"

# 2. Track shipment by tracking number
curl -X GET "$BASE_URL/shipments/tracking/TRK123456" \
  -H "Content-Type: application/json"

# 3. Create shipment
curl -X POST "$BASE_URL/shipments" \
  -H "Content-Type: application/json" \
  -d '{
    "trackingNumber": "TRK123456",
    "senderName": "John Doe",
    "senderAddress": "123 Main St, Bangkok 10100",
    "senderPhone": "0812345678",
    "receiverName": "Jane Smith",
    "receiverAddress": "456 Oak Ave, Chiang Mai 50000",
    "receiverPhone": "0887654321",
    "itemDescription": "Electronics - Laptop",
    "weight": 5.5,
    "quantity": 2,
    "status": "pending",
    "estimatedDeliveryDate": "2025-10-25",
    "notes": "Handle with care"
  }'

# 4. Update shipment status
curl -X PATCH "$BASE_URL/shipments/SHIPMENT_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "in_transit",
    "notes": "Package picked up and in transit"
  }'

# 5. Add tracking update
curl -X PATCH "$BASE_URL/shipments/SHIPMENT_ID/tracking" \
  -H "Content-Type: application/json" \
  -d '{
    "location": "Bangkok Distribution Center",
    "timestamp": "2025-10-19T14:30:00.000Z",
    "notes": "Package arrived at warehouse"
  }'

# 6. Get all warehouses
curl -X GET "$BASE_URL/warehouses" \
  -H "Content-Type: application/json"

# 7. Get active warehouses only
curl -X GET "$BASE_URL/warehouses/active" \
  -H "Content-Type: application/json"

# 8. Create warehouse
curl -X POST "$BASE_URL/warehouses" \
  -H "Content-Type: application/json" \
  -d '{
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
    "manager": "Somchai Prasert"
  }'

# 9. Delete shipment
curl -X DELETE "$BASE_URL/shipments/SHIPMENT_ID" \
  -H "Content-Type: application/json"

# Pretty print JSON response
curl -X GET "$BASE_URL/shipments" | python -m json.tool

# Save response to file
curl -X GET "$BASE_URL/shipments" -o shipments.json

# Show HTTP status code
curl -X GET "$BASE_URL/shipments" -w "\nHTTP Status: %{http_code}\n"

# Verbose output for debugging
curl -v -X GET "$BASE_URL/shipments"
```

---

## Error Handling Best Practices

### General Guidelines

1. **Check HTTP status codes** before processing responses
2. **Handle 404 errors** gracefully (resource not found)
3. **Validate input data** before sending requests
4. **Implement retry logic** for network failures
5. **Log errors** for debugging
6. **Show user-friendly error messages**

### Example Error Handling (JavaScript)

```javascript
async function trackShipmentSafely(trackingNumber) {
  try {
    const response = await fetch(
      `${API_BASE_URL}/shipments/tracking/${trackingNumber}`
    );
    
    // Handle different status codes
    switch (response.status) {
      case 200:
        const data = await response.json();
        return { success: true, data };
        
      case 404:
        return { 
          success: false, 
          error: 'Tracking number not found. Please check and try again.' 
        };
        
      case 400:
        return { 
          success: false, 
          error: 'Invalid tracking number format.' 
        };
        
      case 500:
        return { 
          success: false, 
          error: 'Server error. Please try again later.' 
        };
        
      default:
        return { 
          success: false, 
          error: `Unexpected error: ${response.status}` 
        };
    }
  } catch (error) {
    // Network error or other exception
    return { 
      success: false, 
      error: 'Network error. Please check your connection.' 
    };
  }
}

// Usage
const result = await trackShipmentSafely('TRK123456');
if (result.success) {
  console.log('Shipment found:', result.data);
} else {
  console.error('Error:', result.error);
  // Show error to user
}
```

---

## Testing Your Integration

### Quick Test Checklist

- [ ] Can create a new shipment
- [ ] Can retrieve shipment by ID
- [ ] Can track shipment by tracking number
- [ ] Can add tracking updates
- [ ] Can update shipment status
- [ ] Can delete shipment
- [ ] Can create warehouse
- [ ] Can list warehouses
- [ ] Error handling works correctly
- [ ] Network timeouts are handled

---

## Additional Resources

- **Main Documentation:** [README.md](../README.md)
- **API Reference:** [API.md](API.md)
- **Wireframes:** [WIREFRAMES.md](WIREFRAMES.md)
- **Architecture:** [ARCHITECTURE.md](ARCHITECTURE.md)
- **User Guide:** [USER_GUIDE.md](USER_GUIDE.md)

---

**Last Updated:** 2025-10-19  
**Version:** 1.0.0
