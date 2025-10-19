import '../models/warehouse.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class WarehouseService {
  final ApiService _apiService = ApiService();

  Future<List<Warehouse>> getAllWarehouses() async {
    try {
      final response = await _apiService.get(ApiConfig.warehousesEndpoint);
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => Warehouse.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to load warehouses: $e');
    }
  }

  Future<List<Warehouse>> getActiveWarehouses() async {
    try {
      final response = await _apiService.get('${ApiConfig.warehousesEndpoint}/active');
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => Warehouse.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to load active warehouses: $e');
    }
  }

  Future<Warehouse> getWarehouseById(String id) async {
    try {
      final response = await _apiService.get('${ApiConfig.warehousesEndpoint}/$id');
      return Warehouse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to load warehouse: $e');
    }
  }

  Future<Warehouse> createWarehouse(Warehouse warehouse) async {
    try {
      final response = await _apiService.post(
        ApiConfig.warehousesEndpoint,
        data: warehouse.toJson(),
      );
      return Warehouse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create warehouse: $e');
    }
  }

  Future<Warehouse> updateWarehouse(String id, Map<String, dynamic> data) async {
    try {
      final response = await _apiService.patch(
        '${ApiConfig.warehousesEndpoint}/$id',
        data: data,
      );
      return Warehouse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update warehouse: $e');
    }
  }

  Future<void> deleteWarehouse(String id) async {
    try {
      await _apiService.delete('${ApiConfig.warehousesEndpoint}/$id');
    } catch (e) {
      throw Exception('Failed to delete warehouse: $e');
    }
  }
}
