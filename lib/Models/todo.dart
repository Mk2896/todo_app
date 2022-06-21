import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<List<String>> getTodos(String id) async {
    final SharedPreferences prefs = await _prefs;
    List<String> todos = <String>[...?prefs.getStringList(id)?.toList()];
    return todos;
  }

  static Future<bool> addTodo(String id, List<String> todo) async {
    final SharedPreferences prefs = await _prefs;
    bool response = await prefs.setStringList(id, todo);
    return response;
  }
}
