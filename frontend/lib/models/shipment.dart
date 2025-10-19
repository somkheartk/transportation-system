class Shipment {
  final String? id;
  final String trackingNumber;
  final String senderName;
  final String senderAddress;
  final String senderPhone;
  final String receiverName;
  final String receiverAddress;
  final String receiverPhone;
  final String? destinationWarehouse;
  final String itemDescription;
  final double weight;
  final int quantity;
  final String status;
  final DateTime? estimatedDeliveryDate;
  final DateTime? actualDeliveryDate;
  final List<TrackingHistory>? trackingHistory;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Shipment({
    this.id,
    required this.trackingNumber,
    required this.senderName,
    required this.senderAddress,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverAddress,
    required this.receiverPhone,
    this.destinationWarehouse,
    required this.itemDescription,
    required this.weight,
    required this.quantity,
    required this.status,
    this.estimatedDeliveryDate,
    this.actualDeliveryDate,
    this.trackingHistory,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['_id'] as String?,
      trackingNumber: json['trackingNumber'] as String,
      senderName: json['senderName'] as String,
      senderAddress: json['senderAddress'] as String,
      senderPhone: json['senderPhone'] as String,
      receiverName: json['receiverName'] as String,
      receiverAddress: json['receiverAddress'] as String,
      receiverPhone: json['receiverPhone'] as String,
      destinationWarehouse: json['destinationWarehouse'] as String?,
      itemDescription: json['itemDescription'] as String,
      weight: (json['weight'] as num).toDouble(),
      quantity: json['quantity'] as int,
      status: json['status'] as String,
      estimatedDeliveryDate: json['estimatedDeliveryDate'] != null
          ? DateTime.parse(json['estimatedDeliveryDate'] as String)
          : null,
      actualDeliveryDate: json['actualDeliveryDate'] != null
          ? DateTime.parse(json['actualDeliveryDate'] as String)
          : null,
      trackingHistory: json['trackingHistory'] != null
          ? (json['trackingHistory'] as List)
              .map((e) => TrackingHistory.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackingNumber': trackingNumber,
      'senderName': senderName,
      'senderAddress': senderAddress,
      'senderPhone': senderPhone,
      'receiverName': receiverName,
      'receiverAddress': receiverAddress,
      'receiverPhone': receiverPhone,
      if (destinationWarehouse != null) 'destinationWarehouse': destinationWarehouse,
      'itemDescription': itemDescription,
      'weight': weight,
      'quantity': quantity,
      'status': status,
      if (estimatedDeliveryDate != null)
        'estimatedDeliveryDate': estimatedDeliveryDate!.toIso8601String(),
      if (notes != null) 'notes': notes,
    };
  }
}

class TrackingHistory {
  final String location;
  final DateTime timestamp;
  final String? notes;

  TrackingHistory({
    required this.location,
    required this.timestamp,
    this.notes,
  });

  factory TrackingHistory.fromJson(Map<String, dynamic> json) {
    return TrackingHistory(
      location: json['location'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'timestamp': timestamp.toIso8601String(),
      if (notes != null) 'notes': notes,
    };
  }
}
