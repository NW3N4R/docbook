import 'package:docbook/Models/doctorsmodel.dart';
import 'package:docbook/Services/main_service.dart';

class DoctorsHelper {
  DoctorsHelper._();
  static Future<List<DoctorsModel>> getAllDoctors() async {
    final db = Service.database;
    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query(
        Service.doctorsTable,
      );
      return List.generate(maps.length, (i) {
        return DoctorsModel.fromMap(maps[i]);
      });
    }
    return [];
  }

  static Future<void> addDoctor(DoctorsModel doctor) async {
    final db = Service.database;
    if (db != null) {
      await db.insert(
        Service.doctorsTable,
        doctor.toMap(),
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<void> updateDoctor(DoctorsModel doctor) async {
    final db = Service.database;
    if (db != null) {
      await db.update(
        Service.doctorsTable,
        doctor.toMap(),
        where: 'id = ?',
        whereArgs: [doctor.id],
      );
    }
  }

  static Future<void> deleteDoctor(int id) async {
    final db = Service.database;
    if (db != null) {
      await db.delete(Service.doctorsTable, where: 'id = ?', whereArgs: [id]);
    }
  }

  static Future<bool> loginDoctor(String email, String passwordHash) async {
    final db = Service.database;
    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query(
        Service.doctorsTable,
        where: 'email = ? AND password_hash = ?',
        whereArgs: [email, passwordHash],
      );
      return maps.isNotEmpty;
    }
    return false;
  }
}
