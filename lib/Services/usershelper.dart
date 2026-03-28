import 'package:docbook/Models/usersmodel.dart';
import 'package:docbook/Services/main_service.dart';

class UsersHelper {
  static final String _tableName = 'Users';
  static List<UsersModel> users = [];

  static Future getUsers() async {
    users.clear();
    final db = Service.database;
    if (db != null) {
      final List<Map<String, dynamic>> mapResult = await db.query(_tableName);
      users = mapResult.map((e) => UsersModel.fromMap(e)).toList();
    }
  }

  static Future<int> insertUser(UsersModel user) async {
    final db = Service.database;
    if (db == null) return -1;

    Map<String, dynamic> userMap = user.toMap();

    // If id is 0, remove it so SQLite autogenerates a new one
    if (user.id == 0) {
      userMap.remove('id');
    }

    final int id = await db.insert(_tableName, userMap);
    await getUsers(); // Refresh the local list
    return id;
  }

  static Future<int> updateUser(UsersModel user) async {
    final db = Service.database;
    if (db == null) return -1;

    final int result = await db.update(
      _tableName,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );

    await getUsers(); // Refresh the local list
    return result;
  }

  static Future<int> deleteUser(int id) async {
    final db = Service.database;
    if (db == null) return -1;

    final int result = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    await getUsers(); // Refresh the local list
    return result;
  }

  static Future<UsersModel?> loginUser(String contact, String password) async {
    await getUsers();
    if (users.any((u) => u.password == password && u.phone == contact)) {
      return users.firstWhere(
        (u) => u.password == password && u.phone == contact,
      );
    }
    return null;
  }
}
