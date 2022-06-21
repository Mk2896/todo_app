import 'package:flutter/material.dart';

showLoader(BuildContext context) {
  
}

Widget loader(BuildContext context) {
  return AbsorbPointer(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.3),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: const CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Colors.green,
            strokeWidth: 5,
          ),
        ),
      ),
    ),
  );
}
