// import 'dart:';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class Service {
  Service._();
  static final String _dbName = "docbook.db";
  static final String doctorsTable = "Users";
  static final String appointmentsTable = "appointments";

  static Database? database;

  static Future<void> openDb() async {
    final databasePath = await getDatabasesPath();
    final path = p.join(databasePath, _dbName);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(_createUsersTable());
        await db.execute(_createAppointmentsTable());
      },
    );
  }

  static String _createUsersTable() {
    return '''
    CREATE TABLE Users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      fullName TEXT NOT NULL,
      phone TEXT NOT NULL,
      email TEXT NULL,
      password text not null,
      address TEXT  NULL ,
      workPlace TEXT  NULL,
      birthDay text ,
      profession TEXT not null,
      isDoctor INTEGER not null default 0,
      isPatient INTEGER not null default 1
    )
  ''';
  }

  static String _createAppointmentsTable() {
    return '''
    CREATE TABLE appointments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      doctor_id INTEGER NOT NULL,
      patient_id INTEGER NOT NULL,
      appointment_date TEXT NOT NULL,
      appointment_time TEXT NOT NULL,
      status TEXT NOT NULL DEFAULT 'pending',
      notes TEXT,
      created_at TEXT NOT NULL,

      FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
      FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    )
  ''';
  }
}
