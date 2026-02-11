class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String? phone;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.phone,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      phone: json['phone'],
      role: json['role'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'phone': phone,
      'role': role,
    };
  }
}
