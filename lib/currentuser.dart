import 'package:docbook/Models/usersmodel.dart';
import 'package:docbook/Services/usershelper.dart';
import 'package:flutter/material.dart';

class Currentuser {
  Currentuser._();
  static UsersModel? loggedUser;
  static Future<bool> login(String contact, String password) async {
    loggedUser = await UsersHelper.loginUser(contact, password);
    return loggedUser != null;
  }


}
