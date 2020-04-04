import 'package:appuniversitario/src/pages/home_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudentsTasks',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage()
      },
    );
  }
}