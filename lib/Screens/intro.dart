import 'package:flutter/material.dart';
import 'package:todo_app/Screens/login_page.dart';
import 'package:todo_app/Widgets/Global/custom_button.dart';
import 'package:todo_app/Widgets/Global/custom_text.dart';
import 'package:todo_app/global_constants.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(image: AssetImage("assets/images/Shape.png")),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Image(image: AssetImage("assets/images/Intro.png")),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CustomText(
                constTexts['title']!.toUpperCase(),
                topPadding: 20,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: CustomText(
                constTexts['intro_description']!,
                topPadding: 20,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Center(
            child: CustomButton(
              constTexts['get_started']!,
              backgroundColor: Color(colors['theme']!),
              topMargin: 30,
              border: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              method: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage())),
            ),
          ),
        ],
      ),
    );
  }
}
