class HomeResponse {
  final String name;
  final String address;
  final int ownerId;
  final int id;

  HomeResponse({
    required this.name,
    required this.address,
    required this.ownerId,
    required this.id,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      name: json['name'],
      address: json['address'],
      ownerId: (json['owner_id'] as num).toInt(),
      id: (json['id'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'address': address, "agowner_ide": ownerId, 'id': id};
  }
}
