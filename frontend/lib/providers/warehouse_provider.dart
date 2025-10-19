import 'package:flutter/material.dart';
import '../models/warehouse.dart';
import '../services/warehouse_service.dart';

class WarehouseProvider with ChangeNotifier {
  final WarehouseService _warehouseService = WarehouseService();
  List<Warehouse> _warehouses = [];
  bool _isLoading = false;
  String? _error;

  List<Warehouse> get warehouses => _warehouses;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadWarehouses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _warehouses = await _warehouseService.getAllWarehouses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createWarehouse(Warehouse warehouse) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newWarehouse = await _warehouseService.createWarehouse(warehouse);
      _warehouses.insert(0, newWarehouse);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateWarehouse(String id, Map<String, dynamic> data) async {
    try {
      final updatedWarehouse = await _warehouseService.updateWarehouse(id, data);
      final index = _warehouses.indexWhere((w) => w.id == id);
      if (index != -1) {
        _warehouses[index] = updatedWarehouse;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteWarehouse(String id) async {
    try {
      await _warehouseService.deleteWarehouse(id);
      _warehouses.removeWhere((w) => w.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
