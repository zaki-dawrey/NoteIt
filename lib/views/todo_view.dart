import 'package:flutter/material.dart';
import 'package:flutter_application_1/enums/menu_action.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_1/utilities/dialogs/logout_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
 State<TodoListView>  createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  late SharedPreferences _prefs;
  Set<int> _completedTodoItems = {};
  List<String> _todoList = [];

  // ignore: unused_field
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _loadTodoList();
      });
    });
  }

  void _loadTodoList() {
    final todoList = _prefs.getStringList('todoList') ?? [];
    final completedTodoItems = _prefs.getStringList('completedTodoItems') ?? [];
    setState(() {
      _todoList = todoList;
      _completedTodoItems = completedTodoItems.map(int.parse).toSet();
    });
  }

  void _addTodoItem(String todoItem) {
    setState(() {
      _todoList.add(todoItem);
      _prefs.setStringList('todoList', _todoList);
    });
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
      _completedTodoItems.remove(index);
      _prefs.setStringList('todoList', _todoList);
      _prefs.setStringList('completedTodoItems',
          _completedTodoItems.map((index) => index.toString()).toList());
    });
  }

  bool _isTodoItemCompleted(int index) {
    return _completedTodoItems.contains(index);
  }

  void _toggleTodoItemCompletion(int index) {
    setState(() {
      if (_completedTodoItems.contains(index)) {
        _completedTodoItems.remove(index);
      } else {
        _completedTodoItems.add(index);
      }
      _prefs.setStringList('completedTodoItems',
          _completedTodoItems.map((index) => index.toString()).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        backgroundColor: Color.fromRGBO(140, 162, 217, 1),
        title: const Text('NoteIt'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  // ignore: use_build_context_synchronously
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                }
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text('Log Out'),
              ),
            ];
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: _isTodoItemCompleted(index),
                      onChanged: (value) {
                        _toggleTodoItemCompletion(index);
                      },
                      activeColor: const Color.fromRGBO(140, 162, 217, 1),
                    ),
                    title: Text(
                      _todoList[index],
                      style: TextStyle(
                        decoration: _isTodoItemCompleted(index)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _removeTodoItem(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              // ignore: no_leading_underscores_for_local_identifiers
              final TextEditingController _textEditingController =
                  TextEditingController();
              return AlertDialog(
                title: const Text('Add Todo Item'),
                content: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a todo item',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final todoItem = _textEditingController.text;
                      // ignore: unnecessary_null_comparison
                      if (todoItem == null || todoItem.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Todo item cannot be empty'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        _addTodoItem(todoItem);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: const Color.fromRGBO(140, 162, 217, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
