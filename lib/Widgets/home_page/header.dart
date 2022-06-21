import 'package:flutter/material.dart';
import 'package:todo_app/Models/users.dart';
import 'package:todo_app/Widgets/Global/custom_text.dart';
import 'package:todo_app/global_constants.dart';

Widget header(BuildContext context, method) {
  return Stack(
    alignment: Alignment.topLeft,
    children: [
      Container(
        color: Color(colors['theme']!),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.55,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Image(image: AssetImage("assets/images/profile.png")),
              const CustomText(
                "WELCOME",
                fontSize: 30,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
                topPadding: 10,
              ),
              CustomText(
                UserModel.name!.toUpperCase(),
                fontSize: 25,
                fontWeight: FontWeight.w600,
                textColor: Colors.white,
              ),
              TextButton(
                onPressed: method,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CustomText(
                      "Logout",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.white,
                      rightPadding: 10,
                    ),
                    Icon(
                      Icons.logout_sharp,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      const Positioned(
        child: Image(
          image: AssetImage("assets/images/Shape White.png"),
        ),
      ),
    ],
  );
}
