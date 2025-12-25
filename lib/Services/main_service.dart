// import 'dart:';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class Service {
  Service._();
  static final String _dbName = "docbook.db";
  static final String doctorsTable = "doctors";
  static final String patientsTable = "patients";
  static final String appointmentsTable = "appointments";

  static Database? database;

  static Future<void> openDb() async {
    final databasePath = await getDatabasesPath();
    final path = p.join(databasePath, _dbName);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(_createDoctorsTable());
        await db.execute(_createPatientsTable());
        await db.execute(_createAppointmentsTable());
      },
    );
  }

  static String _createDoctorsTable() {
    return '''
    CREATE TABLE doctors (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      specialty TEXT NOT NULL,
      phone TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      password_hash TEXT NOT NULL,
      is_available INTEGER NOT NULL DEFAULT 1,
      profile_picture TEXT
    )
  ''';
  }

  static String _createPatientsTable() {
    return '''
    CREATE TABLE patients (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      phone TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      password_hash TEXT NOT NULL,
      date_of_birth TEXT,
      gender TEXT,
      profile_picture TEXT
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
