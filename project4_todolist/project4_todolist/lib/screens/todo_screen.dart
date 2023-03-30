import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //Date format

import '../models/category.dart';
import '../services/category_service.dart';
import '../src/colors.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();
  var _todoDescripController = TextEditingController();
  var _todoDateController = TextEditingController();

  var _selectedValue;
  List<DropdownMenuItem> _categories = <DropdownMenuItem>[];

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((categ) {
      setState(() {
        _categories.add(DropdownMenuItem<String>(
          child: Text(
            categ['name'],
            style: TextStyle(color: Colors.white),
          ),
          value: categ['name'],
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  //Dealing with date format
  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;

        _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  _showSuccessSnackBar(String message) {
    var _snackBar = SnackBar(content: Text(message));
    _globalKey.currentState!.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(
          'Create Todo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          //Enter title
          TextField(
            controller: _todoTitleController,
            style: TextStyle(color: Colors.grey),
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Write Todo Title',
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          //Enter Description
          TextField(
            controller: _todoDescripController,
            style: TextStyle(color: Colors.grey),
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Write Todo Description',
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          //Enter Date
          TextField(
            controller: _todoDateController,
            style: TextStyle(color: Colors.grey),
            decoration: InputDecoration(
              labelText: 'Date',
              hintText: 'Pick a Date',
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              prefixIcon: InkWell(
                onTap: () => _selectedTodoDate(context),
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          //Select a category by pull down button
          DropdownButtonFormField<dynamic>(
            dropdownColor: subColor,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            value: _selectedValue,
            items: _categories,
            hint: Text('Category', style: TextStyle(color: Colors.white)),
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
          ),

          //For blanks
          SizedBox(height: 30),

          //Save Button
          ElevatedButton(
            onPressed: () async {
              var todoObject = Todo();

              todoObject.title = _todoTitleController.text;
              todoObject.description = _todoDescripController.text;
              todoObject.isFinished = 0;
              todoObject.category = _selectedValue.toString();
              todoObject.todoDate = _todoDateController.text;

              var _todoService = TodoService();
              var result = await _todoService.saveTodo(todoObject);
              if (result > 0) {
                _showSuccessSnackBar('Created Successfully!');
              }

              print(result);
            },
            child: Text('Save'),
            style: ElevatedButton.styleFrom(primary: subColor),
          )
        ]),
      ),
    );
  }
}
