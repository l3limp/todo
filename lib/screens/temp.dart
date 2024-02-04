import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo/theme.dart';

var auth = FirebaseAuth.instance;

class Initialisation extends StatefulWidget {
  const Initialisation({Key? key}) : super(key: key);

  @override
  State<Initialisation> createState() => _InitialisationState();
}

class _InitialisationState extends State<Initialisation>
    with SingleTickerProviderStateMixin {
  bool comp = false;
  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  );
  late final Animation<Offset> offsetAnimation1 = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn,
  ));
  late final Animation<Offset> offsetAnimation2 = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn,
  ));

  @override
  void initState() {
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    timeDilation = 2;
    OurTheme theme = OurTheme();
    return SafeArea(
      child: Scaffold(
          backgroundColor: theme.primaryColor,
          body: SizedBox(
            height: height,
            width: width,
            child: Row(
              children: [
                Container(
                    height: height,
                    width: width * 0.6,
                    color: theme.primaryColor,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: height * 0.7,
                        child: AnimationLimiter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 1200),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                horizontalOffset: -50.0,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                              children: [
                                const Text(
                                  "To-Do",
                                  style: TextStyle(
                                      fontSize: 48.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                const Text(
                                  "The simplest to-do app ever",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100),
                                ),
                                SizedBox(
                                  height: height * 0.2,
                                ),
                                FutureBuilder(
                                    future: Firebase.initializeApp(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (auth.currentUser == null) {
                                          return ElevatedButton(
                                              onPressed: () async {
                                                // Trigger the authentication flow
                                                final GoogleSignInAccount?
                                                    googleUser =
                                                    await GoogleSignIn()
                                                        .signIn();

                                                // Obtain the auth details from the request
                                                final GoogleSignInAuthentication?
                                                    googleAuth =
                                                    await googleUser
                                                        ?.authentication;

                                                // Create a new credential
                                                final credential =
                                                    GoogleAuthProvider
                                                        .credential(
                                                  accessToken:
                                                      googleAuth?.accessToken,
                                                  idToken: googleAuth?.idToken,
                                                );

                                                // Once signed in, return the UserCredential
                                                await FirebaseAuth.instance
                                                    .signInWithCredential(
                                                        credential)
                                                    .then((value) async => {
                                                          auth = FirebaseAuth
                                                              .instance,
                                                          Navigator
                                                              .popAndPushNamed(
                                                                  context,
                                                                  '/home'),
                                                        });
                                              },
                                              child:
                                                  const Text("Let's do it!"));
                                        } else {
                                          return ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context, '/home');
                                              },
                                              child:
                                                  const Text("Let's do it!"));
                                        }
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                SlideTransition(
                  position: offsetAnimation1,
                  child: Container(
                      height: height,
                      width: width * 0.2,
                      color: theme.secondaryColor.withOpacity(0.5)),
                ),
                SlideTransition(
                  position: offsetAnimation2,
                  child: Container(
                      height: height,
                      width: width * 0.2,
                      color: theme.secondaryColor),
                ),
              ],
            ),
          )),
    );
  }
}
