import 'package:flutter/material.dart';
import 'package:todo_app/global_constants.dart';

Widget showHideEye(bool show, void Function() onPress) {
  return IconButton(
    onPressed: onPress,
    icon: Icon(
      show ? Icons.visibility : Icons.visibility_off,
      color: Color(colors['theme']!),
    ),
  );
}
