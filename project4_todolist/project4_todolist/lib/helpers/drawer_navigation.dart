import 'package:flutter/material.dart';

import '../src/colors.dart';
import '../screens/home_screen.dart';
import '../screens/categories_screen.dart';
import '../services/category_service.dart';
import '../screens/todos_by_categ.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = <Widget>[];
  CategoryService _categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
    getAllCateg();
  }

  getAllCateg() async {
    var categories = await _categoryService.readCategories();
    setState(() {
      categories.forEach((categ) {
        _categoryList.add(InkWell(
          onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new TodosByCateg(
                        category: categ['name'],
                      ))),
          child: ListTile(
            title: Text(categ['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: subColor),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.discogs.com/EnmMB9PSbTyAdBxFKZPYJ9ZtwLpJT963p2fjA3ivhWA/rs:fit/g:sm/q:40/h:300/w:300/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTYxOTAy/NTAtMTQxMzMwMjE1/MC0zNTQ2LmpwZWc.jpeg'),
                ),
                accountName: Text('Kevin He'),
                accountEmail: Text('miyukilover@gmail.com')),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
            Divider(),
            Column(
              children: _categoryList,
            )
          ],
        ),
      ),
    );
  }
}
