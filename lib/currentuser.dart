import 'package:docbook/Models/doctorsmodel.dart';
import 'package:docbook/Models/patientmodel.dart';
import 'package:docbook/Services/doctorshelper.dart';
import 'package:docbook/Services/patientshelper.dart';

class Currentuser {
  static late int _usrId;
  static late bool isDoctor;

  static late String? name;
  static bool isLoggedIn = false;
  Currentuser._();
  static void login(int id, bool isdoctor) {
    _usrId = id;
    isDoctor = isdoctor;
    name = isdoctor ? getCurrentDocots()!.name : getCurrentPatient()!.name;
    isLoggedIn = true;
  }

  static void logout() {
    _usrId = 0;
    isDoctor = false;
    name = null;
    isLoggedIn = false;
  }

  static DoctorsModel? getCurrentDocots() {
    if (!isDoctor) {
      return null;
    }
    return DoctorsHelper.doctors.firstWhere((doctor) => doctor.id == _usrId);
  }

  static PatientModel? getCurrentPatient() {
    if (isDoctor) {
      return null;
    }
    return PatientsHelper.patients.firstWhere(
      (patient) => patient.id == _usrId,
    );
  }
}
