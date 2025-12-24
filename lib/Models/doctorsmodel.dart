class DoctorsModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String specialty;
  final String phone;
  final int isAvailable;
  String profilePicture = '';

  DoctorsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.specialty,
    required this.phone,
    required this.isAvailable,
    this.profilePicture = '',
  });

  factory DoctorsModel.fromMap(Map<String, dynamic> json) => DoctorsModel(
    id: json['id'],
    name: json['name'],
    specialty: json['specialty'],
    phone: json['phone'],
    email: json['email'],
    password: json['password_hash'],
    isAvailable: json['is_Available'],
    profilePicture: json['profile_Picture'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'phone': phone,
      'email': email,
      'password_hash': password,
      'is_Available': isAvailable,
      'profile_Picture': profilePicture,
    };
  }
}
