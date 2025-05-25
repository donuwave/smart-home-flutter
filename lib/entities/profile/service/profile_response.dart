class ProfileResponse {
  final String email;
  final String firstName;
  final String lastName;
  final int age;
  final int id;

  ProfileResponse({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.id,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: (json['age'] as num).toInt(),
      id: (json['id'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'id': id,
    };
  }
}
