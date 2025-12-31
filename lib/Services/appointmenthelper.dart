import 'package:docbook/Models/appointmentsmodel.dart';
import 'package:docbook/Services/main_service.dart';

class AppointmentHelper {
  AppointmentHelper._();
  static List<AppointmentModel> appointments = [];
  static Future getAllAppointments() async {
    final db = Service.database;
    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query(
        Service.appointmentsTable,
      );
      appointments = List.generate(maps.length, (i) {
        return AppointmentModel.fromMap(maps[i]);
      });
    }
    return [];
  }

  static Future<void> addAppointment(AppointmentModel appointment) async {
    final db = Service.database;
    if (db != null) {
      await db.insert(
        Service.appointmentsTable,
        appointment.toMap(),
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<void> updateAppointment(AppointmentModel appointment) async {
    final db = Service.database;
    if (db != null) {
      await db.update(
        Service.appointmentsTable,
        appointment.toMap(),
        where: 'id = ?',
        whereArgs: [appointment.id],
      );
    }
  }

  static Future<void> deleteAppointment(int id) async {
    final db = Service.database;
    if (db != null) {
      await db.delete(
        Service.appointmentsTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }
}
