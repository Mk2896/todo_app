import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.textColor = Colors.black,
    this.fontSize,
    this.fontWeight,
    this.fontFamily = "Poppins",
  }) : super(key: key);
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final String text;
  final Color textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String fontFamily;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
          left: leftPadding,
          right: rightPadding),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        overflow: TextOverflow.clip,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
