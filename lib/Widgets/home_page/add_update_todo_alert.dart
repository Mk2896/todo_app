import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/Global/custom_text_field.dart';
import 'package:todo_app/global_constants.dart';

class AddUpdateTodoAlert extends StatelessWidget {
  const AddUpdateTodoAlert({
    Key? key,
    required this.textController,
    required this.formKey,
    required this.submit,
    required this.submitBtnText,
  }) : super(key: key);

  final TextEditingController textController;
  final GlobalKey<FormState> formKey;
  final void Function()? submit;
  final String submitBtnText;

  String? _validateTodo(String? value) {
    if (value == null || value.isEmpty) {
      return "TODO IS REQUIRED";
    }
    return null;
  }

  void closeDialog(context, TextEditingController textController) {
    textController.text = "";
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${submitBtnText.toUpperCase()} TODO"),
      content: Form(
        key: formKey,
        child: CustomTextField(
          topMargin: 20,
          textController: textController,
          borderColor: Color(colors['theme']!),
          borderRadius: 20,
          focusBorderColor: Color(colors['theme']!),
          focusBorderRadius: 20,
          filledBackground: true,
          cursorColor: Color(colors['theme']!),
          labelText: "Enter Todo",
          maxLength: 20,
          validatorMethod: _validateTodo,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => closeDialog(context, textController),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: submit,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(colors['theme']!)),
          ),
          child: Text(submitBtnText),
        ),
      ],
    );
  }
}
