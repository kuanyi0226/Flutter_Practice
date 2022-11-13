import 'package:flutter/material.dart';

import '../src/colors.dart';
import '../screens/home_screen.dart';
import '../screens/categories_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
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
          ],
        ),
      ),
    );
  }
}
