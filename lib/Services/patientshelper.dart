import 'package:docbook/Models/patientmodel.dart';
import 'package:docbook/Services/main_service.dart';

class PatientsHelper {
  PatientsHelper._();
  static Future<List<PatientModel>> getAllPatients() async {
    final db = Service.database;
    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query(
        Service.patientsTable,
      );
      return List.generate(maps.length, (i) {
        return PatientModel.fromMap(maps[i]);
      });
    }
    return [];
  }

  static Future<void> addPatient(PatientModel patient) async {
    final db = Service.database;
    if (db != null) {
      await db.insert(
        Service.patientsTable,
        patient.toMap(),
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<void> updatePatient(PatientModel patient) async {
    final db = Service.database;
    if (db != null) {
      await db.update(
        Service.patientsTable,
        patient.toMap(),
        where: 'id = ?',
        whereArgs: [patient.id],
      );
    }
  }

  static Future<void> deletePatient(int id) async {
    final db = Service.database;
    if (db != null) {
      await db.delete(Service.patientsTable, where: 'id = ?', whereArgs: [id]);
    }
  }

  static Future<bool> loginPatient(String email, String passwordHash) async {
    final db = Service.database;
    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query(
        Service.patientsTable,
        where: 'email = ? AND password_hash = ?',
        whereArgs: [email, passwordHash],
      );
      return maps.isNotEmpty;
    }
    return false;
  }
}
