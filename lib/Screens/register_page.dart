import 'package:flutter/material.dart';
import 'package:todo_app/Models/users.dart';
import 'package:todo_app/Screens/home_page.dart';
import 'package:todo_app/Widgets/Global/custom_button.dart';
import 'package:todo_app/Widgets/Global/custom_text.dart';
import 'package:todo_app/Widgets/Global/custom_text_field.dart';
import 'package:todo_app/Widgets/Global/loader.dart';
import 'package:todo_app/Widgets/Global/show_hide_eye.dart';
import 'package:todo_app/global_constants.dart';
import 'package:todo_app/Widgets/Global/string_extensions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _emailErrorText;

  bool _obsecureText = true;
  bool _confirmObsecureText = true;

  void showHidePassword() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  void showHideConfirmPassword() {
    setState(() {
      _confirmObsecureText = !_confirmObsecureText;
    });
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!value.isValidEmail()) {
      return "Invalid Email";
    }
    return null;
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password Must be atleast 6 characters.";
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password Must be atleast 6 characters.";
    } else if (value != _passwordController.text) {
      return "Confirm Password doesn't match";
    }
    return null;
  }

  Future<void> _registerAttempt(context) async {
    if (_formKey.currentState!.validate()) {
      showDialog(context: context, builder: loader);
      bool response = await UserModel.validateEmail(_emailController.text);
      if (!response) {
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _emailErrorText = "Email Already in use";
        });
      } else {
        setState(() {
          _emailErrorText = null;
        });
        bool response = await UserModel.setUser(_nameController.text,
            _emailController.text, _passwordController.text);
        if (response) {
          bool finalResponse = await UserModel.loginUser(
              _nameController.text, _emailController.text);
          if (finalResponse) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
          }
        }
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
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CustomText(
                  constTexts['welcome_on_board']!,
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    CustomTextField(
                      textController: _nameController,
                      labelText: "Enter Name",
                      topMargin: 10,
                      filledBackground: true,
                      borderColor: Color(colors['theme']!),
                      borderRadius: 50,
                      focusBorderColor: Color(colors['theme']!),
                      focusBorderRadius: 50,
                      cursorColor: Color(colors['theme']!),
                      keyboardSubmitButton: TextInputAction.next,
                      validatorMethod: _nameValidator,
                    ),
                    CustomTextField(
                      textController: _emailController,
                      labelText: "Enter Email",
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
                      labelText: "Enter Password",
                      topMargin: 10,
                      filledBackground: true,
                      borderColor: Color(colors['theme']!),
                      borderRadius: 50,
                      focusBorderColor: Color(colors['theme']!),
                      focusBorderRadius: 50,
                      cursorColor: Color(colors['theme']!),
                      keyboardSubmitButton: TextInputAction.next,
                      isPassword: _obsecureText,
                      validatorMethod: _passwordValidator,
                      suffixIcon: showHideEye(_obsecureText, showHidePassword),
                      suffixIconColor: Color(colors['theme']!),
                    ),
                    CustomTextField(
                      textController: null,
                      labelText: "Enter Confirm Password",
                      topMargin: 10,
                      filledBackground: true,
                      borderColor: Color(colors['theme']!),
                      borderRadius: 50,
                      focusBorderColor: Color(colors['theme']!),
                      focusBorderRadius: 50,
                      cursorColor: Color(colors['theme']!),
                      isPassword: _confirmObsecureText,
                      validatorMethod: _confirmPasswordValidator,
                      suffixIcon: showHideEye(
                          _confirmObsecureText, showHideConfirmPassword),
                      suffixIconColor: Color(colors['theme']!),
                    ),
                    CustomButton(
                      constTexts['register']!,
                      topMargin: 20,
                      border: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      backgroundColor: Color(colors['theme']!),
                      method: () => _registerAttempt(context),
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
                    constTexts["login_text"]!,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: CustomText(
                        constTexts["login"]!,
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
