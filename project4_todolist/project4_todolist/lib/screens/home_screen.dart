import 'package:flutter/material.dart';
import 'package:project4_todolist/helpers/drawer_navigation.dart';
import 'package:project4_todolist/src/app.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Useful ToDo List'),
      ),
      drawer: DrawerNavigation(),
    );
  }
}
