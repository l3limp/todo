import 'package:flutter/material.dart';
import 'package:todo/screens/add.dart';
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
        '/add': (context) => const AddCard(),
      },
    );
  }
}
