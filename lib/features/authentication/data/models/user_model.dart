class UserModel {
  final String id;
  final String email;
  final String name;
  
  UserModel({
    required this.id,
    required this.email,
    required this.name,
  });
  
  // Create a UserModel from a Map (useful when retrieving from SharedPreferences)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['userId'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }
  
  // Convert UserModel to a Map (useful when saving to SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'userId': id,
      'email': email,
      'name': name,
    };
  }
  
  // Create a copy of the user with optional new values
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}