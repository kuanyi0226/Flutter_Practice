import 'package:flutter/material.dart';

import './database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(primaryColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _itemList = [];
  bool _isLoading = true;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshItems();
    print('Number of items: ${_itemList.length}');
  }

  void _refreshItems() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _itemList = data;
      _isLoading = false;
    });
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshItems();
    print(_itemList.length);
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshItems();
    print(_itemList.length);
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully deleted an item')));
    _refreshItems();
  }

  void showEditField(int? id) async {
    //For Edit: id != null, read the info to textfield
    if (id != null) {
      final exsistingItem =
          _itemList.firstWhere((element) => element['id'] == id);
      _titleController.text = exsistingItem['title'];
      _descriptionController.text = exsistingItem['description'];
    }

    //For Edit and Create(id == null)
    showModalBottomSheet(
      context: context,
      elevation: 5,
      builder: (_) => Container(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (id == null) {
                  await _addItem();
                } else {
                  await _updateItem(id);
                }

                //Clear the text_field
                _titleController.text = '';
                _descriptionController.text = '';

                Navigator.of(context).pop();
              },
              child: Text((id == null) ? 'Create New' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Bar
      appBar: AppBar(
        title: Text('Database Test'),
      ),
      //ListView
      body: (_itemList.length == 0)
          ? Container()
          : Container(
              child: ListView.builder(
                itemCount: _itemList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_itemList[index]['title']),
                  subtitle: Text(_itemList[index]['description']),
                  trailing: SizedBox(
                    //must wrap the Row Widget(cuz it's in a ListView)
                    width: 100,
                    child: Row(children: [
                      //Edit Button
                      IconButton(
                        onPressed: () => showEditField(_itemList[index]['id']),
                        icon: Icon(Icons.edit),
                      ),
                      //Delete Button
                      IconButton(
                        onPressed: () => _deleteItem(_itemList[index]['id']),
                        icon: Icon(Icons.delete),
                      ),
                    ]),
                  ),
                ),
              ),
            ),

      //Button
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showEditField(null),
      ),
    );
  }
}
