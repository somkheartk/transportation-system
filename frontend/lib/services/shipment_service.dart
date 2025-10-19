import '../models/shipment.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class ShipmentService {
  final ApiService _apiService = ApiService();

  Future<List<Shipment>> getAllShipments() async {
    try {
      final response = await _apiService.get(ApiConfig.shipmentsEndpoint);
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => Shipment.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to load shipments: $e');
    }
  }

  Future<Shipment> getShipmentById(String id) async {
    try {
      final response = await _apiService.get('${ApiConfig.shipmentsEndpoint}/$id');
      return Shipment.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to load shipment: $e');
    }
  }

  Future<Shipment> getShipmentByTrackingNumber(String trackingNumber) async {
    try {
      final response = await _apiService.get(
        '${ApiConfig.shipmentsEndpoint}/tracking/$trackingNumber',
      );
      return Shipment.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to load shipment: $e');
    }
  }

  Future<Shipment> createShipment(Shipment shipment) async {
    try {
      final response = await _apiService.post(
        ApiConfig.shipmentsEndpoint,
        data: shipment.toJson(),
      );
      return Shipment.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create shipment: $e');
    }
  }

  Future<Shipment> updateShipment(String id, Map<String, dynamic> data) async {
    try {
      final response = await _apiService.patch(
        '${ApiConfig.shipmentsEndpoint}/$id',
        data: data,
      );
      return Shipment.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update shipment: $e');
    }
  }

  Future<Shipment> updateTracking(String id, TrackingHistory tracking) async {
    try {
      final response = await _apiService.patch(
        '${ApiConfig.shipmentsEndpoint}/$id/tracking',
        data: tracking.toJson(),
      );
      return Shipment.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update tracking: $e');
    }
  }

  Future<void> deleteShipment(String id) async {
    try {
      await _apiService.delete('${ApiConfig.shipmentsEndpoint}/$id');
    } catch (e) {
      throw Exception('Failed to delete shipment: $e');
    }
  }
}
