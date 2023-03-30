import 'package:flutter/material.dart';
import 'package:project4_todolist/models/todo.dart';

import '../src/colors.dart';
import '../helpers/drawer_navigation.dart';
import './todo_screen.dart';
import '../src/app.dart';
import '../services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService? _todoService;
  List<Todo> _todoList = <Todo>[];

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todoService = TodoService();
    _todoList = <Todo>[];

    var todos = await _todoService!.readTodos();

    setState(() {
      todos.forEach((todo) {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Useful ToDo List'),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                  color: subColor,
                  elevation: 16.0,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _todoList[index].title ?? 'No Title',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        )
                      ],
                    ),
                    subtitle: Text(
                      _todoList[index].category ?? 'No Category',
                      style:
                          TextStyle(color: Color.fromARGB(255, 207, 205, 205)),
                    ),
                    trailing: Text(
                      _todoList[index].todoDate ?? 'No Date',
                      style:
                          TextStyle(color: Color.fromARGB(255, 207, 205, 205)),
                    ),
                  )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: subColor,
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TodoScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
