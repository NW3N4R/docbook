import 'dart:io';

class UsersModel {
  final int id;
  final String fullName;
  final String phone;
  final String email;
  final String address;
  final String workPlace;
  final DateTime birthDay;
  final String profession;
  bool isDoctor, isPatient;

  final String password;
  UsersModel(
    this.id,
    this.fullName,
    this.phone,
    this.email,
    this.address,
    this.workPlace,
    this.birthDay,
    this.profession,
    this.password,
    this.isDoctor,
    this.isPatient,
  );
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      map['id'],
      map['fullName'],
      map['phone'],
      map['email'],
      map['address'],
      map['workPlace'],
      DateTime.parse(map['birthDay']),
      map['profession'],
      map['password'],
      map['isDoctor'] == 1,
      map['isPatient'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'address': address,
      'workPlace': workPlace,
      'birthDay': birthDay.toString(),
      'profession': profession,
      'password': password,
      'isDoctor': isDoctor == true ? 1 : 0,
      'isPatient': isPatient == true ? 1 : 0,
    };
  }
}
