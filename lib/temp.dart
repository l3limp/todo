import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/login.dart';

class Initialisation extends StatelessWidget {
  const Initialisation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                return const LogIn();
              } else {
                return const Home();
              }
            } else {
              return const Text("Firebase not working");
            }
          },
        ),
      ),
    );
  }
}
