import 'package:flutter/material.dart';
import 'package:project4_todolist/models/category.dart';
import 'package:project4_todolist/services/category_service.dart';

import './home_screen.dart';
import '../src/colors.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  //Controller: Read the input of new Category's Name&Description
  var _categoryNameController = TextEditingController();
  var _categoryDescripController = TextEditingController();

  var category; // for editing categ
  var _editNameController = TextEditingController();
  var _editDescripController = TextEditingController();

  //Save the input(Name, Description) as a category instance
  var _tempCategory = Category();
  //Some Services to do with the category
  var _categoryService = CategoryService();

  //Get all categories from repository
  List<Category> _categList = <Category>[]; //List.list is deprecated

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getAllCateg();
  }

  getAllCateg() async {
    _categList = <Category>[];
    var categories = await _categoryService.readCategories();
    //setState() outside forEach: even no category returned from database, still setstate
    setState(() {
      categories.forEach((categ) {
        var categModel = Category();
        categModel.id = categ['id'];
        categModel.name = categ['name'];
        categModel.description = categ['description'];
        _categList.add(categModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editNameController.text = category[0]['name'] ?? 'No Name';
      _editDescripController.text =
          category[0]['description'] ?? 'No Description';
    });
    _editDialog(context);
  }

  //Showing up the Dialog(widget) to add new category
  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (para) {
          return AlertDialog(
            title: Text('New Catogary'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //Enter new category
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                      hintText: 'Write a Category',
                      labelText: 'Category',
                    ),
                  ),
                  //Enter description
                  TextField(
                    controller: _categoryDescripController,
                    decoration: InputDecoration(
                      hintText: 'Write a description',
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              //Save Button
              TextButton(
                //Tap save to read the input of Name & Description
                onPressed: () async {
                  _tempCategory.name = _categoryNameController.text;
                  _tempCategory.description = _categoryDescripController.text;
                  var result =
                      await _categoryService.saveCategory(_tempCategory);
                  print(result); //id
                  Navigator.pop(context);
                  getAllCateg(); //refresh the list again to show result
                  //Clean input field
                  _categoryNameController.text = '';
                  _categoryDescripController.text = '';
                  _showSuccessSnackBar('Saved successfully!');
                },
                child: Text('Save', style: TextStyle(color: mainColor)),
              ),
              //Cancel Button
              TextButton(
                onPressed: () {
                  //Clean the input
                  _categoryNameController.text = '';
                  _categoryDescripController.text = '';
                  //pop out the dialog
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: mainColor)),
              ),
            ],
          );
        });
  }

  //Showing up the Dialog to edit categ
  _editDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (para) {
          return AlertDialog(
            title: Text('Edit Catogary'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //Edit category
                  TextField(
                    controller: _editNameController,
                    decoration: InputDecoration(
                      hintText: 'Write a Category',
                      labelText: 'Category',
                    ),
                  ),
                  //Edit description
                  TextField(
                    controller: _editDescripController,
                    decoration: InputDecoration(
                      hintText: 'Write a description',
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              //Edit Button
              TextButton(
                //Tap save to read the input of Name & Description
                onPressed: () async {
                  _tempCategory.id = category[0]['id'];
                  _tempCategory.name = _editNameController.text;
                  _tempCategory.description = _editDescripController.text;
                  var result =
                      await _categoryService.updateCategory(_tempCategory);
                  _editNameController.text = '';
                  _editDescripController.text = '';
                  Navigator.pop(context);
                  _showSuccessSnackBar('Updated successfully!');
                  getAllCateg();
                },
                child: Text('Update', style: TextStyle(color: mainColor)),
              ),
              //Cancel Button
              TextButton(
                onPressed: () {
                  //Clean the input
                  _editNameController.text = '';
                  _editDescripController.text = '';
                  //pop out the dialog
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: mainColor)),
              ),
            ],
          );
        });
  }

  //Showing up the Dialog delete categ
  _deleteDialog(BuildContext context, int categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (para) {
          return AlertDialog(
            title: Text('Sure to delete this catogary?'),
            actions: <Widget>[
              //Delete Button
              TextButton(
                //Tap save to read the input of Name & Description
                onPressed: () async {
                  var result =
                      await _categoryService.deleteCategory(categoryId);

                  _editNameController.text = '';
                  _editDescripController.text = '';
                  Navigator.pop(context);
                  _showSuccessSnackBar('Deleted successfully!');
                  getAllCateg();
                },
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
              //Cancel Button
              TextButton(
                onPressed: () {
                  //Clean the input
                  _editNameController.text = '';
                  _editDescripController.text = '';
                  //pop out the dialog
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: mainColor)),
              ),
            ],
          );
        });
  }

  //Showing up a temp message
  _showSuccessSnackBar(String message) {
    var _snackBar = SnackBar(content: Text(message));
    _globalKey.currentState!.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        //Button for back to home
        leading: ElevatedButton(
          child: Icon(Icons.arrow_back),
          style: ElevatedButton.styleFrom(primary: subColor),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen())),
        ),
        title: Text('Categories'),
      ),
      //Build all the categories as Card list
      body: ListView.builder(
          itemCount: _categList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 16.0,
                child: ListTile(
                  //Edit button
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () =>
                        _editCategory(context, _categList[index].id),
                  ),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _categList[index].name!,
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () =>
                                _deleteDialog(context, _categList[index].id!),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ]),
                  subtitle: Text(
                    _categList[index].description!,
                    style: TextStyle(color: Color.fromARGB(255, 207, 205, 205)),
                  ),
                ),
                color: subColor,
              ),
            );
          }),
      //Add Button
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: subColor,
        onPressed: () {
          _showDialog(context);
        },
      ),
    );
  }
}
