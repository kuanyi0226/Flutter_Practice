import 'package:flutter/material.dart';

import './colors.dart';
import '../screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: subColor),
          scaffoldBackgroundColor: mainColor),
    );
  }
}
