import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/login.dart';
import './temp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Initialisation(),
        '/home':(context) =>const  Home(),
        '/login':(context) => const LogIn(),
      },
    );
  }
}
