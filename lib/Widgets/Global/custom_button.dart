import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.text, {
    Key? key,
    this.topMargin = 0,
    this.bottomMargin = 0,
    this.leftMargin = 0,
    this.rightMargin = 0,
    this.textColor = Colors.white,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w600,
    this.fontFamily = "Poppins",
    required this.backgroundColor,
    required this.method,
    this.border,
  }) : super(key: key);
  final double topMargin;
  final double bottomMargin;
  final double leftMargin;
  final double rightMargin;
  final String text;
  final Color textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String fontFamily;
  final Color? backgroundColor;
  final OutlinedBorder? border;
  final void Function()? method;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: topMargin,
        bottom: bottomMargin,
        left: leftMargin,
        right: rightMargin,
      ),
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50,
      child: ElevatedButton(
        onPressed: method,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(border),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
