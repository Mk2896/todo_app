import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.topMargin = 0,
    this.bottomMargin = 0,
    this.leftMargin = 0,
    this.rightMargin = 0,
    this.textColor = Colors.black,
    this.cursorColor,
    this.errorText,
    this.filledBackground = false,
    this.filledBackgroundColor = const Color(0XFFFFFFFF),
    this.labelColor = Colors.black,
    this.labelText,
    this.keyboardType,
    required this.textController,
    this.validatorMethod,
    this.isPassword = false,
    required this.borderColor,
    this.borderRadius = 0,
    required this.focusBorderColor,
    this.focusBorderRadius = 0,
    this.keyboardSubmitButton,
    this.maxLength,
    this.suffixIcon,
    this.suffixIconColor,
  }) : super(key: key);
  final double topMargin;
  final double bottomMargin;
  final double leftMargin;
  final double rightMargin;
  final Color? cursorColor;
  final TextEditingController? textController;
  final TextInputType? keyboardType;
  final String? Function(String?)? validatorMethod;
  final bool filledBackground;
  final Color? filledBackgroundColor;
  final String? labelText;
  final Color? labelColor;
  final Color? textColor;
  final Color borderColor;
  final double borderRadius;
  final Color focusBorderColor;
  final double focusBorderRadius;
  final String? errorText;
  final bool isPassword;
  final int? maxLength;
  final TextInputAction? keyboardSubmitButton;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: topMargin,
        bottom: bottomMargin,
        left: leftMargin,
        right: rightMargin,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        maxLength: maxLength,
        obscureText: isPassword,
        controller: textController,
        cursorColor: cursorColor,
        keyboardType: keyboardType,
        validator: validatorMethod,
        textInputAction: keyboardSubmitButton,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(focusBorderRadius),
            borderSide: BorderSide(
              color: focusBorderColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(focusBorderRadius),
            borderSide: const BorderSide(
              color: Colors.orange,
            ),
          ),
          errorStyle: const TextStyle(
            fontFamily: "Poppins",
            color: Colors.orange,
          ),
          errorText: errorText,
          filled: filledBackground,
          fillColor: filledBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          labelText: labelText,
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            fontFamily: "Poppins",
            color: labelColor,
          ),
        ),
      ),
    );
  }
}
