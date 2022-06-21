import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserModel {
  static String? name;
  static String? email;

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<bool> setUser(
      String name, String email, String password) async {
    final SharedPreferences prefs = await _prefs;
    List<String> users = <String>[...?prefs.getStringList('users')?.toList()];
    Map<String, String> latestUser = {
      "name": name,
      "email": email,
      "password": password,
    };
    String latestUserJson = jsonEncode(latestUser);
    users.add(latestUserJson);

    bool response = await prefs.setStringList('users', users);

    return response;
  }

  static Future<bool> validateEmail(String? email) async {
    final SharedPreferences prefs = await _prefs;
    List<String>? users = prefs.getStringList('users');
    if (users != null && users.isNotEmpty) {
      bool validEmail = users.every((element) {
        var user = jsonDecode(element);
        return user['email'] != email;
      });
      return validEmail;
    } else {
      return true;
    }
  }

  static Future<Map?> checkUser(String email, String password) async {
    final SharedPreferences prefs = await _prefs;
    List<String>? users = prefs.getStringList('users');
    if (users != null && users.isNotEmpty) {
      List? validUser = users.where((element) {
        var user = jsonDecode(element);
        return (user['email'] == email && user['password'] == password);
      }).toList();
      if (validUser.isEmpty) {
        return null;
      }
      var user = jsonDecode(validUser[0]);
      return user;
    } else {
      return null;
    }
  }

  static Future<bool> loginUser(name, email) async {
    final SharedPreferences prefs = await _prefs;
    bool response = await prefs.setString("isLogin", email);
    bool secondResponse = await prefs.setString("isLoginUser", name);
    if (response && secondResponse) {
      UserModel.name = name;
      UserModel.email = email;
    }
    return response && secondResponse;
  }

  static Future<bool> isLogin() async {
    final SharedPreferences prefs = await _prefs;
    email = prefs.getString("isLogin");
    name = prefs.getString("isLoginUser");

    return email != null ? true : false;
  }

  static Future<bool> logout() async {
    final SharedPreferences prefs = await _prefs;
    bool logout = await prefs.remove("isLogin");
    bool secondLogout = await prefs.remove("isLoginUser");
    if (logout && secondLogout) {
      name = null;
      email = null;
    }
    return logout && secondLogout;
  }

  static Future<bool> resetData() async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.clear();
  }
}
