import 'package:flutter/material.dart';
import '../models/shipment.dart';
import '../services/shipment_service.dart';

class ShipmentProvider with ChangeNotifier {
  final ShipmentService _shipmentService = ShipmentService();
  List<Shipment> _shipments = [];
  bool _isLoading = false;
  String? _error;

  List<Shipment> get shipments => _shipments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadShipments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _shipments = await _shipmentService.getAllShipments();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Shipment?> getShipmentByTrackingNumber(String trackingNumber) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final shipment = await _shipmentService.getShipmentByTrackingNumber(trackingNumber);
      _isLoading = false;
      notifyListeners();
      return shipment;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<bool> createShipment(Shipment shipment) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newShipment = await _shipmentService.createShipment(shipment);
      _shipments.insert(0, newShipment);
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

  Future<bool> updateShipment(String id, Map<String, dynamic> data) async {
    try {
      final updatedShipment = await _shipmentService.updateShipment(id, data);
      final index = _shipments.indexWhere((s) => s.id == id);
      if (index != -1) {
        _shipments[index] = updatedShipment;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTracking(String id, TrackingHistory tracking) async {
    try {
      final updatedShipment = await _shipmentService.updateTracking(id, tracking);
      final index = _shipments.indexWhere((s) => s.id == id);
      if (index != -1) {
        _shipments[index] = updatedShipment;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteShipment(String id) async {
    try {
      await _shipmentService.deleteShipment(id);
      _shipments.removeWhere((s) => s.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
