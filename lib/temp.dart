import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';

class Initialisation extends StatelessWidget {
  const Initialisation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Firebase.initializeApp(
              // options: DefaultFirebaseOptions.currentPlatform,
              ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // final FirebaseAuth auth = FirebaseAuth.instance;
              return const Home();
            } else {
              return const Text("Firebase not working");
            }
          },
        ),
      ),
    );
  }
}
