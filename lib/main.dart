import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/theme.dart';
import 'screens/temp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: OurTheme().font),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Initialisation(),
        '/home': (context) => const Home(),
      },
    );
  }
}
