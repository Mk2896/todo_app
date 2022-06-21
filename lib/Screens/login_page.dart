import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/Models/users.dart';
import 'package:todo_app/Screens/home_page.dart';
import 'package:todo_app/Screens/register_page.dart';
import 'package:todo_app/Widgets/Global/custom_button.dart';
import 'package:todo_app/Widgets/Global/custom_text.dart';
import 'package:todo_app/Widgets/Global/custom_text_field.dart';
import 'package:todo_app/Widgets/Global/loader.dart';
import 'package:todo_app/Widgets/Global/show_hide_eye.dart';
import 'package:todo_app/global_constants.dart';
import 'package:todo_app/Widgets/Global/string_extensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _emailErrorText;

  bool _obsecureText = true;

  void showHidePassword() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password Must be atleast 6 characters.";
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!value.isValidEmail()) {
      return "Invalid Email";
    }
    return null;
  }

  Future<void> _loginAttempt(context) async {
    if (_formKey.currentState!.validate()) {
      showDialog(context: context, builder: loader);
      Map? response = await UserModel.checkUser(
          _emailController.text, _passwordController.text);
      if (response != null) {
        bool finalResponse =
            await UserModel.loginUser(response['name'], response['email']);
        if (finalResponse) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        }
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _emailErrorText = "Either Email or Password Incorrect";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(image: AssetImage("assets/images/Shape.png")),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: CustomText(
                constTexts['welcome_back']!,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                  child: Image(image: AssetImage("assets/images/Login.png"))),
            ),
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    CustomTextField(
                      textController: _emailController,
                      labelText: "Email",
                      errorText: _emailErrorText,
                      topMargin: 10,
                      filledBackground: true,
                      borderColor: Color(colors['theme']!),
                      borderRadius: 50,
                      focusBorderColor: Color(colors['theme']!),
                      focusBorderRadius: 50,
                      cursorColor: Color(colors['theme']!),
                      keyboardType: TextInputType.emailAddress,
                      keyboardSubmitButton: TextInputAction.next,
                      validatorMethod: _emailValidator,
                    ),
                    CustomTextField(
                      textController: _passwordController,
                      labelText: "Password",
                      topMargin: 10,
                      filledBackground: true,
                      borderColor: Color(colors['theme']!),
                      borderRadius: 50,
                      focusBorderColor: Color(colors['theme']!),
                      focusBorderRadius: 50,
                      cursorColor: Color(colors['theme']!),
                      isPassword: _obsecureText,
                      validatorMethod: _passwordValidator,
                      suffixIcon: showHideEye(_obsecureText,showHidePassword),
                      suffixIconColor: Color(colors['theme']!),
                    ),
                    CustomButton(
                      constTexts['login']!,
                      topMargin: 20,
                      border: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      backgroundColor: Color(colors['theme']!),
                      method: () => _loginAttempt(context),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    constTexts["register_text"]!,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          )),
                      child: CustomText(
                        constTexts["register"]!,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        textColor: Color(colors["theme"]!),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
