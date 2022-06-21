import 'package:flutter/material.dart';
import 'package:todo_app/Models/todo.dart';
import 'package:todo_app/Models/users.dart';
import 'package:todo_app/Screens/login_page.dart';
import 'package:todo_app/Widgets/home_page/add_update_todo_alert.dart';
import 'package:todo_app/Widgets/home_page/header.dart';
import 'package:todo_app/Widgets/home_page/list_tile.dart';
import 'package:todo_app/global_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String>? currentTodos = [];
  final TextEditingController _addTodoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _updateTodoController = TextEditingController();
  final GlobalKey<FormState> _updateformKey = GlobalKey<FormState>();

  void _addTodo() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (builder) {
        return AddUpdateTodoAlert(
          submitBtnText: "Add",
          textController: _addTodoController,
          formKey: _formKey,
          submit: _submitTodo,
        );
      },
    );
  }

  Future<void> _submitTodo() async {
    if (_formKey.currentState!.validate()) {
      currentTodos?.add(_addTodoController.text);
      setState(() {});
      _addTodoController.text = "";
      Navigator.of(context, rootNavigator: true).pop();
      await Todo.addTodo(UserModel.email!, currentTodos!);
    }
  }

  Future<void> _updateTodo(index) async {
    if (_updateformKey.currentState!.validate()) {
      currentTodos![index] = _updateTodoController.text;
      setState(() {});
      Navigator.of(context, rootNavigator: true).pop();
      _updateTodoController.text = "";
      await Todo.addTodo(UserModel.email!, currentTodos!);
    }
  }

  Future<void> _logout(context) async {
    bool isLogout = await UserModel.logout();
    if (isLogout) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
    }
  }

  Future<void> _deleteTodo(index) async {
    currentTodos!.removeAt(index);
    setState(() {});
    Navigator.of(context, rootNavigator: true).pop();
    await Todo.addTodo(UserModel.email!, currentTodos!);
  }

  @override
  void initState() {
    Todo.getTodos(UserModel.email!).then((value) {
      setState(() {
        currentTodos = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context, () => _logout(context)),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: currentTodos?.length,
              itemBuilder: (context, index) {
                return MyListTile(
                  title: currentTodos![index],
                  index: index,
                  updateTodoController: _updateTodoController,
                  formKey: _updateformKey,
                  updateTodo: _updateTodo,
                  deleteTodo: _deleteTodo,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: Color(colors['theme']!),
        tooltip: constTexts['add_todo']!.toUpperCase(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
