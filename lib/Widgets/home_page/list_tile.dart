import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/Global/custom_text.dart';
import 'package:todo_app/Widgets/home_page/add_update_todo_alert.dart';
import 'package:todo_app/global_constants.dart';
import 'package:todo_app/Widgets/Global/string_extensions.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    Key? key,
    required this.index,
    required this.title,
    required this.updateTodoController,
    required this.formKey,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(key: key);

  final String title;
  final int index;
  final TextEditingController updateTodoController;
  final GlobalKey<FormState> formKey;
  final void Function(int) updateTodo;
  final void Function(int) deleteTodo;

  void _editTodo(context) {
    updateTodoController.text = title;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (builder) {
        return AddUpdateTodoAlert(
          submitBtnText: "Update",
          textController: updateTodoController,
          formKey: formKey,
          submit: () => updateTodo(index),
        );
      },
    );
  }

  void _deleteTodo(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Column(
            children: [
              CustomText(
                "Are You Sure!",
                fontSize: 20,
                textColor: Color(colors['theme']!),
              ),
              const CustomText(
                "You Want To Delete This TODO",
                fontSize: 15,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => deleteTodo(index),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color(colors['theme']!)),
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: Color(colors['theme']!),
        ),
      ),
      shadowColor: Colors.grey,
      child: ListTile(
        tileColor: Color(colors['background']!),
        title: CustomText(
          title.toTitleCase(),
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => _editTodo(context),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.orange,
                ),
              ),
              IconButton(
                onPressed: () => _deleteTodo(context),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
