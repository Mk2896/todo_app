import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/Models/users.dart';
import 'package:todo_app/Screens/home_page.dart';
import 'package:todo_app/Screens/intro.dart';
import 'package:todo_app/Widgets/Global/loader.dart';
import 'package:todo_app/global_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO APP',
      theme: ThemeData(
        backgroundColor: Color(colors['background']!),
      ),
      home: FutureBuilder<bool>(
          future: UserModel.isLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return loader(context);
              } else {
                if (snapshot.data == true) {
                  return HomePage();
                } else {
                  return const Intro();
                }
              }
            } else {
              return loader(context);
            }
          }),
    );
  }
}
