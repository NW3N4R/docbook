class PatientModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String passwordHash;
  final String? dateOfBirth;
  final String? gender;
  final String? profilePicture;

  const PatientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.passwordHash,
    this.dateOfBirth,
    this.gender,
    this.profilePicture,
  });

  factory PatientModel.fromMap(Map<String, dynamic> json) => PatientModel(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    email: json['email'],
    passwordHash: json['password_hash'],
    dateOfBirth: json['date_of_birth'],
    gender: json['gender'],
    profilePicture: json['profile_picture'] ?? '',
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'password_hash': passwordHash,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'profile_picture': profilePicture,
    };
  }
}
