class Warehouse {
  final String? id;
  final String name;
  final String address;
  final String city;
  final String province;
  final String postalCode;
  final String phone;
  final String? email;
  final String type;
  final Coordinates? coordinates;
  final bool isActive;
  final int? capacity;
  final String? manager;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Warehouse({
    this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.phone,
    this.email,
    required this.type,
    this.coordinates,
    required this.isActive,
    this.capacity,
    this.manager,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['_id'] as String?,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      postalCode: json['postalCode'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      type: json['type'] as String,
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>)
          : null,
      isActive: json['isActive'] as bool? ?? true,
      capacity: json['capacity'] as int?,
      manager: json['manager'] as String?,
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
      'name': name,
      'address': address,
      'city': city,
      'province': province,
      'postalCode': postalCode,
      'phone': phone,
      if (email != null) 'email': email,
      'type': type,
      if (coordinates != null) 'coordinates': coordinates!.toJson(),
      'isActive': isActive,
      if (capacity != null) 'capacity': capacity,
      if (manager != null) 'manager': manager,
      if (notes != null) 'notes': notes,
    };
  }
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({
    required this.lat,
    required this.lng,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
