import 'package:flutter/material.dart';

import '../services/todo_service.dart';
import '../models/todo.dart';
import '../src/colors.dart';

class TodosByCateg extends StatefulWidget {
  String? category;
  TodosByCateg({this.category});

  @override
  State<TodosByCateg> createState() => _TodosByCategState();
}

class _TodosByCategState extends State<TodosByCateg> {
  List<Todo> _todoList = <Todo>[];
  TodoService _todoService = TodoService();

  @override
  initState() {
    super.initState();
    getTodosByCtg();
  }

  getTodosByCtg() async {
    var todos = await _todoService.readTodosByCateg(this.widget.category);
    setState(() {
      todos.forEach((todo) {
        var model = Todo();
        model.title = todo['title'];
        model.description = todo['description'];
        model.todoDate = todo['todoDate'];

        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${this.widget.category}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 16.0, right: 16.0),
                    child: Card(
                      color: subColor,
                      elevation: 16.0,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _todoList[index].title ?? 'No Title',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            )
                          ],
                        ),
                        subtitle: Text(
                          _todoList[index].description ?? 'No Description',
                          style: TextStyle(
                              color: Color.fromARGB(255, 207, 205, 205)),
                        ),
                        trailing: Text(
                          _todoList[index].todoDate ?? 'No Date',
                          style: TextStyle(
                              color: Color.fromARGB(255, 207, 205, 205)),
                        ),
                      ),
                    ),
                  );
                }))
      ]),
    );
  }
}
