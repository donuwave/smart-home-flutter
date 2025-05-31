class DeviceResponse {
  final int homeId;
  final String deviceType;
  final String name;
  final String model;
  final String fullAddress;

  DeviceResponse({
    required this.homeId,
    required this.deviceType,
    required this.fullAddress,
    required this.model,
    required this.name,
  });

  factory DeviceResponse.fromJson(Map<String, dynamic> json) {
    return DeviceResponse(
      homeId: (json['home_id'] as num).toInt(),
      deviceType: json['device_type'],
      name: json['name'],
      model: json['model'],
      fullAddress: json['full_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home_id': homeId,
      'device_type': deviceType,
      'name': name,
      'model': model,
      'full_address': fullAddress,
    };
  }
}
