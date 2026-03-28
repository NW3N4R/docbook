class UsersModel {
  final int id;
  final String fullName;
  final String phone;
  bool seeingPatients;
  final String password;
  final String profession;
  final String address;
  final int gender;

  UsersModel(
    this.id,
    this.fullName,
    this.phone,
    this.password,
    this.seeingPatients,
    this.profession,
    this.address,
    this.gender,
  );
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      map['id'],
      map['fullName'],
      map['phone'],
      map['password'],
      map['isOpenToSeePatients'] == 1,
      map['profession'],
      map['address'],
      map['gender'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'password': password,
      'isOpenToSeePatients': seeingPatients == true ? 1 : 0,
      'profession': profession,
      'gender': gender,
      'address': address,
    };
  }
}
